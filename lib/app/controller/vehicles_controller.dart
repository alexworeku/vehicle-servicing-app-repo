import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/data/model/vehicle.dart';
import 'package:vehicleservicingapp/app/data/repository/interfaces/ivehicle_repository.dart';

class VehiclesController extends GetxController {
  IVehicleRepository _vehicleRepository;
  VehiclesController(this._vehicleRepository);

  void addVehicle(Vehicle vehicle) async {
    await _vehicleRepository.add(vehicle);
  }

  void removeVehicle(String vehicleId) async {
    await _vehicleRepository.remove(vehicleId);
  }

  Future<List<Vehicle>> getVehicles(String channelId) async {
    return await _vehicleRepository.getAll(channelId);
  }
}
