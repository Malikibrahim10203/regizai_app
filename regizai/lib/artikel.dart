import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class Artikel extends StatefulWidget {
  const Artikel({Key? key}) : super(key: key);

  @override
  State<Artikel> createState() => _ArtikelState();
}

class _ArtikelState extends State<Artikel> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ARTICLE FOOD'
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                 Image.asset(
                    'assets/img/artikel1.png',
                   width: MediaQuery.of(context).size.width * 0.9,
                 ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Rekomendasi buah diet',
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
                        'Sarapan pagi, Cemilan diet'
                    ),
                  ]
                ),
                SizedBox(
                  height: 28,
                ),
                Text(
                  'Lorem Ipsumis simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
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
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                      ),
                      child: Icon(Icons.fact_check,color: Colors.white,),
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
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                      ),
                      child: Icon(Icons.safety_check,color: Colors.white,),
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
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                      ),
                      child: Icon(Icons.calculate,color: Colors.white,),
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
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                      ),
                      child: Icon(Icons.call,color: Colors.white,),
                    ),
                    Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0XFFD8CBE2),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'VIDIO TUTORIAL',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    YoutubePlayer(
                      width: 200,
                      controller: YoutubePlayerController(
                          initialVideoId: 'ejYfIDTIBb8',
                          flags: YoutubePlayerFlags(
                              autoPlay: true,
                              mute: false
                          )
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
