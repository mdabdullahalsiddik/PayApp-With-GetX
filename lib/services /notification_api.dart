import 'dart:convert';

import 'package:http/http.dart' as http;

class NotificationApi {
  triggerNotification(
      {required String fcmToken,
      required String title,
      required String body}) async {
    var kye =
        "AAAAzwDPxw8:APA91bHvqVrf70Fki39zOQqKeNTG1P0Pj4vzG9W5BdbH9DmxSlvdVLT0skhu_sp0g-OU2REVlDXj8TgM_Wdv0ge3A-rNi3NdO6iUS8c5gRu699hXgjJPca9BRJUprpmC-_6k7kYYXNBL";
    try {
      // ignore: unused_local_variable
      final http.Response response = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "key=$kye"
        },
        body: jsonEncode(
          {
            "to": fcmToken,
            "notification": {
              "title": title,
              "body": body,
            },
          },
        ),
      );
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
