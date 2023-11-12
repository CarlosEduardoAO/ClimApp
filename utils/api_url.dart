import 'package:weatherapp/api/api_key.dart';

String apiURL(lat, lon) {
  String url;

  url =
      "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric&exclude=minuely";

  return url;
}
