import 'package:vehicleservicingapp/app/data/model/post.dart';

class AccessoryPost extends Post {
  String productName;
  double price;
  String brand;
  String productDescription;
  AccessoryPost({
    String id,
    this.productName,
    this.price,
    this.brand,
    this.productDescription,
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

  AccessoryPost.fromMap(String docId, Map<String, Object> data)
      : this(
            id: docId,
            tags: List<String>.from(data['Tags']),
            productName: data['ProductName'],
            price: data['Price'],
            brand: data['Brand'],
            productDescription: data['ProductDescription'],
            imageUrl: data['ImageUrl'],
            date: data['RegisteredDate'],
            channelId: data['ChannelId']);

  Map<String, Object> toMap() {
    return <String, Object>{
      'Id': id,
      'ProductName': productName,
      'Price': price,
      'Brand': brand,
      "ProductDescription": productDescription,
      "ImageUrl": imageUrl,
      "Tags": tags,
      "RegisteredDate": date,
      "ChannelId": channelId
    };
  }
}
