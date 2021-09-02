import 'package:climaty/services/networking.dart';
import 'package:climaty/services/location.dart';

const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
const apiKey = '50fd2e58cf892a79072ac5fec48007f2';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future getLocationWeather() async {
    Location location = new Location();
    //the following line (method) gets the geographical coordinates of the location
    //we use "await" on this line because it needs to happen before latitude / longitude are assigned values
    await location.getCurrentLocation();

    //object of class "NetworkHelper" is created by providing a url
    NetworkHelper networkHelper = new NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon({int condition}) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a coat just in case';
    }
  }
}
