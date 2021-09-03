
class VehicleOwner {
  String id;
  String name;
  String phoneNumber;
  VehicleOwner({this.id, this.name, this.phoneNumber});
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "Id": id,
      "Name": name,
      "PhoneNumber": phoneNumber,
    };
  }

  VehicleOwner.fromMap(Map<String, dynamic> data)
      : this(
            id: data['Id'],
            name: data['name'],
            phoneNumber: data['PhoneNumber']);
}
