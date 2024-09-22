import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_api/model/model6.dart';
import 'package:http/http.dart' as http;

class Home6 extends StatefulWidget {
  const Home6({super.key});

  @override
  State<Home6> createState() => _Home6State();
}

class _Home6State extends State<Home6> {
  List<ApiModel> list = [];

  Future<List<ApiModel>?> getApi() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/55059801-e5ea-4a3b-8401-efe11aec236d'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data is List) {
        list = data.map((item) => ApiModel.fromJson(item)).toList();
      }
      return list;
    } else {
      return []; // Return empty list if the status code isn't 200
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data List'),
      ),
      body: FutureBuilder<List<ApiModel>?>(
        future: getApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                // var item = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                                padding: const EdgeInsets.only(left:20,right:20,top:10,bottom:10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Id :",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 15),
                              ),
                              Text(snapshot.data![index].id.toString())
                            ],
                          ),
                        ),
                         Padding(
                          padding: const EdgeInsets.only(left:20,right:20,top:10,bottom:10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Name :",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 15),
                              ),
                              Text(snapshot.data![index].name.toString())
                            ],
                          ),
                        ), Padding(
                                padding: const EdgeInsets.only(left:20,right:20,top:10,bottom:10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Storage :",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 15),
                              ),
                             Text( snapshot.data![index].data?.capacity?.toString() ?? 'null',)
                            ],
                          ),
                        ),
                         Padding(
                                padding: const EdgeInsets.only(left:20,right:20,top:10,bottom:10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Colour :",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 15),
                              ),
                             Text( snapshot.data![index].data?.color?.toString() ?? 'null',)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
