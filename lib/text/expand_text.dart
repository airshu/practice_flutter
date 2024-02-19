import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: TextApp1()));
}

class TextApp1 extends StatefulWidget {
  const TextApp1({super.key});

  @override
  State<TextApp1> createState() => _TextApp1State();
}

class _TextApp1State extends State<TextApp1> {
  @override
  Widget build(BuildContext context) {
    var list = [
      '购车顾虑：心仪其他品牌、价格未达到预期、乘坐空间小、智能泊车不完善房间里看到打飞机看到发地方',
      '购车意向：3个月',
      '信息需求：我已获得了我所需的信息',
      '产品关注：乘坐空间，智能泊车，智能辅助驾驶，小P智能语音阿斯顿发阿斯顿发阿斯顿发',
      '对比竟品：未来',
    ];

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          width: 200,
          child: MaterialTryDriveFeedbackWidget(summaryExtList: list),
        ),
      ),
    );
  }
}

class MaterialTryDriveFeedbackWidget extends StatefulWidget {
  final List<String> summaryExtList;

  const MaterialTryDriveFeedbackWidget({super.key, required this.summaryExtList});

  @override
  State<MaterialTryDriveFeedbackWidget> createState() => _MaterialTryDriveFeedbackWidgetState();
}

class _MaterialTryDriveFeedbackWidgetState extends State<MaterialTryDriveFeedbackWidget> {
  TextStyle textStyle = TextStyle(color: Color(0xDB31456A), fontSize: 14);
  TextStyle tagStyle = TextStyle(color: Color(0xFF006BE1), fontSize: 14);

  final double gapWidth = 22;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...widget.summaryExtList.map((element) {
          return buildItem(element, element == widget.summaryExtList.last);
        })
      ],
    ));
  }

  bool isExpand = false;

  Widget buildItem(String e, bool isLastLine) {
    var tag = TextSpan(
      text: isExpand ? '收起' : '展开',
      style: tagStyle,
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          setState(() {
            isExpand = !isExpand;
            print('123233');
          });
        },
    );

    String txt = e;
    if (!isExpand) {
      TextPainter painter = TextPainter(
        text: TextSpan(
          text: e,
          style: textStyle,
        ),
        textDirection: TextDirection.ltr,
        maxLines: isExpand ? null : 1,
      );

      painter.text = tag;
      painter.layout();
      double tagWidth = painter.width;
      double maxWidth = MediaQuery.of(context).size.width;

      if (isLastLine) {
        maxWidth = maxWidth - tagWidth - gapWidth;
      }

      for (int i = 0; i < e.length; i++) {
        painter.text = TextSpan(text: e.substring(0, i), style: textStyle);
        painter.layout(maxWidth: maxWidth);
        if (painter.width >= maxWidth) {
          txt = e.substring(0, i);
          break;
        }
      }
    }
    print('$isExpand======$txt');
    TextSpan textSpan = TextSpan(
      text: txt,
      style: textStyle,
      children: [if (isLastLine) tag],
    );
    textSpan = TextSpan(
      children: [
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            height: 4,
            width: 4,
            decoration: const BoxDecoration(
              color: Color.fromARGB(36, 49, 69, 106),
              shape: BoxShape.circle,
            ),
          ),
        ),
        textSpan
      ],
    );
    return Container(
      child: RichText(
        maxLines: isExpand ? null : 1,
        overflow: isExpand == false ? TextOverflow.ellipsis : TextOverflow.clip,
        text: textSpan,
      ),
    );
  }
}
