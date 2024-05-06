import 'package:flutter/material.dart';

class Biodata extends StatefulWidget {
  const Biodata({Key? key}) : super(key: key);

  @override
  State<Biodata> createState() => _BiodataState();
}

class _BiodataState extends State<Biodata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            Form(
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
                                labelText: "Select your birth",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 55,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              DateTime date = DateTime.now();
                              DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: date,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );
                            },
                            child: Icon(
                                Icons.calendar_month
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
                        decoration: InputDecoration(
                            labelText: "Width",
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
                        decoration: InputDecoration(
                            labelText: "Height",
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
                          width: 100,
                          height: 30,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff734597)
                              ),
                              onPressed: (){},
                              child: Text("Finish")
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
