import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocExample extends StatelessWidget {
  BlocExample({super.key}) {
    Bloc.observer = MyBlocObserver();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MyBloc(MyState(name: 'name')),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    print('onCreate: $bloc');
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    print('onClose: $bloc');
    super.onClose(bloc);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    print('onError: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    print('onTransition: $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    print('onChange: $change');
    super.onChange(bloc, change);
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    print('onEvent: $event');
    super.onEvent(bloc, event);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    BlocProvider.of<MyBloc>(context).add(MyEvent(name: 'hhhhhh'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc 示例'),
      ),
    );
  }
}

class MyEvent extends Equatable {
  @override
  List<Object?> get props => [];

  final String name;

  MyEvent({required this.name});
}

class MyState extends Equatable {
  @override
  List<Object?> get props => [];

  final String name;

  MyState({required this.name});
}

class MyBloc extends Bloc<MyEvent, MyState> {
  MyBloc(MyState myState) : super(myState) {
    on<MyEvent>(
      (event, emit) {
        print('======>>>>>>$event  $emit');

        emit(MyState(name: event.name));
      },
    );
  }
}
