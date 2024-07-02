import 'package:flutter/material.dart';
import 'package:regizai/addon/card.dart';
import 'package:regizai/api/foods_services.dart';

class Foods extends StatefulWidget {
  const Foods({super.key, required this.nameFood});

  final nameFood;

  @override
  State<Foods> createState() => _FoodsState();
}

class _FoodsState extends State<Foods> {

  var name;

  final MyFitnessPalService _service = MyFitnessPalService();
  dynamic _nutritionData;

  String? fat;
  String? cal;
  String? protein;

  getNameFood() {
    name = widget.nameFood;
    setState(() {

    });
  }

  Future<void> _fetchData() async {
    try {
      final data = await _service.fetchNutritionData(name);
      setState(() {
        _nutritionData = data;
        protein = _nutritionData[0].toString();
        fat = _nutritionData[1].toString();
        cal = _nutritionData[2].toString();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    name = widget.nameFood;
    getNameFood();
    _fetchData();
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
            child: FoodsPage(name.toLowerCase(), protein, fat, cal)
          ),
          // Center(
          //   child: _nutritionData == null ? CircularProgressIndicator(): Text(_nutritionData[0].toString()),
          // ),
        ],
      ),
    );
  }
}
