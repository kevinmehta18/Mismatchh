class UsersList {
  UsersList({
      this.data,});

  UsersList.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(UsersListData.fromJson(v));
      });
    }
  }
  List<UsersListData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class UsersListData {
  UsersListData({
      this.imageUrl, 
      this.name, 
      this.age, 
      this.interests, 
      this.distance,});

  UsersListData.fromJson(dynamic json) {
    imageUrl = json['imageUrl'];
    name = json['name'];
    age = json['age'];
    interests = json['interests'] != null ? json['interests'].cast<String>() : [];
    distance = json['distance'];
  }
  String? imageUrl;
  String? name;
  int? age;
  List<String>? interests;
  String? distance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['imageUrl'] = imageUrl;
    map['name'] = name;
    map['age'] = age;
    map['interests'] = interests;
    map['distance'] = distance;
    return map;
  }

}