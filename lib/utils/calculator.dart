import 'dart:math';

import 'package:dio/dio.dart';

double calculateBMI(int height, int weight) {
  return weight / (pow((height / 100), 2));
}

// added to moke test using moktail
Future<double> calculateBMIAsync(Dio dio) async {
  var result = await dio.get('https://www.jsonkeeper.com/b/0HDK');
  var data = result.data;
  var bmi = calculateBMI(data['Selhadin Abdu'][1], data['Selhadin Abdu'][0]);
  return bmi;
}
