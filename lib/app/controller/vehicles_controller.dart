import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/data/model/vehicle.dart';
import 'package:vehicleservicingapp/app/data/model/vehicle_owner.dart';

class VehiclesController extends GetxController {
  var vehicles = [
    Vehicle(
      plateNo: "A69675 A.A",
      type: "Mini bus",
      model: "M2120",
      description: "The problem is with the engine it has to be cleaned",
      checkInDate: DateTime.now().toString(),
      checkOutDate: DateTime.now().toString(),
      owner: new VehicleOwner(name: "Alex Woreku", phoneNumber: "0913662761"),
      imageUrl: "assets/images/garage1.jpg",
    ),
    Vehicle(
      plateNo: "A69675 A.A",
      type: "Mini bus",
      model: "M2120",
      description: "The problem is with the engine it has to be cleaned",
      checkInDate: DateTime.now().toString(),
      checkOutDate: DateTime.now().toString(),
      owner: new VehicleOwner(name: "Alex Woreku", phoneNumber: "0913662761"),
      imageUrl: "assets/images/garage1.jpg",
    ),
    Vehicle(
      plateNo: "A69675 A.A",
      type: "Mini bus",
      model: "M2120",
      description: "The problem is with the engine it has to be cleaned",
      checkInDate: DateTime.now().toString(),
      checkOutDate: DateTime.now().toString(),
      owner: new VehicleOwner(name: "Alex Woreku", phoneNumber: "0913662761"),
      imageUrl: "assets/images/garage1.jpg",
    ),
  ];

  List<Vehicle> getVehicles() {
    return vehicles;
  }

  int getVehiclesCount() {
    return vehicles.length;
  }
}
