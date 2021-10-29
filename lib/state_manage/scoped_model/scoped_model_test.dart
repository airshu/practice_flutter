import 'package:flutter/material.dart';
import 'package:practice_flutter/state_manage/scoped_model/scoped_model.dart';

void main() {
  runApp(
    MaterialApp(
      home: ScopedModelTest(),
    ),
  );
}

class ScopedModelTest extends StatelessWidget {
  ScopedModelTest({Key? key}) : super(key: key);

  final CountModel _model = CountModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ScopedModel<CountModel>(
          child: CountWidget(),
          model: _model,
        ),
      ),
      appBar: AppBar(
        title: const Text('scoped_model Demo'),
      ),
    );
  }
}

class CountWidget extends StatelessWidget {
  const CountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CountModel>(
      builder: (context, child, model) {
        return Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  model.count.toString(),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  model.add();
                },
                child: const Text('+'),
              ),
            ),
          ],
        );
      },
    );
  }
}

class CountModel extends Model {
  static CountModel of(BuildContext context) => ScopedModel.of<CountModel>(context);

  int _count = 0;

  int get count => _count;

  void add() {
    _count++;
    notifyListeners();
  }
}
