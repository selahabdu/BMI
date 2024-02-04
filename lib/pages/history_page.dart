import 'package:bmi/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  double? deviceHeight, deviceWidth;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(
      child: Center(
        child: historyCard(),
      ),
    );
  }

  Widget historyCard() {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final _prefs = snapshot.data as SharedPreferences;
          final date = _prefs.getString('bmi_date');
          final data = _prefs.getStringList('bmi_data');
          return CustomCard(
            height: deviceHeight! * 0.25,
            width: deviceWidth! * 0.85,
            content: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                statusText(data![1]),
                dateText(date!),
                bmiText(data[0]),
              ],
            ),
          );
        } else {
          return const Center(
              child: CupertinoActivityIndicator(
            color: Colors.blue,
          ));
        }
      },
    );
  }

  Widget statusText(String status) {
    return Text(
      status,
      style: const TextStyle(
          color: Colors.black, fontSize: 30, fontWeight: FontWeight.w400),
    );
  }

  Widget dateText(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return Text(
      '${parsedDate.day} / ${parsedDate.month} / ${parsedDate.year}',
      style: const TextStyle(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.w300),
    );
  }

  Widget bmiText(String bmi) {
    return Text(
      double.parse(bmi).toStringAsFixed(2),
      style: const TextStyle(
          color: Colors.black, fontSize: 60, fontWeight: FontWeight.w600),
    );
  }
}
