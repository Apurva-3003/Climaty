import 'package:http/http.dart' as http;
import 'dart:convert';

//this class takes a url and returns the desired info(value) after decoding from jSON
class NetworkHelper {

  //constructor
  NetworkHelper(this.url);
  final String url;

  Future getData() async {
    //Response is a class that exists in http package
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      //if the url is valid, return the desired values after decoding
      String data = response.body;
      //jsonDecode() method can only be used after importing dart:convert
      return jsonDecode(data);
    } else {
      //if the url is not valid, show the error code
      print(response.statusCode);
    }
  }
}
