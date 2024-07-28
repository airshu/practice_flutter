import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: CrossAlignWidget(),
  ));
}

class CrossAlignWidget extends StatefulWidget {
  const CrossAlignWidget({super.key});

  @override
  State<CrossAlignWidget> createState() => _CrossAlignWidgetState();
}

class _CrossAlignWidgetState extends State<CrossAlignWidget> {
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
          Text('CrossAxisAlignment.start'),
          buildRowByMainAxisAlignment(CrossAxisAlignment.start),
          Text('CrossAxisAlignment.end'),
          buildRowByMainAxisAlignment(CrossAxisAlignment.end),
          Text('CrossAxisAlignment.center'),
          buildRowByMainAxisAlignment(CrossAxisAlignment.center),
          Text('CrossAxisAlignment.baseline'),
          buildRowByMainAxisAlignment(CrossAxisAlignment.baseline),
          Text('CrossAxisAlignment.stretch'),
          buildRowByMainAxisAlignment(CrossAxisAlignment.stretch),
        ],
      ),
    );
  }

  buildRowByMainAxisAlignment(CrossAxisAlignment crossAxisAlignment) {
    return Container(
      height: 60,
      color: Colors.grey,
      child: Row(
        crossAxisAlignment: crossAxisAlignment,
        textBaseline: TextBaseline.alphabetic,
        children: buildList(),
      ),
    );
  }

  List<Widget> buildList() {
    return [
      Container(height: 10, width: 15, color: Colors.red),
      Container(height: 20, width: 20, color: Colors.green),
      Container(height: 30, width: 30, color: Colors.blue),
    ];
  }
}
