import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/view/home_view.dart';
import 'app/view/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      home: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (ctx, snapShot) {
            if (snapShot.hasError) {
              return Container(
                child: Center(
                  child: Text("Sorry, Something Went Wrong"),
                ),
              );
            }
            if (snapShot.connectionState == ConnectionState.done) {
              return HomeView();
            }
            return SpinKitCircle(
              color: Get.theme.primaryColor,
            );
          }),
    );
  }
}
