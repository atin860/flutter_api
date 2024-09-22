import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api/model/model3.dart';
import 'package:flutter_api/model/model4.dart';
import 'package:http/http.dart' as http;

class Home4 extends StatefulWidget {
  const Home4({super.key});

  @override
  State<Home4> createState() => _Home4State();
}

class _Home4State extends State<Home4> {
  List<Model4> userList3 = [];
  Future<List<Model4>?> getUserApi() async {
    final Response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(Response.body.toString());
    if (Response.statusCode == 200) {
      for (Map i in data) {
        userList3.add(Model4.fromJson(Map<String, dynamic>.from(i)));
      }
      return userList3;
    } else {
      return userList3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Home4",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body: FutureBuilder(
            future: getUserApi(),
            builder: (context, AsyncSnapshot<List<Model4>?> snapshot) {
              return ListView.builder(
                  itemCount: userList3.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              snapshot.data![index].url.toString()),
                        ),
                        title: Text(snapshot.data![index].title.toString()),
                        subtitle:
                            Text(snapshot.data![index].thumbnailUrl.toString()),
                      ),
                    );
                  });
            }));
  }
}
