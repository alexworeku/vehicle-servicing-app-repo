import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/vehicles_controller.dart';
import 'package:vehicleservicingapp/app/data/model/vehicle.dart';
import 'package:vehicleservicingapp/app/data/provider/firebase_storage_provider.dart';
import 'package:vehicleservicingapp/app/data/repository/vehicle_repository.dart';
import 'package:vehicleservicingapp/app/view/add_vehicle_view.dart';

class VehiclesView extends StatelessWidget {
  final vehicleController =
      Get.put(new VehiclesController(new VehicleRepository()));
  final String channelId;
  VehiclesView({Key key, @required this.channelId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(
            () => AddVehicleView(
              channelId: channelId,
            ),
          );
        },
      ),
      appBar: AppBar(
        title: Text(
          "Vehicles",
        ),
      ),
      body: FutureBuilder<List<Vehicle>>(
          future: vehicleController.getVehicles(channelId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data.isNotEmpty) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (ctx, index) {
                      var vehicles = snapshot.data;
                      return Slidable(
                        actionPane: SlidableScrollActionPane(),
                        secondaryActions: [
                          IconSlideAction(
                            color: Colors.redAccent,
                            icon: Icons.delete,
                            onTap: () {
                                 Get.showSnackbar(GetBar(
                              title: "Removing...",
                              message: "Please wait a moment",
                              icon: SpinKitCircle(
                                color: Get.theme.primaryColor,
                                size: 15,
                              ),
                            ));
                              FirebaseStorageProvider.removeImage(
                                  vehicles[index].imageUrl);
                              vehicleController
                                  .removeVehicle(vehicles[index].id);

                              Get.close(1);
                              Get.showSnackbar(
                                GetBar(
                                  title: "Vehicle Removed",
                                  message: "Vehicle Removed Successfully.",
                                  icon: Icon(Icons.delete),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                          )
                        ],
                        child: ExpansionTile(
                          leading: snapshot.data[index].imageUrl != null
                              ? CachedNetworkImage(
                                  imageUrl: snapshot.data[index].imageUrl,
                                  placeholder: (ctx, imgProvider) =>
                                      SpinKitCircle(
                                          color: Get.theme.primaryColor),
                                  errorWidget: (ctx, url, error) =>
                                      Icon(Icons.error),
                                  imageBuilder: (ctx, imgProvider) {
                                    return CircleAvatar(
                                        radius: 20,
                                        backgroundImage: imgProvider);
                                  },
                                )
                              : Icon(Icons.car_repair),
                          title: Text(vehicles[index].plateNo),
                          subtitle: Text(vehicles[index].type),
                          children: [
                            ListTile(
                              title: Text("Owner"),
                              trailing: Text(vehicles[index].ownerName),
                            ),
                            ListTile(
                              title: Text("Phone"),
                              subtitle: Text(vehicles[index].ownerPhoneNumber),
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
                    });
              } else {
                return Center(
                    child: Text(
                  "No vehicles yet",
                ));
              }
            }
            return Center(
              child: SpinKitCircle(
                color: Get.theme.primaryColor,
              ),
            );
          }),
    );
  }
}
