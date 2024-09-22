import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_api/model/model2.dart';
import 'package:http/http.dart' as http;

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  // List<PhotosModel> photosList = [];
  // Future<List<PhotosModel>?> getPhotos() async {
  //   final Response = await http
  //       .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  //   var data = jsonDecode(Response.body.toString());
  //   if (Response.body == 200) {
  //     for (Map i in data) {
  //       PhotosModel photos = PhotosModel(title: i['title'], url: i['url']);
  //       photosList.add(photos);

  //     }
  //     return photosList;
  //   } else {
  //     return photosList;
  //   }
  // }

  List<PhotosModel> photosList = [];
  Future<List<PhotosModel>?> getPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      // photosList.clear(); // hotrelode pr clear nhi hogi
      for (Map i in data) {
        photosList.add(PhotosModel.fromJson(Map<String, dynamic>.from(i)));
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Home 2")),
      ),

      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotos(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                        itemCount: photosList.length,
                        itemBuilder: (context, index) {
                          // return Text(postList[index].title.toString());
                          // return Card(
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: Column(
                          //       mainAxisAlignment: MainAxisAlignment.start,
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Text(
                          //           'Title',
                          //           style: TextStyle(
                          //               fontWeight: FontWeight.bold,
                          //               color: Colors.blue),
                          //         ),
                          //         Text(photosList[index].title.toString()),
                          //         SizedBox(
                          //           height: 10,
                          //         ),
                          //         Text(
                          //           'Description',
                          //           style: TextStyle(
                          //               fontWeight: FontWeight.bold,
                          //               color: Colors.red),
                          //         ),
                          //         Text(photosList[index].url.toString()),
                          //       ],
                          //     ),
                          //   ),
                          // );
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Card(
                              color: Colors.amber[100],
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    
                                      photosList[index].url.toString()),
                                ),
                                title: Text('Notes id:' +
                                    snapshot.data![index].id.toString()),
                                subtitle:
                                    Text(snapshot.data![index].thumbnailUrl.toString()),
                              ),
                            ),
                          );
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}

// class Photos {
//   String? title;
//   String? url;
//   Photos({required this.title, required this.url});
// }
