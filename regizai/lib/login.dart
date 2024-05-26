import 'package:flutter/material.dart';
import 'package:regizai/event/event_db.dart';
import 'package:regizai/signup.dart';

class Login extends StatelessWidget {

  var controllerEmail = TextEditingController();
  var controllerPass  = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() async => false,
      child: Scaffold(
        body: Center(
          child: ListView(
            children: [
              Form(
                key: formKey,
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Text(
                        "LOGIN",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Image.asset(
                        'assets/img/logo-login.png',
                        width: 200,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 40),
                                  child: Text(
                                    "LOGIN",
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
                                controller: controllerPass,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  prefixIcon: Icon(Icons.fingerprint),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                ),
                                obscureText: true,
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
                                    EventDB.login(controllerEmail.text, controllerPass.text);
                                  },
                                  child: Text("Login", style: TextStyle(color: Colors.white),)
                              ),
                            ),
                            TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                                },
                                child: Text("Create account?")
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
