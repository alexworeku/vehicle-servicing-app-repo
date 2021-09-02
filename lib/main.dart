import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/view/home_view.dart';
import 'app/view/theme/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.light,
      theme: themeData(context),
      darkTheme: darkThemeData(context),
      debugShowCheckedModeBanner: false,
      title: 'VSP app',
      home: HomeView(),
    );
  }
}
