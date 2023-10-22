import 'package:flutter/material.dart';
import 'package:hobiti/constants.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme(
          background: Constants.backgoundColor,
          primary: Constants.primaryColor,
          secondary: Constants.secondaryColor,
          onPrimary: Constants.onPrimaryColor,
          onSecondary: Constants.onSecondaryColor,
          onBackground: Constants.onBackgoundColor,
          error: Constants.errorColor,
          onError: Constants.onErrorColor,
          brightness: Brightness.dark,
          surface: Constants.backgoundColor,
          onSurface: Constants.onBackgoundColor,
        ),
      ),
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Constants.mainPadding),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Constants.secondaryColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(Constants.borderRadius),
                    border: Border.all(
                      color: Constants.primaryColor,
                      width: 2,
                    ),
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(Constants.mainPadding),
                          child: Text(
                            "name",
                            style: TextStyle(fontSize: 36),
                          ),
                        ),
                        Expanded(child: Container()),
                        Container(
                          color: Constants.primaryColor,
                          width: 2,
                          child: Container(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(Constants.mainPadding),
                          child: SizedBox(
                            width: 100,
                            child: Center(
                              child: Text(
                                "9",
                                style: TextStyle(fontSize: 54),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
