class Vehicle {
  String id;
  String type;
  String model;
  String plateNo;
  String description;
  String checkInDate;
  String checkOutDate;
  String imageUrl;
  String channelId;
  String ownerName;
  String ownerPhoneNumber;

  Vehicle({
    this.id,
    this.type,
    this.model,
    this.plateNo,
    this.description,
    this.imageUrl,
    this.checkInDate,
    this.checkOutDate,
    this.ownerName,
    this.ownerPhoneNumber,
    this.channelId,
  });
  Vehicle.fromMap(String id, Map<String, dynamic> data)
      : this(
            id: id,
            type: data['Type'],
            model: data['Model'],
            plateNo: data['PlateNo'],
            description: data['Description'],
            imageUrl: data['ImageUrl'],
            checkInDate: data['CheckInDate'],
            checkOutDate: data['CheckOutDate'],
            ownerName: data['OwnerName'],
            ownerPhoneNumber: data['OwnerPhoneNumber'],
            channelId: data['ChannelId']);
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': id,
      'Type': type,
      'Model': model,
      'PlateNo': plateNo,
      'Description': description,
      'ImageUrl': imageUrl,
      'CheckInDate': checkInDate,
      'CheckOutDate': checkOutDate,
      'OwnerName': ownerName,
      'OwnerPhoneNumber': ownerPhoneNumber,
      'ChannelId': channelId,
    };
  }
}
