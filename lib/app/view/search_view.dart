import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/accessory_post_controller.dart';
import 'package:vehicleservicingapp/app/controller/article_post_cotroller.dart';
import 'package:vehicleservicingapp/app/controller/channel_controller.dart';
import 'package:vehicleservicingapp/app/controller/service_post_controller.dart';
import 'package:vehicleservicingapp/app/controller/vehicles_controller.dart';
import 'package:vehicleservicingapp/app/data/model/accessory_post.dart';
import 'package:vehicleservicingapp/app/data/model/article_post.dart';
import 'package:vehicleservicingapp/app/data/model/post.dart';
import 'package:vehicleservicingapp/app/data/model/service_post.dart';
import 'package:vehicleservicingapp/app/data/model/vehicle.dart';
import 'package:vehicleservicingapp/app/view/post_detail_view.dart';

class SearchView extends StatefulWidget {
  final bool isService, isArticle, isAccessory, isVehicle;
  final String serviceType;
  const SearchView({
    Key key,
    this.isService = false,
    this.isArticle = false,
    this.isAccessory = false,
    this.serviceType,
    this.isVehicle = false,
  })  : assert(isService ? serviceType != null : true),
        super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  var _key = GlobalKey<FormState>();
  var searchController = new TextEditingController();
  String searchWord = "";
  Future<List<Post>> getPostsSource() {
    if (widget.isAccessory) {
      return Get.find<AccessoryPostController>().getPostsByTag(searchWord);
    } else if (widget.isArticle) {
      return Get.find<ArticlePostController>().getAllByTag(searchWord);
    } else {
      return Get.find<ServicePostController>().getPostsByTag(searchWord);
    }
  }

  String getPostTitle(Post p) {
    if (p is AccessoryPost) {
      return p.productName;
    } else if (p is ServicePost) {
      return p.serviceName;
    } else {
      return (p as ArticlePost).title;
    }
  }

  Widget _getVehicleSearchView() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: FutureBuilder<List<Vehicle>>(
          future:
              Get.find<VehiclesController>().getVehiclesByPlateNum(searchWord),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data.isNotEmpty) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (ctx, index) {
                      var vehicles = snapshot.data;
                      return Column(
                        children: [
                          ExpansionTile(
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
                                trailing: Text(vehicles[index].checkOutDate),
                              ),
                            ],
                          ),
                          Divider()
                        ],
                      );
                    });
              }
              return Center(
                child: Text("Result not found,"),
              );
            }
            return Center(
              child: SpinKitCircle(color: Get.theme.primaryColor),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        actions: [
          Form(
            key: _key,
            child: Padding(
              padding: EdgeInsets.only(top: 10, right: 4, bottom: 8),
              child: SizedBox(
                width: Get.width * 0.70,
                child: TextFormField(
                  controller: searchController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return widget.isVehicle
                          ? "Please enter plate number"
                          : "Please enter something";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      hintText: "Search for vehicle ?",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                ),
              ),
            ),
          ),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                if (_key.currentState.validate()) {
                  setState(() {
                    searchWord = searchController.text.trim();
                  });
                }
              })
        ],
      ),
      body: widget.isVehicle
          ? _getVehicleSearchView()
          : (searchWord.isEmpty
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<Post>>(
                      future: getPostsSource(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data.isNotEmpty) {
                            return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (ctx, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        onTap: () async {
                                          var channel = await Get.find<
                                                  ChannelController>()
                                              .getChannelById(snapshot
                                                  .data[index].channelId);
                                          Get.to(() => PostDetailView(
                                                post: snapshot.data[index],
                                                channel: channel,
                                              ));
                                        },
                                        trailing: Icon(Icons.arrow_forward),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 3),
                                        leading: CachedNetworkImage(
                                          imageUrl:
                                              snapshot.data[index].imageUrl,
                                          placeholder: (ctx, imgProvider) =>
                                              SpinKitCircle(
                                                  color:
                                                      Get.theme.primaryColor),
                                          errorWidget: (ctx, url, error) =>
                                              Icon(Icons.error),
                                          imageBuilder: (ctx, imgProvider) {
                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image(
                                                width: Get.width * 0.2,
                                                height: Get.width * 0.2,
                                                image: imgProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          },
                                        ),
                                        title: Text(
                                            getPostTitle(snapshot.data[index])),
                                      ),
                                      Divider()
                                    ],
                                  );
                                });
                          }
                          return Center(
                            child: Text("Result not found,"),
                          );
                        }
                        return Center(
                          child: SpinKitCircle(color: Get.theme.primaryColor),
                        );
                      }),
                )),
    );
  }
}
