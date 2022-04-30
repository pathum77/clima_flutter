import 'package:geolocator/geolocator.dart';
import 'networking.dart';

const apiKey = '6f59ed1e9700a3e83552b86a343faab4';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';

    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: true,
        desiredAccuracy: LocationAccuracy.low);

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩️';
    } else if (condition < 400) {
      return '⛈️';
    } else if (condition < 600) {
      return '🌧️';
    } else if (condition < 700) {
      return '❄️';
    } else if (condition < 800) {
      return '☁️';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '⛅';
    } else {
      return '🤷‍♂️';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 👚 and 🧤';
    } else {
      return '🧥';
    }
  }
}
