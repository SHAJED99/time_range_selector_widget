import 'package:flutter/material.dart';
import 'package:time_range_selector_widget/time_range_selector_widget.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int initialValue = 2;
  int minTime = 2;
  int maxTime = 12;
  int tab = 0;

  _tabDataSet(bool isFirst) {
    if (isFirst) {
      initialValue = 3;
      minTime = 2;
      maxTime = 12;
    } else {
      initialValue = 4;
      minTime = 1;
      maxTime = 12;
    }
  }

  Brightness b = Brightness.light;

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: tab);
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: b,
        ),
        buttonTheme: const ButtonThemeData(height: 48),
      ),
      home: Builder(builder: (context) {
        return Scaffold(
          floatingActionButton: FloatingActionButton.small(onPressed: () {
            setState(() {
              b = b == Brightness.light ? Brightness.dark : Brightness.light;
            });
          }),
          body: Center(
            child: SizedBox(
              width: 300,
              height: 300,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.1)
                    ],
                  ),
                ),
                child: TimeRangeSelectorWidget(
                  key: GlobalKey(),
                  initialTime: initialValue,
                  maxTime: maxTime,
                  minTime: minTime,
                  onChangeValue: (i) {},
                  positionalDotBuilder: (i, __) {
                    // return Text(
                    //   i.toString(),
                    //   style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
                    // );

                    return null;
                  },
                  handleBuilder: (i, _) {
                    // return null;
                    return Container(
                      alignment: Alignment.center,
                      height: 24 * 1.5,
                      width: 24 * 1.5,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        shape: BoxShape.circle,
                      ),
                      child: Text(i.toString()),
                    );
                  },
                  childBuilder: (i) {
                    debugPrint(i.toString());
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.05),
                            Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.1)
                          ],
                        ),
                      ),
                      child: PageView(
                        controller: controller,
                        onPageChanged: (i) {
                          tab = i;
                          _tabDataSet(i == 0);
                          controller
                              .animateToPage(tab,
                                  duration: const Duration(milliseconds: 100),
                                  curve: Curves.linear)
                              .whenComplete(() => setState(() {}));
                        },
                        children: [
                          Container(
                            alignment: Alignment.center,
                            // color: Colors.black,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.05),
                                  Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.1)
                                ],
                              ),
                            ),
                            child: Text(i.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                          ),
                          Container(
                            alignment: Alignment.center,
                            // color: Colors.green,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [
                                  Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.05),
                                  Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.1)
                                ],
                              ),
                            ),
                            child: Text(i.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                          ),
                        ],
                      ),
                    );
                  },
                  // positionalDotColor: Theme.of(context).colorScheme.primaryContainer,
                  // initialTime: initialValue,
                  // minTime: minTime,
                  // maxTime: maxTime,
                  // depth: 5,
                  // shadowColorDark: Theme.of(context).shadowColor.withOpacity(0.5),
                  // shadowColorLight: Theme.of(context).canvasColor,
                  // shadowColorDark: Theme.of(context).primaryColor.withOpacity(0.5),
                  // shadowColorLight: Theme.of(context).canvasColor,
                  // childBuilder: (currentTime) {
                  //   return Container(
                  //     decoration: BoxDecoration(
                  //       gradient: LinearGradient(
                  //         colors: [
                  //           Colors.black.withOpacity(0.05),
                  //           Colors.black.withOpacity(0.1)
                  //           // Colors.amber,
                  //           // Colors.amberAccent,
                  //         ],
                  //       ),
                  //     ),
                  //     child: Center(
                  //       child: Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: [
                  //           Text(currentTime.toString(), style: const TextStyle(fontSize: 70, fontWeight: FontWeight.bold, height: 1)),
                  //           Text(currentTime > 1 ? "Hours" : "Hour", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                  //         ],
                  //       ),
                  //     ),

                  //     // child: Center(
                  //     //   child: Column(
                  //     //     mainAxisSize: MainAxisSize.min,
                  //     //     children: [
                  //     //       Text((currentTime * 5).toString(), style: const TextStyle(fontSize: 70, fontWeight: FontWeight.bold, height: 1)),
                  //     //       Text(currentTime > 0 ? "Minutes" : "Minute", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                  //     //     ],
                  //     //   ),
                  //     // ),
                  //   );
                  // },
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
        );
      }),
    );
  }
}
