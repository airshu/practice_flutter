import 'package:flutter/material.dart';

class ContainerTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildTest1();
  }
}

Widget _buildTest1() => Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            child: Image.asset(
              'images/pic1.jpg',
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(32),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Oeschinen Lake Campground',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Text(
                        'Kandersteg, Switzerland',
                        style: TextStyle(
                          fontSize: 12,
                          decoration: TextDecoration.none,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.star,
                  color: Colors.grey[500],
                ),
                const Text(
                  '41',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButtonColumn(Colors.grey, Icons.add, "ADD"),
              _buildButtonColumn(Colors.grey, Icons.alt_route, "ROUTE"),
              _buildButtonColumn(Colors.grey, Icons.share, "SHARE"),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(32),
            child: Text(
              'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
              'Alps. Situated 1,578 meters above sea level, it is one of the '
              'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
              'half-hour walk through pastures and pine forest, leads you to the '
              'lake, which warms to 20 degrees Celsius in the summer. Activities '
              'enjoyed here include rowing, and riding the summer toboggan run.',
              style: TextStyle(
                fontSize: 12,
                decoration: TextDecoration.none,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              softWrap: true,
            ),
          )
        ],
      ),
    );

Column _buildButtonColumn(Color color, IconData icon, String label) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, color: color),
      Container(
        margin: EdgeInsets.only(top: 8),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none,
            color: color,
          ),
        ),
      ),
    ],
  );
}

Widget _buildSafeArea() => SafeArea(
        child: Container(
      decoration: const BoxDecoration(color: Colors.yellow),
      child: Column(
        children: [
          _buildImageRow(1),
          _buildImageRow(3),
          Stack(
            alignment: Alignment(0.6, 0.6),
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('images/pic1.jpg'),
                radius: 100,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black45,
                ),
                child: const Text(
                  'Mia B',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));

Widget _buildDecoratedImage(int imageIndex) => Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 10, color: Colors.blue),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        margin: const EdgeInsets.all(4),
        child: Image.asset('images/pic$imageIndex.jpg'),
      ),
    );

Widget _buildImageRow(int imageIndex) => Row(
      children: [
        _buildDecoratedImage(imageIndex),
        _buildDecoratedImage(imageIndex + 1),
      ],
    );
