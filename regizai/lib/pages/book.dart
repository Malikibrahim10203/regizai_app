import 'package:flutter/material.dart';
import 'package:regizai/addon/card.dart';
import 'package:regizai/pages/food.dart';
import 'package:regizai/pages/result.dart';

class Books extends StatefulWidget {
  const Books({Key? key}) : super(key: key);

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Books"),
        centerTitle: true,
        backgroundColor: Color(0xff734597),
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 1,
                decoration: BoxDecoration(
                  color: Color(0xff734597),
                ),
              ),
              Positioned(
                top: 30,
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Foods(nameFood: "Bakso")));
                              },
                              child: addonCard("bakso"),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Foods(nameFood: "cabai")));
                              },
                              child: addonCard("cabai"),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Foods(nameFood: "bika")));
                              },
                              child: addonCard("bika"),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Foods(nameFood: "bayam")));
                              },
                              child: addonCard("bayam"),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Foods(nameFood: "risoles")));
                              },
                              child: addonCard("risoles"),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Foods(nameFood: "jeruk")));
                              },
                              child: addonCard("jeruk"),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Foods(nameFood: "kubis")));
                              },
                              child: addonCard("kubis"),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Foods(nameFood: "apel")));
                              },
                              child: addonCard("apel"),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Foods(nameFood: "ayam goreng")));
                              },
                              child: addonCard("ayam goreng"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
