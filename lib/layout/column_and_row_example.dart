import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ColumnAndRowWidget(),
  ));
}

class ColumnAndRowWidget extends StatefulWidget {
  const ColumnAndRowWidget({super.key});

  @override
  State<ColumnAndRowWidget> createState() => _ColumnAndRowWidgetState();
}

class _ColumnAndRowWidgetState extends State<ColumnAndRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Column and Row Example'),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      color: Colors.grey[300],
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('MainAxisAlignment.start'),
          buildRowByMainAxisAlignment(MainAxisAlignment.start),
          Text('MainAxisAlignment.end'),
          buildRowByMainAxisAlignment(MainAxisAlignment.end),
          Text('MainAxisAlignment.center'),
          buildRowByMainAxisAlignment(MainAxisAlignment.center),
          Text('MainAxisAlignment.spaceBetween'),
          buildRowByMainAxisAlignment(MainAxisAlignment.spaceBetween),
          Text('MainAxisAlignment.spaceAround'),
          buildRowByMainAxisAlignment(MainAxisAlignment.spaceAround),
          Text('MainAxisAlignment.spaceEvenly'),
          buildRowByMainAxisAlignment(MainAxisAlignment.spaceEvenly),
        ],
      ),
    );
  }

  buildRowByMainAxisAlignment(MainAxisAlignment mainAxisAlignment) {
    return Container(
      height: 60,
      color: Colors.grey,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: buildList(),
      ),
    );
  }

  List<Widget> buildList() {
    return [
      Container(height: 30, width: 15, color: Colors.red),
      Container(height: 20, width: 20, color: Colors.green),
      Container(height: 30, width: 30, color: Colors.blue),
    ];
  }
}
