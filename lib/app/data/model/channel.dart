class Channel {
  String id;
  String channelName;
  String channelType;
  String description;
  double rating;
  String location; //lat,long
  int phoneNum;
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
  bool get isGarage => channelType == "Garage";
}
