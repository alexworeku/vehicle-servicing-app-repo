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
    String id,
    String imageUrl,
    List<String> tags,
    String date,
    String channelId,
  }) : super(
            id: id,
            imageUrl: imageUrl,
            tags: tags,
            date: date,
            channelId: channelId);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': id,
      'ServiceName': serviceName,
      'Price': price,
      'ServiceType': serviceType,
      'ServiceDescription': serviceDescription,
      'ImageUrl': imageUrl,
      'Tags': tags,
      'RegisteredDate': date,
      'ChannelId': channelId
    };
  }

  ServicePost.fromMap(String id, Map<String, dynamic> data)
      : this(
            id: id,
            serviceName: data['ServiceName'],
            price: data['Price'],
            serviceType: data['ServiceType'],
            serviceDescription: data['ServiceDescription'],
            imageUrl: data['ImageUrl'],
            date: data['RegisteredDate'],
            tags: List<String>.from(data['Tags']),
            channelId: data['ChannelId']);
}
