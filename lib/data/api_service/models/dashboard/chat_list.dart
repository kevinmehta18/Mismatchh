class ChatList {
  ChatList({
      this.data,});

  ChatList.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ChatListData.fromJson(v));
      });
    }
  }
  List<ChatListData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ChatListData {
  ChatListData({
      this.imageUrl, 
      this.name, 
      this.lastMessage, 
      this.time,});

  ChatListData.fromJson(dynamic json) {
    imageUrl = json['imageUrl'];
    name = json['name'];
    lastMessage = json['lastMessage'];
    time = json['time'];
  }
  String? imageUrl;
  String? name;
  String? lastMessage;
  String? time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['imageUrl'] = imageUrl;
    map['name'] = name;
    map['lastMessage'] = lastMessage;
    map['time'] = time;
    return map;
  }

}