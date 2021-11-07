import 'package:flutter/material.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton:FloatingActionButton( //Floating action button on Scaffold
        onPressed: (){
          //code to execute on button press
        },
        child: Icon(Icons.send), //icon inside button
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //floating action button position to center

      bottomNavigationBar: BottomAppBar( //bottom navigation bar on scaffold
        color:Colors.redAccent,
        shape: AutomaticNotchedShape(RoundedRectangleBorder(),StadiumBorder(side: BorderSide())), //shape of notch
        notchMargin: 5, //notche margin between floating button and bottom appbar
        child: Row( //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(icon: Icon(Icons.menu, color: Colors.white,), onPressed: () {},),
            IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: () {},),
            SizedBox(width: 20,),
            IconButton(icon: Icon(Icons.print, color: Colors.white,), onPressed: () {},),
            IconButton(icon: Icon(Icons.people, color: Colors.white,), onPressed: () {},),
          ],
        ),
      ),
    );
  }
}