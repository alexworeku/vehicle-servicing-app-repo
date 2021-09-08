import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vehicleservicingapp/app/controller/notification_controller.dart';
import 'package:vehicleservicingapp/app/controller/user_controller.dart';
import 'package:vehicleservicingapp/app/controller/vehicles_controller.dart';
import 'package:vehicleservicingapp/app/data/model/app_notification.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:vehicleservicingapp/app/data/model/vehicle.dart';
import 'package:vehicleservicingapp/app/data/provider/firebase_storage_provider.dart';
import 'package:vehicleservicingapp/app/data/repository/add_notification_view.dart';
import 'package:vehicleservicingapp/app/data/repository/vehicle_repository.dart';
import 'package:vehicleservicingapp/app/view/add_vehicle_view.dart';
import 'package:vehicleservicingapp/app/view/search_view.dart';

class VehiclesView extends StatefulWidget {
  final Channel channel;
  VehiclesView({Key key, @required this.channel}) : super(key: key);

  @override
  _VehiclesViewState createState() => _VehiclesViewState();
}

class _VehiclesViewState extends State<VehiclesView> {
  final vehicleController =
      Get.put(new VehiclesController(new VehicleRepository()));
  final refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(
            () => AddVehicleView(
              channelId: widget.channel.id,
            ),
          );
        },
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Get.to(() => SearchView(
                      isVehicle: true,
                    ));
              }),
        ],
        title: Text(
          "Vehicles",
        ),
      ),
      body: FutureBuilder<List<Vehicle>>(
          future: vehicleController.getVehicles(widget.channel.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data.isNotEmpty) {
                return Container(
                  height: Get.height,
                  width: Get.width,
                  child: SmartRefresher(
                    controller: refreshController,
                    header: WaterDropMaterialHeader(),
                    enablePullDown: true,
                    onRefresh: () {
                      setState(() {});

                      refreshController.refreshCompleted();
                    },
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (ctx, index) {
                          var vehicles = snapshot.data;
                          return Slidable(
                            actionPane: SlidableScrollActionPane(),
                            secondaryActions: [
                              IconSlideAction(
                                icon: Icons.notification_important,
                                color: Colors.orange,
                                onTap: () {
                                  Get.bottomSheet(AddNotificationView(
                                    channel: widget.channel,
                                    vehicle: snapshot.data[index],
                                    isFromChannel: true,
                                  ));
                                },
                              ),
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
                            child: SizedBox(
                              width: 200,
                              child: ExpansionTile(
                                leading: vehicles[index].imageUrl != null
                                    ? CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: snapshot.data[index].imageUrl,
                                        placeholder: (ctx, imgProvider) =>
                                            SpinKitCircle(
                                                size: 15,
                                                color: Get.theme.primaryColor),
                                        errorWidget: (ctx, url, error) =>
                                            Icon(Icons.error),
                                        imageBuilder: (ctx, imgProvider) {
                                          return CircleAvatar(
                                            radius: 30,
                                            backgroundImage: imgProvider,
                                          );
                                        },
                                      )
                                    : CircleAvatar(
                                        child: Icon(Icons.car_repair)),
                                title: Text(vehicles[index].plateNo),
                                subtitle: Text(vehicles[index].type),
                                children: [
                                  ListTile(
                                    title: Text("Owner"),
                                    trailing: Text(vehicles[index].ownerName),
                                  ),
                                  ListTile(
                                    title: Text("Phone"),
                                    subtitle:
                                        Text(vehicles[index].ownerPhoneNumber),
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
                                    trailing:
                                        Text(vehicles[index].checkOutDate),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                );
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
