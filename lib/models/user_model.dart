// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserInfoModel {
  String? name;
  String? mail;
  String? phone;
  String? nid;
  String? birthday;
  

  UserInfoModel({
    this.name,
    this.mail,
    this.phone,
    this.nid,
    this.birthday,
  });
  UserInfoModel.fromJson(dynamic json) {
    name = json['name'];
    mail = json['mail'];
    phone = json['phone'];
    nid = json['nid'];
    birthday = json['birthday'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['name'] = name;
    map['mail'] = mail;
    map['phone'] = phone;
    map['nid'] = nid;
    map['birthday'] = birthday;

    return map;
  }
}