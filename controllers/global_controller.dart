import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weatherapp/api/fetch_weather.dart';
import 'package:weatherapp/model/weather_data.dart';

class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _lattitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;

  RxBool checkLoading() => _isLoading;
  RxDouble getLattitude() => _lattitude;
  RxDouble getLongitude() => _longitude;

  final weatherData = WeatherData().obs;

  WeatherData getWeather() {
    return weatherData.value;
  }

  @override
  void onInit() {
    if (_isLoading.isTrue) getLocation();
    super.onInit();
  }

  getLocation() async {
    bool isServerEnable;
    LocationPermission locationPermission;
    isServerEnable = await Geolocator.isLocationServiceEnabled();

    if (isServerEnable) {
      return Future.error("Location service is not enabled");
    }

    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location service is denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location service is denied");
      }
    }

    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      _lattitude.value = value.latitude;
      _longitude.value = value.longitude;

      return FetchWeatherAPI()
          .processData(value.latitude, value.longitude)
          .then((value) {
        weatherData.value = value;
        _isLoading.value = false;
      });
    });
  }

  RxInt getIndex() {
    return _currentIndex;
  }
}
