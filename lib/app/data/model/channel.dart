import 'package:cloud_firestore/cloud_firestore.dart';

class Channel {
  String id;
  String channelName;
  String channelType;
  String description;
  List<double> rating;
  String location; //lat,long
  String phoneNum;
  String city;
  String imageUrl;
  List<String> testimonials;
  String userId;
  Channel(
      {this.id,
      this.channelName,
      this.channelType,
      this.description,
      this.imageUrl,
      this.city,
      this.phoneNum,
      this.rating,
      this.testimonials,
      this.userId});

  Map<String, dynamic> toMap() {
    // var latAndLong=location.split(',');
    return <String, dynamic>{
      'Id': id,
      'ChannelName': channelName,
      'ChannelType': channelType,
      'Description': description,
      'Rating': rating,
      'PhoneNumber': phoneNum,
      // 'Location':GeoPoint(double.parse(latAndLong[0]),double.parse(latAndLong[1])),
      'City': city,
      'ProfileImageUrl': imageUrl,
      'Testimonials': testimonials,
      'UserId': userId
    };
  }

  Channel.fromMap(String id, Map<String, dynamic> data)
      : this(
            id: id,
            channelName: data['ChannelName'],
            channelType: data['ChannelType'],
            description: data['Description'],
            rating: List<double>.from(data['Rating']),
            phoneNum: data['PhoneNumber'],
            city: data['City'],
            imageUrl: data['ProfileImageUrl'],
            testimonials: List<String>.from(data['Testimonials']),
            userId: data['UserId']);
}
