enum ButtonStates { ready, pressed, disabled }

// int state_(ButtonStates state) {
//   return state.index;
// }

class ButtonState {

  static int state_(ButtonStates state) {
    return state.index;
  }

  final ButtonStates _state;
  String? _data;

  ButtonState(this._state) {
    _data = null;
  }

  ButtonStates state() {
    return _state;
  }

  void setData(String? data) {
    _data = data;
  }

  String? data() {
    return _data;
  }
}
