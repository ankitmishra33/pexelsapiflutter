
import 'package:photo_video_app/feature_display_photo/photo_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class FavoriteScreen  extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}
class _MyAppState extends State<FavoriteScreen> {
  List<dynamic> data=[];
  void initState() {
    super.initState();
    _bindfav();
  }
// function to decode favourite list data
  void _bindfav() async {
    SharedPreferences.getInstance().then((prefs) {

      String favJson=prefs.getString('favorlist');
      setState(() {

        data = json.decode(favJson);

      });

    });
  }
// To go back to Image Listing Page
  Future<bool> _onWillPop() async {

    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => DisplayPhotoScreen()));



  }
  @override
  // favourite list display widget
  Widget _favrouitelistInfo(index) {
    return new  GestureDetector(
      onTap: () {

      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16.0 / 8.0,
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Hero(
                  tag:  data[index]["src"]["portrait"],
                  child: FadeInImage.assetNetwork(
                    image: data[index]["src"]["portrait"],
                    fit: BoxFit.cover,
                    placeholder: "assets/images/loading.gif",
                    imageScale: 1,
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(8, 0, 8,0),
                              child: Text(
                                data[index]["photographer"],
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),


                          ]
                      ),


                    ],
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );

  }
  Widget build(BuildContext context) {


    return  new WillPopScope(
        onWillPop: _onWillPop,
        child:Scaffold(
      appBar: AppBar(
        title: Text("Favourite",style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {

                    return _favrouitelistInfo(index);
                  }),
            ),
          ],
        ),
      ),
    ));
  }
}
