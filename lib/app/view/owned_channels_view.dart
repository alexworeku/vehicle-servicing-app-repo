import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/controller/channel_controller.dart';
import 'package:vehicleservicingapp/app/view/channel_profile_view.dart';
import 'package:vehicleservicingapp/app/view/create_channel_view.dart';

class OwnedChannelsView extends StatelessWidget {
  OwnedChannelsView({Key key}) : super(key: key);
  final channelController = Get.put(new ChannelController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Channel"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CreateChannelView());
        },
        child: Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(left: 8, right: 8),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate((ctx, index) {
              return Column(
                children: [
                  Slidable(
                    actionPane: SlidableScrollActionPane(),
                    secondaryActions: [
                      IconSlideAction(
                        icon: Icons.edit,
                        onTap: () {},
                      ),
                      IconSlideAction(
                        icon: Icons.delete,
                        onTap: () {},
                      ),
                    ],
                    child: ListTile(
                      onTap: () {
                        Get.to(() => ChannelProfileView(
                              isAdmin: true,
                              channel: channelController.channels[index],
                            ));
                      },
                      leading: CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title:
                          Text(channelController.channels[index].channelName),
                      subtitle:
                          Text(channelController.channels[index].channelType),
                      trailing: IconButton(
                        icon: Icon(Icons.keyboard_arrow_right),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Divider()
                ],
              );
            }, childCount: channelController.channelsCount)),
          )
        ],
      ),
    );
  }
}
