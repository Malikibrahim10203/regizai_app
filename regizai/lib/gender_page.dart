import 'package:flutter/material.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({Key? key}) : super(key: key);

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {

  int? _value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                      });
                    },
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Padding(
            padding: EdgeInsets.all(55),
            child: Row(
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
                      child: Text("Next")
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
