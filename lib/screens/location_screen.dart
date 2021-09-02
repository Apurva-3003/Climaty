import 'package:climaty/screens/city_screen.dart';
import 'package:climaty/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:climaty/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature;
  String weatherIcon;
  String cityName;
  String message;
  WeatherModel weather = new WeatherModel();

  @override
  void initState() {
    super.initState();
    updateUI(weatherData: widget.locationWeather);
  }

  void updateUI({weatherData}) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        message = 'Unable to get weather data';
        cityName = '';
        weatherIcon = 'Error';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      message = weather.getMessage(temperature);
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition: condition);
      cityName = weatherData['name'];
    });
  }

///////////////////////////////////////////////////////////////////////////////////UI design:
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jfif'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData: weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        print('the city is $typedName');
                        var weatherData = await weather.getCityWeather(typedName);
                        updateUI(weatherData: weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text("$message in $cityName!",
                    textAlign: TextAlign.right, style: kMessageTextStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
