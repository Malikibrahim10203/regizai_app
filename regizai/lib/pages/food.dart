import 'package:flutter/material.dart';
import 'package:regizai/addon/card.dart';

class Foods extends StatefulWidget {
  const Foods({super.key, required this.nameFood});

  final nameFood;

  @override
  State<Foods> createState() => _FoodsState();
}

class _FoodsState extends State<Foods> {

  var name;

  getNameFood() {
    name = widget.nameFood;
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getNameFood();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Food"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: FoodsPage("$name")
          ),
        ],
      ),
    );
  }
}
