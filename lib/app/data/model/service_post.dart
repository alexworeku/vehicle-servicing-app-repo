import 'package:vehicleservicingapp/app/data/model/post.dart';

class ServicePost extends Post {
  String serviceName;
  double price;
  String serviceDescription;
  ServicePost({
    this.serviceName,
    this.price,
    this.serviceDescription,
    String imageUrl,
    List<String> tags,
    String date,
    String channelId,
  }) : super(imageUrl: imageUrl, tags: tags, date: date, channelId: channelId);
  
}
