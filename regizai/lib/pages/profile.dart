import 'package:flutter/material.dart';
import 'package:regizai/event/event_pref.dart';
import 'package:regizai/pages/edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  late String userId;
  late String userName;
  late String userWidth;
  late String userHeight;
  
  var BBI;
  var calories;

  void getUser() async {
    userId = (await EventPref.getUser())?.id ?? "";
    userName = (await EventPref.getUser())?.name ?? "";
    userWidth = (await EventPref.getUser())?.width ?? "";
    userHeight = (await EventPref.getUser())?.height ?? "";

    BBI = (int.parse(userHeight)-100) - (0.1*(int.parse(userHeight)-100));
    calories = 30*BBI;

    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState

    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                width: 1,
                                color: Colors.black38
                            ),
                          ),
                          child: Image.asset("assets/img/male.png", ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("$userName", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),)
                              ],
                            ),
                            Row(
                              children: [
                                Text("Profile")
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile(id: userId, name: userName, width: userWidth, height: userHeight,)));
                      },
                      icon: Icon(Icons.more_vert),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name"),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 350,
                          height: 50,
                          child: TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                                labelText: "$userName",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Umur"),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 350,
                          height: 50,
                          child: TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                                labelText: "Umur",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Width"),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 350,
                          height: 50,
                          child: TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                                labelText: "$userWidth",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Height"),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 350,
                          height: 50,
                          child: TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                                labelText: "$userHeight",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Goals"),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Image.asset("assets/img/kcal.png", width: 70,),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Kalori Harian"),
                                Text("$calories Kcal")
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        )
      )
    );
  }
}
