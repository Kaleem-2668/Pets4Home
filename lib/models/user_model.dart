class UserModel {
  String? message;
  Data? data;

  UserModel({this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? image;
  int? status;
  String? token;
  int? devicetype;
  int? userType;
  String? authToken;

  Data(
      {this.firstName,
        this.lastName,
        this.email,
        this.phoneNumber,
        this.image,
        this.status,
        this.token,
        this.devicetype,
        this.userType,
        this.authToken});

  Data.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    image = json['image'];
    status = json['status'];
    token = json['token'];
    devicetype = json['devicetype'];
    userType = json['user_type'];
    authToken = json['authToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['image'] = image;
    data['status'] = status;
    data['token'] = token;
    data['devicetype'] = devicetype;
    data['user_type'] = userType;
    data['authToken'] = authToken;
    return data;
  }
}
