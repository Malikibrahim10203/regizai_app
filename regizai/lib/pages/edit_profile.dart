import 'package:flutter/material.dart';
import 'package:regizai/event/event_db.dart';
import 'package:regizai/event/event_pref.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.id, required this.name, required this.width,required this.height});

  final id;
  final name;
  final width;
  final height;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late String userName;
  late String userWidth;
  String? userHeight;

  var controllerUsername;
  var controllerNewPassword;
  var controllerOldPassword;
  var controllerWidth;
  var controllerHeight;


  void getUser() async {
    userName = (await EventPref.getUser())?.name ?? "";
    userWidth = (await EventPref.getUser())?.width ?? "";
    userHeight = (await EventPref.getUser())?.height ?? "";

    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    userName  = widget.name;
    userWidth = widget.width;
    userWidth = widget.height;

    controllerUsername = TextEditingController(text: userName);
    controllerNewPassword = TextEditingController();
    controllerOldPassword = TextEditingController();
    controllerWidth    = TextEditingController(text: userWidth);
    controllerHeight   = TextEditingController(text: userHeight);

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
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    SizedBox(
                      width: 350,
                      height: 50,
                      child: TextFormField(
                        controller: controllerUsername,
                        decoration: InputDecoration(
                            labelText: "Change Username",
                            suffixIcon: Icon(Icons.keyboard_arrow_up_sharp),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.13,
                    ),
                    SizedBox(
                      width: 350,
                      height: 50,
                      child: TextFormField(
                        controller: controllerOldPassword,
                        decoration: InputDecoration(
                            labelText: "Old Password",
                            suffixIcon: Icon(Icons.keyboard_arrow_up_sharp),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    SizedBox(
                      width: 350,
                      height: 50,
                      child: TextFormField(
                        controller: controllerNewPassword,
                        decoration: InputDecoration(
                            labelText: "New Password",
                            suffixIcon: Icon(Icons.keyboard_arrow_up_sharp),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    SizedBox(
                      width: 350,
                      height: 50,
                      child: TextFormField(
                        controller: controllerWidth,
                        decoration: InputDecoration(
                            labelText: "Width",
                            suffixIcon: Icon(Icons.keyboard_arrow_up_sharp),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    SizedBox(
                      width: 350,
                      height: 50,
                      child: TextFormField(
                        controller: controllerHeight,
                        decoration: InputDecoration(
                            labelText: "Change Height",
                            suffixIcon: Icon(Icons.keyboard_arrow_up_sharp),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    SizedBox(
                      width: 350,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff734597),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                          onPressed: (){
                            EventDB.editUser(widget.id, controllerUsername.text, controllerOldPassword.text, controllerNewPassword.text, controllerWidth.text, controllerHeight.text);
                          },
                          child: Text("Confirm", style: TextStyle(color: Colors.white),)
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                  ],
                ),
              ],
            )
        )
    );
  }
}
