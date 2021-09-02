import 'package:flutter/material.dart';

class MapView extends StatelessWidget {
  const MapView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Map")),
      body: Container(
        child: Center(
          child: Text("Map"),
        ),
      ),
    );
  }
}
