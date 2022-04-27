import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);

  void decrement() => emit(state - 1);
}

void main() => runApp(
      MaterialApp(
        home: BlocProvider(
          create: (_) => CounterCubit(),
          child: CounterApp(),
          lazy: false,
        ),
      ),
    );

class CounterApp extends StatelessWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // context.select((value) {
    //   print('====================== $value');
    // });

    return Scaffold(
      appBar: AppBar(
        title: Text('Counter'),
      ),
      body: Column(
        children: [
          BlocBuilder<CounterCubit, int>(
            builder: (context, state) => Center(
              child: Text('$state'),
            ),
          ),
          BlocListener<CounterCubit, int>(
            listener: (context, state) {
              print('BlocListener----------------- state=$state');
            },
            child: Text('==='),
            listenWhen: (previous, current) {
              return false; // false 不会调用listener方法
            },
          ),
          BlocConsumer<CounterCubit, int>(
            builder: (context, state) {
              if(state is int) {
                if(state as int > 5)
                  return Text('BlocConsumer===> $state');
              }
              return Icon(Icons.settings);
            },
            listener: (context, state) {
              print('BlocConsumer listener ----->$state');
            },
            listenWhen: (previous, current) {
              return true;//
            },
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<CounterCubit>(context).increment();
              // context.read<CounterCubit>().increment();
            },
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterCubit>().decrement();
            },
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
