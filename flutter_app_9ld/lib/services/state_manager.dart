import 'package:flutter/material.dart';

class StateManager extends State {
  void rebuildWidget(State state) {
    _rebuildWidgets(states: [state]);
  }

  void _rebuildWidgets({VoidCallback? setStates, required List<State> states}) {
    for (var s in states) {
      if (s.mounted) {
        s.setState(setStates ?? () {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Text("This should not be called. It is required by state interface");
  }
}
