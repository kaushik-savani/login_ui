import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userid = Utils.prefs!.getString("id") ?? "0";
  List images = ["mypng/img_1.png", "mypng/img_2.png", "mypng/img_3.png"];
  List prices = ["46,999", "1,49,990", "52,999"];
  List pname = [
    'Apple iPhone 12 (64GB) - Purple',
    'Apple iPhone 13 Pro (1TB) - Silver',
    'Apple iPhone 12 (128GB) - White'
  ];
  List pdetails = [
    'An apple mobile which is nothing like apple',
    'Supports MagSafe accessories for easy attachment and faster wireless charging',
    'iOS with redesigned widgets on the Home screen, all-new App Library, App Clips'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Card(
            shape: Border.all(width: .05),
            child: Container(
              height: 170,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 200,
                      alignment: Alignment.topCenter,
                      width: MediaQuery.of(context).size.width * .3,
                      child: Image.asset(
                        images[index],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(pname[index],
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "\₹${prices[index]}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Details :",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(pdetails[index]),
                          SizedBox(
                            height: 5,
                          ),
                          InkWell(
                              onTap: () async {
                                String ptitle=pname[index];
                                String pprice=prices[index];
                                String pdetail=pdetails[index];
                                String pimage=images[index];
                                String id=jsonEncode({"ptitle": "$ptitle",'pprice':"$pprice",'pdetail':"$pdetail",'pimage':"$pimage"});
                                var formData = FormData.fromMap({
                                  'userid': id,
                                  'id': '$userid',
                                });
                                var response = await Dio().post(
                                    'https://learnwithproject.000webhostapp.com/login/web_new_insert.php',
                                    data: formData);
                                print(response);
                                print(response.data);
                              },
                              child: Icon(Icons.add_shopping_cart))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),

      /*Center(
          child: ElevatedButton(onPressed: () async {
            print(userid);
            var formData = FormData.fromMap({
              'userid': {"name","134","iphone 13"},
              'id': '$userid',
            });
            var response = await Dio().post('https://learnwithproject.000webhostapp.com/login/web_new_insert.php', data: formData);
            print(response.data);
          }, child: Text("Submit")),
        )*/
    );
  }
}
