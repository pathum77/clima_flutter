// ignore_for_file: deprecated_member_use

import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';

class CityScreen extends StatelessWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String cityName;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/searchCityBg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 40.0,
                right: 10.0,
                left: 10.0,
              ),
              child: TextFormField(
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: kTextFieldInputDecoration,
                onChanged: (value) {
                  cityName = value;
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 1.0,
              child: FlatButton(
                onPressed: () {
                    Navigator.pop(context, cityName);  
                },
                child: const Text(
                  'GET WEATHER',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
