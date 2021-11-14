

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);

  runApp(MaterialApp(home: App(),));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _buildBody()),
    );
  }
  Widget _buildBody() {
    return Stack(
      children: [
        Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('123'),
                Text('123'),
                Text('123'),
                Text('123'),
                Text('123'),
                Text('123'),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 100),
          child: Row(
            children: [
              Text('111'),
              Text('111'),
              Text('111'),
            ],
          ),
        ),
        Container(child: PageView(
          children: [
            Text('1232')
          ],
        ),
          color: Colors.red,
          margin: EdgeInsets.only(left: 100, top: 40),
        )

      ],
    );
  }
}
