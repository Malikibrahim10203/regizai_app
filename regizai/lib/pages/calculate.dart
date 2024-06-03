import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:regizai/api/bmi_service.dart';
import 'package:wave/wave.dart';

class Calculate extends StatefulWidget {
  const Calculate({Key? key}) : super(key: key);

  @override
  State<Calculate> createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {


  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _bmiService = BmiService();
  String _bmiResult = '';

  void _calculateBmi() async {
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text);

    try {
      var result = await _bmiService.calculateBmi(weight, height);
      setState(() {
        _bmiResult = result['bmi'].toString();
      });
    } catch (e) {
      setState(() {
        _bmiResult = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                Form(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: TextFormField(
                                controller: _weightController,
                                decoration: InputDecoration(
                                  labelText: "Weight",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.height * 0.08,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: Colors.black54),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Icon(Icons.monitor_weight_outlined, color: Colors.black54,),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: TextFormField(
                                controller: _heightController,
                                decoration: InputDecoration(
                                  labelText: "Height",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.height * 0.08,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1, color: Colors.black54),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Icon(Icons.height, color: Colors.black54,),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.06,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 110,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                  backgroundColor: Color(0xff734597)
                                ),
                                onPressed: () {
                                  _calculateBmi();
                                },
                                child: Text("Calculate", style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black38),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("BMI Result: $_bmiResult"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
