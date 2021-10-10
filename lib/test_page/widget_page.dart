import 'package:flutter/material.dart';

class WidgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Text("asdfdsaf"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'images/logo.png',
                width: 100,
                height: 100,
              ),
              Image.asset(
                'images/logo.png',
                width: 100,
                height: 100,
              ),
              Image.asset(
                'images/logo.png',
                width: 100,
                height: 100,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Image.asset('images/logo.png', width: 100, height: 100),
              ),
              Expanded(
                flex: 2,
                child: Image.asset('images/logo.png', width: 100, height: 100),
              ),
              Expanded(
                child: Image.asset('images/logo.png', width: 100, height: 100),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.star, color: Colors.green[500]),
              Icon(Icons.star, color: Colors.green[500]),
              Icon(Icons.star, color: Colors.green[500]),
              const Icon(Icons.star, color: Colors.black),
              const Icon(Icons.star, color: Colors.black),
              const Text(
                '170 Reviews',
                style: TextStyle(color: Colors.black, fontSize: 20),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(Icons.kitchen, color: Colors.green[500]),
                  const Text('PREP:'),
                  const Text('25 min'),
                ],
              ),

            ],
          ),
        ],
      ),
    ));
  }
}
