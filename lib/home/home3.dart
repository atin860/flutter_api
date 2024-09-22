import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api/model/model3.dart';
import 'package:http/http.dart' as http;

class Home3 extends StatefulWidget {
  const Home3({super.key});

  @override
  State<Home3> createState() => _Home3State();
}

class _Home3State extends State<Home3> {
  List<UserModel> userList = [];
  Future<List<UserModel>?> getUser() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {

        userList.add(UserModel.fromJson(Map<String, dynamic>.from(i)));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home 3"),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getUser(),
                  builder: (context, AsyncSnapshot<List<UserModel>?> snapshot) {
                    return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('name'),
                                        Text(snapshot.data![index].name.toString()),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Email'),
                                        Text(
                                            snapshot.data![index].email.toString()),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('City'),
                                        Text(snapshot.data![index].address!.city
                                            .toString()),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }))
        ],
      ),
    );
  }
}
