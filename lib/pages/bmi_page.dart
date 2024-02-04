import 'dart:math';

import 'package:bmi/pages/main_page.dart';
import 'package:bmi/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BMIPage extends StatefulWidget {
  const BMIPage({super.key});

  @override
  State<BMIPage> createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  double? deviceHeight, deviceWidth;
  int age = 22, weight = 75, height = 178, gender = 0;
  String category = 'Normal';
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: CupertinoPageScaffold(
        child: Center(
          child: SizedBox(
            height: deviceHeight! * .85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _ageSelectCard(),
                    _weightSelectCard(),
                  ],
                ),
                _heightSelectCard(),
                _genderSelectCard(),
                _calculateBMIButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _ageSelectCard() {
    return CustomCard(
      height: deviceHeight! * 0.20,
      width: deviceWidth! * 0.45,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Age yr',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
          ),
          Text(
            age.toString(),
            style: const TextStyle(
                fontSize: 45, fontWeight: FontWeight.w700, color: Colors.black),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  onPressed: () {
                    setState(() {
                      age--;
                    });
                  },
                  textStyle: const TextStyle(fontSize: 25, color: Colors.red),
                  child: const Text('-'),
                ),
              ),
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  onPressed: () {
                    setState(() {
                      age++;
                    });
                  },
                  textStyle: const TextStyle(fontSize: 20, color: Colors.blue),
                  child: const Text('+'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _weightSelectCard() {
    return CustomCard(
      height: deviceHeight! * 0.20,
      width: deviceWidth! * 0.45,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Weight kg',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
          ),
          Text(
            weight.toString(),
            style: const TextStyle(
                fontSize: 45, fontWeight: FontWeight.w700, color: Colors.black),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  onPressed: () {
                    setState(() {
                      weight--;
                    });
                  },
                  textStyle: const TextStyle(fontSize: 25, color: Colors.red),
                  child: const Text('-'),
                ),
              ),
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  onPressed: () {
                    setState(() {
                      weight++;
                    });
                  },
                  textStyle: const TextStyle(fontSize: 20, color: Colors.blue),
                  child: const Text('+'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _heightSelectCard() {
    return CustomCard(
      height: deviceHeight! * 0.20,
      width: deviceWidth! * 0.90,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Height cm',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
          ),
          Text(
            height.toString(),
            style: const TextStyle(
                fontSize: 45, fontWeight: FontWeight.w700, color: Colors.black),
          ),
          SizedBox(
            width: deviceWidth! * 0.80,
            child: CupertinoSlider(
              value: height.toDouble(),
              min: 0,
              max: 280,
              divisions: 280,
              onChanged: (double value) {
                setState(() {
                  height = value.toInt();
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _genderSelectCard() {
    return CustomCard(
      height: deviceHeight! * 0.11,
      width: deviceWidth! * 0.90,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text(
            'Gender',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
          ),
          CupertinoSlidingSegmentedControl(
            groupValue: gender,
            children: const {
              0: Text("Male"),
              1: Text("Female"),
            },
            onValueChanged: (value) {
              setState(() {
                gender = value as int;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _calculateBMIButton() {
    return SizedBox(
      height: deviceHeight! * 0.08,
      child: CupertinoButton.filled(
        child: const Text("Calculate BMI"),
        onPressed: () {
          double bmi = weight / (pow((height / 100), 2));
          if (height > 0 && weight > 0 && age > 0) {
            _showResultDialog(bmi);
          }
        },
      ),
    );
  }

  void _showResultDialog(double bmi) {
    if (bmi < 18.5) {
      category = "Underweight";
    } else if (bmi >= 18.5 && bmi < 25) {
      category = "Normal";
    } else if (bmi >= 25 && bmi < 30) {
      category = "Overweight";
    } else {
      category = "Obese";
    }
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(category),
            content: Text(bmi.toStringAsFixed(2)),
            actions: [
              CupertinoDialogAction(
                child: const Text('Ok'),
                onPressed: () {
                  _saveResult(bmi.toString(), category);
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => MainPage(),
                    ),
                  );
                },
              ),
            ],
          );
        });
  }

  void _saveResult(String bmi, String category) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(
        'bmi_date',
        DateTime.now()
            .toString()); // shared preference has only small data type range
    await preferences.setStringList('bmi_data', <String>[bmi, category]);
  }
}
