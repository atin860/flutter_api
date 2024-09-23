import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api/model/model7.dart';
import 'package:http/http.dart' as http;

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
///// jab data object se suru ho

  late Future<Model7> futureUsers;
  Future<Model7> fetchUsers() async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=2'));

    if (response.statusCode == 200) {
      return Model7.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: Center(
        child: FutureBuilder<Model7>(
          future: futureUsers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.data!.length,
                itemBuilder: (context, index) {
                  // var user = snapshot.data!.data![index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          snapshot.data!.data![index].avatar.toString()),
                    ),
                    title: Text(
                        '${snapshot.data!.data![index].firstName.toString()} ${snapshot.data!.data![index].lastName.toString()}'),
                    subtitle:
                        Text(snapshot.data!.data![index].email.toString()),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
