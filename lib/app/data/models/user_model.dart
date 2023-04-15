import 'news_model.dart';

class UserModel {
  String? userId;
  String? phoneNumber;
  String? fullName;
  String? profilePictureUrl;
  String? gender;
  List<dynamic>? bookmarks;

  UserModel({
    this.userId,
    this.phoneNumber,
    this.fullName,
    this.profilePictureUrl,
    this.gender,
    this.bookmarks,
  });
  UserModel.fromJson(Map<String,dynamic>json){
    userId = json['userId'];
    phoneNumber = json['phoneNumber'];
    fullName = json['fullName'];
    profilePictureUrl = json['profilePictureUrl'];
    gender = json['gender'];
    bookmarks = json['bookmarks'];
  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userId'] = userId;
    data['phoneNumber'] = phoneNumber;
    data['fullName'] = fullName;
    data['profilePictureUrl'] = profilePictureUrl;
    data['gender'] = gender;
    data['bookmarks'] = bookmarks;
    return data;
  }
}
