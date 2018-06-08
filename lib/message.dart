import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Message>> fetchMessages() async {

  final Map<String, String> header = {'Content-Type':'application/json','Authorization':'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjgxMDA2NDMxNTQyNGE1N2E4ODY1MmFmZWExNjYyMjE0NTQzN2UyNzMyNmVkMzIzMjMzNGRmNmFkNTZkMzQ3ZDg1MjYyMjk1ZjRiN2QwZGQ3In0.eyJhdWQiOiIyIiwianRpIjoiODEwMDY0MzE1NDI0YTU3YTg4NjUyYWZlYTE2NjIyMTQ1NDM3ZTI3MzI2ZWQzMjMyMzM0ZGY2YWQ1NmQzNDdkODUyNjIyOTVmNGI3ZDBkZDciLCJpYXQiOjE1MjMwMzc5NDQsIm5iZiI6MTUyMzAzNzk0NCwiZXhwIjoxODM4NjU3MTQ0LCJzdWIiOiI1Iiwic2NvcGVzIjpbXX0.YJMc6VL-E_JC4_KW9Ww8i7FRg7j1Me-jEtuTLyT87ijB8Fw224kKJtjw2oVD54U4qvYyccC6rn92QRZgY3yrzznKHGpCCMnFnUZsX87F0G1J7rAuHQMfT9z_KHbRhpYUTiMU9dz5mCTvaQkQ7hfszYfeNhICklI21q6XbuY-hd_Shr6J9aMXwhzQlC8aijChaAFlRlu1x3YV904TkoiDsdwgktUga2QkUQ6f0roXd3kP4QO01FknDzdErPgw6kbabsbZVCGj1RiqAkP8pJZAebwKXH9CbyieJo4CZYzF46rW-mawB9W2awV1nlFwRVAd0HwoUbP_2sKhuj3zwZ1OJ9aTzuoeiaG_Tur7jAnku5GFpaWZZ25HzE6MQEPvR_6jCN_MXYUZ2g_VS8Y4Ae-uof7iip2IZJi2xsQrFpxAXgNN4D8eb4xuNd2gx6pq95GPyvr4y48NfnN34TdeuLmA5wZz8YsIlAuyf9oJj-6_0vD2yrVT1jgtcyZg-tjioISDS6IvnIkWmaOKmalu9e9N7r5Gg4JnjpWHRjIb6y0eu8L1gao5wUDV_6GdmdzJto7-0p_hNZw6ErAUIIIzxiDT2lKhhbug0VK4mw6zXJSGq87SNNzosHKo_O8zVGzHl-eVjPT-x9h5_ttLOsKF5ee3RyeAsL_BDuCPCxufiAWVMlw'};

  final response =
      await http.get('http://177.36.237.93/api/messages/1', headers: header);
  final responseJson = json.decode(response.body);

  return (responseJson as List).map((i) => Message.fromJson(i)).toList();
}

class Message {
  final int id;
  final String title;
  final String ticket;
  final String description;
  final String status;

  Message({this.id, this.title, this.ticket, this.description, this.status});

  factory Message.fromJson(Map<String, dynamic> json) {
    return new Message(
      id: json['id'],
      title: json['title'],
      ticket: json['ticket'],
      description: json['description'],
      status: json['status'],
    );
  }
}
