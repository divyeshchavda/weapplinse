import 'package:flutter/material.dart';

class IncrementAction {}

class DecrementAction {}


class CurrentState {
  final int count;
  CurrentState(this.count);
}


CurrentState counterReducer(CurrentState state, dynamic action) {
  if (action is IncrementAction) {
    return CurrentState(state.count + 1);
  } else if (action is DecrementAction) {
    return CurrentState(state.count - 1);
  }
  return state;
}


class CounterState extends ChangeNotifier {
  CurrentState _state = CurrentState(0);
  CurrentState get state => _state;

  void dispatch(dynamic action) {
    _state = counterReducer(_state, action);
    notifyListeners();
  }
}
