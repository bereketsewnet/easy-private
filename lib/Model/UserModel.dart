
class User {
  String id, firstName, lastName, email, password, phoneNumber, userType;
  String? profileUrl;
  List<String>? privateId ,groupIds, channelIds;
  bool select = false;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.userType,
    this.privateId,
    this.groupIds,
    this.channelIds,
    this.profileUrl,
    this.select = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstName: json['fName'],
      lastName: json['lName'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      profileUrl: json['profileUrl'],
      userType: json['userType'],
      privateId: json['privateId'] != null ? List<String>.from(json['privateId']) : null,
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
      'profileUrl': profileUrl,
      'userType': userType,
      'privateId': privateId,
      'groupId': groupIds,
      'channelId': channelIds,
    };
  }
}
