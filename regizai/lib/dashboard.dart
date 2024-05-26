import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:regizai/artikel.dart';
import 'package:regizai/calculate.dart';
import 'package:regizai/catatan.dart';
import 'package:regizai/event/event_pref.dart';
import 'package:regizai/login.dart';
import 'package:regizai/profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {

  late String userName;

  TabController? _controller;

  int selectWidget = 0;
  List<Widget> naviWidgets = [
    Text('Home', style: TextStyle(fontSize: 40),),
    Text('Note', style: TextStyle(fontSize: 40),),
    Text('Notification', style: TextStyle(fontSize: 40),),
    Text('Account', style: TextStyle(fontSize: 40),),
  ];

  void changeWidget(int index) {
    setState(() {
      selectWidget = index;
    });
  }

  void getUser() async {
    userName = (await EventPref.getUser())?.name ?? "";
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    _controller = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset("assets/img/male.png", width: 30,),
                            SizedBox(
                              width: 15,
                            ),
                            Text("User")
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: (){
                                EventPref.clear();
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                              },
                              icon: Icon(Icons.exit_to_app, size: 30,),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Hello, ",
                              style: TextStyle(
                                  fontSize: 16
                              ),
                            ),
                            Text(
                              "$userName",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Dashboard Regizai..")
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: 70,
                                  height: 70,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          side: BorderSide(
                                              color: Colors.white10,
                                              width: 2
                                          )
                                      ),
                                      backgroundColor: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Camera", style: TextStyle(fontSize: 12),)
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width: 70,
                                  height: 70,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Calculate()));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        backgroundColor: Colors.white
                                    ),
                                    child: Icon(
                                      Icons.calculate_outlined,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Calculate", style: TextStyle(fontSize: 12),)
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width: 70,
                                  height: 70,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        backgroundColor: Colors.white
                                    ),
                                    child: Icon(
                                      Icons.menu_book,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Books", style: TextStyle(fontSize: 12),)
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width*1,
                          height: MediaQuery.of(context).size.height*0.12,
                          child: ElevatedButton(
                            onPressed: (){},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff734597),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)
                                )
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Capaian Kalori",
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*1,
                          height: MediaQuery.of(context).size.height*0.12,
                          child: ElevatedButton(
                            onPressed: (){},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffEDEDED),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)
                                )
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Healty Food",
                                  style: TextStyle(
                                      color: Colors.black87
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Artikel Makanan",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Beragam makanan sehat ala diet",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CarouselSlider(
                          options: CarouselOptions(height: MediaQuery.of(context).size.height*0.25),
                          items: ["assets/img/artikel1.png","assets/img/artikel1.png","assets/img/artikel1.png","assets/img/artikel1.png","assets/img/artikel1.png"].map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5)
                                          )
                                      ),
                                      onPressed: () {
                                        // Untuk pindH ketika di klik
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Artikel()));
                                      },
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            "$i",
                                            width: MediaQuery.of(context).size.width*1,
                                            height: MediaQuery.of(context).size.height*0.2,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Tips diet sehat",
                                                style: TextStyle(
                                                    color: Colors.black87
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                );
                              },
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height * 0.09,
          decoration: BoxDecoration(
            color: Color(0xff734597),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TabBar(
            controller: _controller,
            tabs: [
              Tab(icon: IconButton(onPressed: (){}, icon: Icon(Icons.home, color: Colors.white,),),),
              Tab(icon: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Catatan()));}, icon: Icon(Icons.note, color: Colors.white,),)),
              Tab(icon: IconButton(onPressed: (){}, icon: Icon(Icons.notifications, color: Colors.white,),)),
              Tab(icon: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));}, icon: Icon(Icons.person, color: Colors.white,),))
            ],
          ),
        ),
      ),
    );
  }
}
