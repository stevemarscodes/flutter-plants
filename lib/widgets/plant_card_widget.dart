import 'package:chat/models/plant.dart';
import 'package:chat/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/extension.dart';

class CardPlant extends StatefulWidget {
  final Plant plant;

  CardPlant({this.plant});
  @override
  _CardPlantState createState() => _CardPlantState();
}

class _CardPlantState extends State<CardPlant> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return Column(
      children: <Widget>[
        Container(
          color: currentTheme.scaffoldBackgroundColor,
          padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5.0),
          width: size.height / 1.5,
          child: FittedBox(
            child: Card(
              shadowColor: Colors.black,
              color: currentTheme.scaffoldBackgroundColor,
              // color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: Row(
                children: <Widget>[
                  juiceitem(),
                  Container(
                    width: 150,
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image(
                        fit: BoxFit.cover,
                        alignment: Alignment.topRight,
                        image: AssetImage('assets/weed1.jpg'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget juiceitem() {
    final size = MediaQuery.of(context).size;
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;
    final thc = (widget.plant.thc.isEmpty) ? '0' : widget.plant.thc;
    final cbd = (widget.plant.cbd.isEmpty) ? '0' : widget.plant.cbd;
    return Container(
      //width: 150,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /*  Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              
            
            ],
          ), */
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              widget.plant.name.capitalize(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: currentTheme.accentColor),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            width: size.width / 2.0,
            child: Text(
              (widget.plant.description.length > 0)
                  ? widget.plant.description.capitalize()
                  : "No description",
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5.0),
                  child: Container(
                    padding: EdgeInsets.all(2.5),
                    child: Text(
                      "THC:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5.0),
                  child: Container(
                    padding: EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                      color: Color(0xffF12937E),
                      //color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "$thc %",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5.0),
                  child: Container(
                    padding: EdgeInsets.all(2.5),
                    child: Text(
                      "CBD:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5.0),
                  child: Container(
                    padding: EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      //color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "$cbd %",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: 5,
                ),
                /* Container(
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.yellow[400],
                    //color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "New",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 9.5),
                  ),
                ), */
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Widget pizzaitem() {
    return Container(
      //width: 150,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              "Cheese Pizza Italy ",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15, color: Colors.red),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Double cheese New York Style",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 9.5,
                color: Colors.grey),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.shopping_cart,
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.deepOrange[300],
                  //color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Spicy",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 9.5),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.yellow[400],
                  //color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  "New",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 9.5),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Ratings",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 7,
                    color: Colors.grey),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.star,
                size: 10,
                color: Colors.orangeAccent,
              ),
              Icon(
                Icons.star,
                size: 10,
                color: Colors.orangeAccent,
              ),
              Icon(
                Icons.star,
                size: 10,
                color: Colors.orangeAccent,
              ),
              Icon(
                Icons.star,
                size: 10,
                color: Colors.orangeAccent,
              ),
              Icon(
                Icons.star,
                size: 10,
                color: Colors.orangeAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget eliteitem() {
    return Container(
      //width: 150,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              "Alinea Chicago",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15, color: Colors.red),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Classical French cooking",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 9.5,
                color: Colors.grey),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.shopping_cart,
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.deepOrange[300],
                  //color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Spicy",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 9.5),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.red,
                  //color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Hot",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 9.5,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.yellow[400],
                  //color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  "New",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 9.5,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Ratings",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 7,
                    color: Colors.grey),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.star,
                size: 10,
                color: Colors.orangeAccent,
              ),
              Icon(
                Icons.star,
                size: 10,
                color: Colors.orangeAccent,
              ),
              Icon(
                Icons.star,
                size: 10,
                color: Colors.orangeAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}