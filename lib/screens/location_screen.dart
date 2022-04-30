import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key, @required this.locationWeather})
      : super(key: key);

  final locationWeather;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late double temperature;
  late String weatherIcon;
  late String cityName;
  late String weatherMessage;

  void changeUi(weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
      temperature = weatherData['main']['temp'];
      cityName = weatherData['name'];
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature.toInt());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ignore: prefer_const_constructors
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    changeUi(widget.locationWeather);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'images/sunny.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.height * 0.08,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: IconButton(
                        onPressed: () async {
                          var weatherData = await weather.getLocationWeather();
                          changeUi(weatherData);
                        },
                        icon: Icon(
                          Icons.near_me,
                          size: MediaQuery.of(context).size.height * 0.07,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.height * 0.08,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: IconButton(
                        onPressed: () async {
                          var typeName = await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CityScreen();
                          }));
                          if (typeName != null) {
                            var weatherData =
                                await weather.getCityWeather(typeName);
                            changeUi(weatherData);
                          }
                        },
                        icon: Icon(
                          Icons.search,
                          size: MediaQuery.of(context).size.height * 0.07,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, top: 5.0),
              child: Row(
                children: [
                  Text(
                    weatherIcon,
                    style: const TextStyle(
                      fontSize: 80,
                    ),
                  ),
                  Text(
                    temperature.toInt().toString() + '\u00b0',
                    style: const TextStyle(
                        fontSize: 100, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                weatherMessage + " in " + cityName,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
