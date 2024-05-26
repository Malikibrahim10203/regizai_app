import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:regizai/dashboard.dart';
import 'package:regizai/event/event_db.dart';
import 'package:regizai/event/event_pref.dart';
import 'package:regizai/model/catatan_harian.dart';
import 'package:regizai/profile.dart';

class Catatan extends StatefulWidget {
  // const Catatan({super.key, required this.id}));

  @override
  State<Catatan> createState() => _CatatanState();
}

class _CatatanState extends State<Catatan> with TickerProviderStateMixin {

  List<CatatanModel> listCat = [];
  TabController? _controller;

  int selectWidget = 1;
  List<Widget> naviWidgets = [
    Text('Home', style: TextStyle(fontSize: 40),),
    Text('Note', style: TextStyle(fontSize: 40),),
    Text('Notification', style: TextStyle(fontSize: 40),),
    Text('Account', style: TextStyle(fontSize: 40),),
  ];

  void changeWidget(int index) {
    setState(() {
      selectWidget = index;
    });
  }

  void getCatatan() async {
    listCat = await EventDB.getCatatans("1");
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getCatatan();
    _controller = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catatan Harian"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            naviWidgets[selectWidget],
            Expanded(
              child: ListView.builder(
                itemCount: listCat.length,
                itemBuilder: (context, index) {
                  CatatanModel catatans = listCat[index];
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Card(
                      color: Colors.white,
                      shadowColor: Colors.black,
                      shape: Border(
                        right: BorderSide(width: 5, color: Colors.black54)
                      ),
                      child: ListTile(
                        title: Text("${catatans.namaMakanan}"),
                        subtitle: Text("${catatans.calories}"),
                        trailing: Text("${catatans.tglCapture}"),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height * 0.09,
        decoration: BoxDecoration(
          color: Color(0xff734597),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TabBar(
          controller: _controller,
          tabs: [
            Tab(icon: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));}, icon: Icon(Icons.home, color: Colors.white,),),),
            Tab(icon: IconButton(onPressed: (){}, icon: Icon(Icons.note, color: Colors.white,),)),
            Tab(icon: IconButton(onPressed: (){}, icon: Icon(Icons.notifications, color: Colors.white,),)),
            Tab(icon: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));}, icon: Icon(Icons.person, color: Colors.white,),))
          ],
        ),
      ),
    );
  }
}
