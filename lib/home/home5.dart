import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_api/model/model5.dart';
import 'package:flutter_api/model/model6.dart';
import 'package:http/http.dart' as http;
class Home5 extends StatefulWidget {
  const Home5({Key? key}) : super(key: key);

  @override
  _Home5State createState() => _Home5State();
}

class _Home5State extends State<Home5> {



  Future<ProductModel> getProductsApi () async {
    //create your own api
     final response = await http.get(Uri.parse('https://webhook.site/55059801-e5ea-4a3b-8401-efe11aec236d'));
     var data = jsonDecode(response.body.toString());
     if(response.statusCode == 200){
       return ProductModel.fromJson(data);
     }else {
       return ProductModel.fromJson(data);

     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home5'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<ProductModel>(
                future: getProductsApi (),
                builder: (context , snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index){
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(snapshot.data!.data![index].shop!.name.toString()),
                                subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString()),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height *.3,
                                width: MediaQuery.of(context).size.width * 1,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.data![index].images!.length,
                                    itemBuilder: (context, position){
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                      height: MediaQuery.of(context).size.height *.25,
                                      width: MediaQuery.of(context).size.width * .5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(snapshot.data!.data![index].images![position].url.toString())
                                        )
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              Icon(snapshot.data!.data![index].inWishlist! == false ? Icons.favorite : Icons.favorite_outline)
                            ],
                          );
                        });
                  }else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}