class AppUser {
  String id;
  String fullName;
  String city;
  String phoneNo;
  String profileImageUrl;
  AppUser(
      {this.id, this.fullName, this.city, this.phoneNo, this.profileImageUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': id,
      'FullName': fullName,
      'City': city,
      'PhoneNumber': phoneNo,
      'ProfileImageUrl': profileImageUrl
    };
  }

  AppUser.fromMap(Map<String, dynamic> data)
      : this(
            id: data['Id'],
            fullName: data['FullName'],
            city: data['City'],
            phoneNo: data['PhoneNumber'],
            profileImageUrl: data['ProfileImageUrl']);
}
