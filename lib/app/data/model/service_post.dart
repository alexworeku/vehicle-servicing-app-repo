import 'package:flutter/cupertino.dart';
import 'package:vehicleservicingapp/app/data/model/post.dart';

class ServicePost extends Post {
  String serviceName;
  double price;
  String serviceDescription;
  String serviceType;
  ServicePost({
    this.serviceName,
    @required this.serviceType,
    this.price,
    this.serviceDescription,
    String imageUrl,
    List<String> tags,
    String date,
    String channelId,
  }) : super(imageUrl: imageUrl, tags: tags, date: date, channelId: channelId);
}
