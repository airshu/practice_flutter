import 'package:equatable/equatable.dart';

abstract class TimerState extends Equatable {
  final int duration;

  TimerState(this.duration);

  @override
  List<Object?> get props => [duration];
}

class TimerInitial extends TimerState {
  TimerInitial(int duration) : super(duration);

  @override
  String toString() {
    return 'TimerInitial {duration: $duration }';
  }
}

class TimerRunPause extends TimerState {
  TimerRunPause(int duration) : super(duration);

  @override
  String toString() {
    return 'TimerRunPause { duration: $duration }';
  }
}

class TimerRunInProgress extends TimerState {
  TimerRunInProgress(int duration) : super(duration);

  @override
  String toString() {
    return 'TimerRunInProgress { duration: $duration}';
  }
}

class TimerRunComplete extends TimerState {
  TimerRunComplete() : super(0);
}
