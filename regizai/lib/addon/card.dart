import 'package:flutter/material.dart';


addonCard(String gambar) {

  return Card(
    elevation: 1.0,
    color: Colors.white,
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)), // Image border
          child: SizedBox.fromSize(
            child: Image.asset(
              'assets/img/$gambar.png',
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text("$gambar"),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}

FoodsPage(String nameFood) {
  return Column(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(20), // Image border
        child: SizedBox.fromSize(
          child: Image.asset(
            'assets/img/$nameFood.png',
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
                '$nameFood'
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
  );
}