import 'package:vehicleservicingapp/app/data/model/vehicle.dart';

abstract class IVehicleRepository {
  Future<void> add(Vehicle vehicle);
  Future<void> remove(String vehicleId);
  Future<List<Vehicle>> getAll(String channelId);
  Future<List<Vehicle>> getAllByPlateNo(String plateNum);
}
