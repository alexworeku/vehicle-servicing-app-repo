import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/channel_controller.dart';
import 'package:vehicleservicingapp/app/data/model/channel.dart';
import 'package:vehicleservicingapp/app/view/channel_profile_view.dart';
import 'package:vehicleservicingapp/app/view/create_or_update_channel_view.dart';

class OwnedChannelsView extends StatefulWidget {
  OwnedChannelsView({Key key}) : super(key: key);

  @override
  _OwnedChannelsViewState createState() => _OwnedChannelsViewState();
}

class _OwnedChannelsViewState extends State<OwnedChannelsView> {
  final channelController = Get.find<ChannelController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Channel"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CreateOrUpdateChannelView());
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<Channel>>(
        future: channelController.getOwnedChannels(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data.isEmpty
                ? Center(
                    child: Text("No Channels Created"),
                  )
                : ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (ctx, index) {
                      return Column(
                        children: [
                          Slidable(
                            actionPane: SlidableScrollActionPane(),
                            secondaryActions: [
                              IconSlideAction(
                                color: Colors.yellowAccent,
                                icon: Icons.edit,
                                onTap: () {
                                  Get.to(() => CreateOrUpdateChannelView(
                                        showEditForm: true,
                                        channel: snapshot.data[index],
                                      ));
                                },
                              ),
                              IconSlideAction(
                                icon: Icons.delete,
                                color: Colors.redAccent,
                                onTap: () {
                                  channelController
                                      .removeChannel(snapshot.data[index].id);
                                  setState(() {});
                                },
                              ),
                            ],
                            child: ListTile(
                                onTap: () {
                                  Get.to(() => ChannelProfileView(
                                        channel: snapshot.data[index],
                                      ));
                                },
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
                                    : CircleAvatar(
                                        radius: 20, child: Icon(Icons.chat)),
                                title: Text(snapshot.data[index].channelName),
                                subtitle:
                                    Text(snapshot.data[index].channelType),
                                trailing: Icon(Icons.keyboard_arrow_right)),
                          ),
                          Divider()
                        ],
                      );
                    });
          }
          return Center(
            child: SpinKitCircle(
              color: Get.theme.primaryColor,
            ),
          );
        },
      ),
    );
  }
}
