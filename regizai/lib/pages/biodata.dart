import 'package:flutter/material.dart';
import 'package:regizai/event/event_db.dart';

class Biodata extends StatefulWidget {
  Biodata({super.key, required this.email, required this.password, required this.gender});

  final String email;
  final String password;
  final String gender;

  @override
  State<Biodata> createState() => _BiodataState();
}

class _BiodataState extends State<Biodata> {

  var formKey = GlobalKey<FormState>();

  var birth;
  var controllerName = TextEditingController();
  var controllerWidth = TextEditingController();
  var controllerHeight = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    birth;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Row(
                      children: [
                        Text(
                          "BIODATA",
                          style: TextStyle(
                              fontSize: 37,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Fill in your biodata",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 50,
                    ),

                    SizedBox(
                      width: 350,
                      height: 50,
                      child: TextFormField(
                        controller: controllerName,
                        decoration: InputDecoration(
                            labelText: "Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 280,
                          height: 50,
                          child: TextFormField(
                            decoration: InputDecoration(
                              enabled: false,
                              labelText: "Select your birth",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 65,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)
                              )
                            ),
                            onPressed: () async {
                              DateTime date = DateTime.now();
                              DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: date,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );
                              setState(() {
                                birth = newDate.toString();
                              });
                            },
                            child: Icon(
                              Icons.calendar_month,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 350,
                      height: 50,
                      child: TextFormField(
                        controller: controllerWidth,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Width-Kg",
                            suffixIcon: Icon(Icons.keyboard_arrow_left),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 350,
                      height: 50,
                      child: TextFormField(
                        controller: controllerHeight,
                        decoration: InputDecoration(
                            labelText: "Height-Cm",
                            suffixIcon: Icon(Icons.keyboard_arrow_up_sharp),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                                EventDB.addUser(controllerName.text, widget.email, widget.password, widget.gender, birth, controllerWidth.text, controllerHeight.text);
                              },
                              child: Text("Finish", style: TextStyle(color: Colors.white),)
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
}
