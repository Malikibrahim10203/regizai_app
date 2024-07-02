import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:regizai/event/event_db.dart';
import 'package:regizai/event/event_pref.dart';
import 'package:regizai/model/response_api.dart';

class PreviewPage extends StatelessWidget {
  PreviewPage({Key? key, required this.picture, required this.apiResponse, required this.id}) : super(key: key);

  final XFile picture;
  final ApiResponse apiResponse;
  final id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Image border
                  child: SizedBox.fromSize(
                    child: Image.asset(
                      'assets/img/${apiResponse.brand_name}.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Result Analisys',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                Row(
                    children: [
                      Text(
                          '${apiResponse.brand_name}'
                      ),
                    ]
                ),
                SizedBox(
                  height: 28,
                ),
                Row(
                  children: [
                    Text(
                      'Kandungan',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                        width: 50,
                        height: 50,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                        ),
                        child: Image.asset("assets/img/fat.png")
                    ),
                    Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0XFFD8CBE2),
                      ),
                      child: Text("${apiResponse.fat}", style: TextStyle(fontSize: 30, color: Colors.white)),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                        width: 50,
                        height: 50,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                        ),
                        child: Image.asset("assets/img/cal.png")
                    ),
                    Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0XFFD8CBE2),
                      ),
                      child: Text("${apiResponse.cal}", style: TextStyle(fontSize: 30, color: Colors.white)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                        width: 50,
                        height: 50,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                        ),
                        child: Image.asset("assets/img/protein.png")
                    ),
                    Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0XFFD8CBE2),
                      ),
                      child: Text("${apiResponse.protein}", style: TextStyle(fontSize: 30, color: Colors.white)),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff734597),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  onPressed: () {
                    EventDB.saveCatatan(id, apiResponse.brand_name, apiResponse.cal);
                  },
                  child: Text("Catat", style: TextStyle(color: Colors.white),),
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}
