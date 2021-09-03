import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddVehicleView extends StatelessWidget {
  const AddVehicleView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Vehicle")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 11,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Plate No"),
              ),
              SizedBox(
                height: 11,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Vehicle Type (i.e Minibus,Pickup...)"),
              ),
              SizedBox(
                height: 11,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Vehicle Model"),
              ),
              SizedBox(
                height: 11,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Type (i.e Minibus,Pickup...)"),
              ),
              SizedBox(
                height: 11,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Description"),
              ),
              SizedBox(
                height: 11,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Owner name"),
              ),
              SizedBox(
                height: 11,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Owner phone number"),
              ),
              ListTile(
                onTap: () {},
                title: Text("Browse picture"),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.photo),
                ),
              ),
              SizedBox(
                height: 11,
              ),
              SizedBox(
                  height: 54,
                  width: Get.width,
                  child: ElevatedButton(onPressed: () {}, child: Text("Add")))
            ],
          ),
        ),
      ),
    );
  }
}
