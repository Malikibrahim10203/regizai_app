import 'package:flutter/material.dart';
import 'package:regizai/biodata.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({super.key, required this.email, required this.password});

  final String email;
  final String password;

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {

  int? _value = 0;
  String gender = "male";

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Text(
              "CHOOSE GENDER",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff595959)
              ),
            ),
            Text(
              "Just only two",
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Image.asset("assets/img/male.png", width: 120,),
                    SizedBox(
                      height: 10,
                    ),
                    Radio(
                      value: 1,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                          gender = "male";
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset("assets/img/line.png", width: 3,)
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Image.asset("assets/img/female.png", width: 120,),
                    SizedBox(
                      height: 10,
                    ),
                    Radio(
                      value: 2,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                          gender = "female";
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 330,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff734597),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Biodata(email: widget.email, password: widget.password, gender: gender,)));
                      },
                      child: Text("Next", style: TextStyle(color: Colors.white),)
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}
