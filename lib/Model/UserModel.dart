import 'dart:convert';

class User {
  String id, firstName, lastName, email, password, phoneNumber, userType;
  List<String>? groupIds, channelIds;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.userType,
    this.groupIds,
    this.channelIds,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstName: json['fName'],
      lastName: json['lName'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      userType: json['userType'],
      groupIds: json['groupId'] != null ? List<String>.from(json['groupId']) : null,
      channelIds: json['channelId'] != null ? List<String>.from(json['channelId']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fName': firstName,
      'lName': lastName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'userType': userType,
      'groupId': groupIds,
      'channelId': channelIds,
    };
  }
}

// {
// "_id": "McjWApXrG4SedQWkCGRp7lk6Lgi2",
// "fName": "fkr",
// "lName": "abiy",
// "email": "fkr@gmail.com",
// "password": "65500639",
// "phoneNumber": "0965500639",
// "userType": "Admin",
// "groupId": [],
// "channelId": [],
// "__v": 0
// }
