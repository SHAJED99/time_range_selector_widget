import 'package:flutter/material.dart';
import 'package:time_range_selector_widget/time_range_selector_widget.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final initialValue = 2;
  final minTime = 2;
  final maxTime = 12;
  final double stockWidth = 24 * 2;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 300,
            height: 300,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.05),
                    Colors.black.withOpacity(0.1)
                  ],
                ),
              ),
              child: TimeRangeSelectorWidget(
                initialTime: initialValue,
                minTime: minTime,
                maxTime: maxTime,
                // depth: 5,
                shadowColorDark: Theme.of(context).shadowColor.withOpacity(0.5),
                shadowColorLight: Theme.of(context).canvasColor,
                // shadowColorDark: Theme.of(context).primaryColor.withOpacity(0.5),
                // shadowColorLight: Theme.of(context).canvasColor,
                childBuilder: (currentTime) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.05),
                          Colors.black.withOpacity(0.1)
                          // Colors.amber,
                          // Colors.amberAccent,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(currentTime.toString(),
                              style: const TextStyle(
                                  fontSize: 70,
                                  fontWeight: FontWeight.bold,
                                  height: 1)),
                          Text(currentTime > 1 ? "Hours" : "Hour",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),

                    // child: Center(
                    //   child: Column(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       Text((currentTime * 5).toString(), style: const TextStyle(fontSize: 70, fontWeight: FontWeight.bold, height: 1)),
                    //       Text(currentTime > 0 ? "Minutes" : "Minute", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                    //     ],
                    //   ),
                    // ),
                  );
                },
                // backgroundColor: Colors.amberAccent,
                // stockColor: Colors.purple,
                // handleColor: Colors.amber,
                // stockWidth: stockWidth,
                // handlePadding: 24,
                // handleColor: Colors.amber,
                // handleBuilder: (itemIndex, offset) {
                //   return Container(
                //     width: stockWidth - 8,
                //     height: stockWidth - 8,
                //     padding: const EdgeInsets.all(8),
                //     decoration: const BoxDecoration(
                //       color: Colors.white,
                //       shape: BoxShape.circle,
                //     ),
                //     child: FittedBox(child: Text((itemIndex + minTime).toString(), style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold))),
                //   );
                // },

                // positionalDotSize: 24,
                // positionalDotColor: Colors.black54,
                // positionalDotBuilder: (itemIndex, offset) {
                //   return Container(
                //     child: FittedBox(child: Text((itemIndex + minTime).toString())),
                //   );
                // },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
