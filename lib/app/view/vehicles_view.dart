import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/vehicles_controller.dart';
import 'package:vehicleservicingapp/app/view/add_vehicle_view.dart';

class VehiclesView extends StatelessWidget {
  final vehicleController = Get.put(new VehiclesController());
  VehiclesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(() => AddVehicleView());
        },
      ),
      appBar: AppBar(
        title: Text("Vehicles"),
      ),
      body: ListView.builder(
          itemCount: vehicleController.getVehiclesCount(),
          itemBuilder: (ctx, index) {
            var vehicles = vehicleController.getVehicles();
            return Slidable(
              actionPane: SlidableScrollActionPane(),
              secondaryActions: [
                IconSlideAction(
                  color: Colors.redAccent,
                  icon: Icons.delete,
                  onTap: () async {},
                )
              ],
              child: ExpansionTile(
                leading: Image(
                  width: Get.width * 0.2,
                  height: Get.height * 0.2,
                  fit: BoxFit.cover,
                  image: AssetImage(vehicles[index].imageUrl),
                ),
                title: Text(vehicles[index].plateNo),
                subtitle: Text(vehicles[index].type),
                children: [
                  ListTile(
                    title: Text("Owner"),
                    trailing: Text(vehicles[index].owner.name),
                  ),
                  ListTile(
                    title: Text("Phone"),
                    subtitle: Text(vehicles[index].owner.phoneNumber),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.call),
                    ),
                  ),
                  ListTile(
                    title: Text("Description"),
                    subtitle: Text(vehicles[index].description),
                  ),
                  ListTile(
                    title: Text("Vehicle Model"),
                    trailing: Text(vehicles[index].model),
                  ),
                  ListTile(
                    title: Text("Checkout Date"),
                    trailing: Text(vehicles[index].checkOutDate),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
