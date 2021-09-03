import 'package:vehicleservicingapp/app/data/model/vehicle_owner.dart';

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
  VehicleOwner owner;
  Vehicle({
    this.id,
    this.type,
    this.model,
    this.plateNo,
    this.description,
    this.imageUrl,
    this.checkInDate,
    this.checkOutDate,
    this.owner,
    this.channelId,
  });
  Vehicle.fromMap(Map<String, dynamic> data)
      : this(
            id: data['Id'],
            type: data['Type'],
            model: data['Model'],
            plateNo: data['PlateNo'],
            description: data['Description'],
            imageUrl: data['ImageUrl'],
            checkInDate: data['CheckInDate'],
            checkOutDate: data['CheckOutDate'],
            owner: VehicleOwner.fromMap(data['Owner']),
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
      "CheckOutDate": checkOutDate,
      'ChannelId': channelId,
      'Owner': owner.toMap()
    };
  }
}
