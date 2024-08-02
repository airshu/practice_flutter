import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  // debugPrintLayouts = true;
  // debugPrintRebuildDirtyWidgets = true;
  // bool flag = false;
  runApp(SingleWidget());
  // runApp(Directionality(
  //   textDirection: TextDirection.ltr,
  //   child: StatefulBuilder(
  //     builder: (context, setState) {
  //
  //       return Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Tooltip(
  //             message: '1232113123',
  //             child: Icon(Icons.info_outline, color: Colors.red, size: 50,),
  //           ),
  //           if (!flag)
  //             Text('456', style: TextStyle(color: Colors.red),),
  //           ElevatedButton(
  //               onPressed: () {
  //                 setState(
  //                   () {
  //                     flag = true;
  //                   },
  //                 );
  //               },
  //               child: Text('Test')),
  //         ],
  //       );
  //     },
  //   ),
  // ));

  // runApp(MaterialApp(
  //   home: StatefulBuilder(
  //     builder: (context, setState) {
  //       bool flag = false;
  //       return Scaffold(
  //       body: Column(
  //         children: [
  //           Text('123'),
  //           if(flag)
  //             Text('456'),
  //         ],
  //       ),
  //       floatingActionButton: FloatingActionButton(
  //         onPressed: (){
  //           setState((){
  //             flag = true;
  //           });
  //         },
  //       ),
  //     );
  //     },
  //   ),
  // ));
  // runApp(Directionality(
  //     textDirection: TextDirection.ltr,
  //     child: Column(
  //       children: [
  //         // Text('123'),
  //         // Text('456'),
  //         SizedBox(width: 10,),
  //         Icon(Icons.add),
  //       ],
  //     )));
}

class SingleWidget extends StatelessWidget {
  const SingleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print('>>>>>>>');
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Builder(builder: (context) {
              return ElevatedButton(
                  onPressed: () {
                    final OverlayState overlayState = Overlay.of(context);
                    final RenderBox box = context.findRenderObject()! as RenderBox;
                    final Offset target = box.localToGlobal(
                      box.size.center(Offset.zero),
                      ancestor: overlayState.context.findRenderObject(),
                    );

                    OverlayEntry entry = OverlayEntry(
                      builder: (context) {
                        return Container(
                          // color: Colors.blue,
                          child: Stack(
                            children: [Positioned(
                              top: target.dy,
                              left: target.dx,
                              child: Container(color: Colors.red, child: Text('111')),
                            ),]
                          ),
                        );
                      },
                    );
                    overlayState.insert(entry);
                  },
                  child: Text('asdfdsf'));
            }),
            Tooltip(
              preferBelow: false,
              triggerMode: TooltipTriggerMode.tap,
              message: 'adsfdsfdsf13123213',
              child: Text('asdfdsf'),
            )
          ],
        ),
      ),
    );
  }
}
