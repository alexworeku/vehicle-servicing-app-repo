import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vehicleservicingapp/app/data/model/vehicle.dart';
import 'package:vehicleservicingapp/app/data/repository/interfaces/ivehicle_repository.dart';

class VehicleRepository implements IVehicleRepository {
  @override
  Future<void> add(Vehicle vehicle) async {
    await FirebaseFirestore.instance
        .collection("Vehicles")
        .add(vehicle.toMap());
  }

  @override
  Future<List<Vehicle>> getAll(String channelId) async {
    var snapShot = await FirebaseFirestore.instance
        .collection("Vehicles")
        .where('ChannelId', isEqualTo: channelId)
        .get();
    List<Vehicle> posts = [];
    snapShot.docs.forEach((doc) {
      posts.add(Vehicle.fromMap(doc.id, doc.data()));
    });
    return posts;
  }

  @override
  Future<void> remove(String vehicleId) async {
    await FirebaseFirestore.instance
        .collection("Vehicles")
        .doc(vehicleId)
        .delete();
  }
}
