import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_flutter/state_manage/flutter_bloc/timer/timer_event.dart';
import 'package:practice_flutter/state_manage/flutter_bloc/timer/timer_state.dart';

class Ticker {
  const Ticker();
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(TimerInitial(_duration)) {
    // 监听事件
    on<TimerStarted>(_onStarted);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<TimerTicked>(_onTicked);
    on<TimerReset>(_onReset);

  }

  static const int _duration = 60;
  final Ticker _ticker;

  StreamSubscription<int>? _tickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimerRunInProgress(event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(ticks: event.duration).listen((duration) {
      add(TimerTicked(duration: duration));
    });
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(event.duration > 0 ? TimerRunInProgress(event.duration) : TimerRunComplete());
  }

  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    if(state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      emit(TimerRunPause(state.duration));// 发送事件
    }
  }

  void _onResumed(TimerResumed event, Emitter<TimerState> emit) {
    print('_onResumed------ $state');
    if(state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgress(state.duration));
    }
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(TimerInitial(_duration));
  }
}
