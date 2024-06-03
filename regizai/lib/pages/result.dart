import 'package:flutter/material.dart';

class ResultFood extends StatefulWidget {
  const ResultFood({super.key, required this.nameFood});

  final nameFood;

  @override
  State<ResultFood> createState() => _ResultFoodState();
}

class _ResultFoodState extends State<ResultFood> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result Food"),
        centerTitle: true,
      ),
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
                      'assets/img/bakso.png',
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
                          '${widget.nameFood}'
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
                    ),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
