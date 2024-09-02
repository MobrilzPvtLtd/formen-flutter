class MessageList {
  String? status;
  List<Chats>? chats;

  MessageList({this.status, this.chats});

  MessageList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['chats'] != null) {
      chats = <Chats>[];
      json['chats'].forEach((v) {
        chats!.add( Chats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    if (chats != null) {
      data['chats'] = chats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chats {
  String? id;
  String? user1Id;
  String? user2Id;
  String? timestamp;

  Chats({this.id, this.user1Id, this.user2Id, this.timestamp});

  Chats.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user1Id = json['user1_id'];
    user2Id = json['user2_id'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['user1_id'] = user1Id;
    data['user2_id'] = user2Id;
    data['timestamp'] = timestamp;
    return data;
  }
}
