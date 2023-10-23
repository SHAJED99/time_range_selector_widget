import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:time_range_selector_widget/time_range_selector_widget.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            alignment: Alignment.center,
            height: 300,
            width: 300,
            child: TimeRangeSelectorWidget(
              initialTime: 2,
              maxTime: 10,
              stockColor: Colors.green,
              shadowColorLight: Colors.white.withOpacity(0.5),
              shadowColorDark: Theme.of(context).shadowColor.withOpacity(0.5),
              colorGradient: const [
                Color(0xFFF5F5F9),
                Color(0xFFE4E8EE),
              ],
              backgroundColor: const [
                Color(0xFFF5F5F9),
                Color(0xFFE4E8EE),
              ],
              onChangeValue: (currentTime) {
                if (kDebugMode) print(currentTime);
              },
              childBuilder: (currentTime) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(currentTime.toString(), style: const TextStyle(fontSize: 70, fontWeight: FontWeight.bold, height: 1)),
                      Text(currentTime > 1 ? "Hours" : "Hour", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
