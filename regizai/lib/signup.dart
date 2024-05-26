import 'package:flutter/material.dart';
import 'package:regizai/gender_page.dart';
import 'package:regizai/login.dart';

class Signup extends StatelessWidget {

  var controllerEmail = TextEditingController();
  var controllerPassword = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    "SignUp",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Image.asset(
                    'assets/img/logo-signup.png',
                    width: 200,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 40),
                              child: Text(
                                "SignUp",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  color: Color(0xff595959),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: 330,
                          height: 50,
                          child: TextFormField(
                            controller: controllerEmail,
                            decoration: InputDecoration(
                                labelText: "Email",
                                prefixIcon: Icon(Icons.email),
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
                          width: 330,
                          height: 50,
                          child: TextFormField(
                            controller: controllerPassword,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: Icon(Icons.fingerprint),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
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
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>GenderPage(email: controllerEmail.text, password: controllerPassword.text)));
                              },
                              child: Text("Create", style: TextStyle(color: Colors.white))
                          ),
                        ),
                        TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                            },
                            child: Text("Already have account?")
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
