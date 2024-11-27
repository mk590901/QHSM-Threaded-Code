import 'package:flutter_bloc/flutter_bloc.dart';
import '../events/switch_events.dart';
import '../events/event.dart';
import '../state_machines/basic_state_machine.dart';
import '../state_machines/button_state_machine.dart';
import '../states/button_state.dart';

class ButtonBloc extends Bloc<Event, ButtonState> {
  BasicStateMachine? _stateMachine;

  ButtonBloc(ButtonState initialState) : super(initialState) {
    _stateMachine = ButtonStateMachine(initialState.state().index);
    on<Reset>((event, emit) {
      done(event, emit);
    });
    on<Down>((event, emit) {
      done(event, emit);
    });
    on<Up>((event, emit) {
      done(event, emit);
    });
    on<Enable>((event, emit) {
      done(event, emit);
    });
    on<Disable>((event, emit) {
      done(event, emit);
    });
    on<ChangeText>((event, emit) {
      done(event, emit);
    });
  }

  void done(Event event, Emitter<ButtonState> emit) {
    int newState = _stateMachine!.dispatch(event);
    if (newState >= 0) {
      ButtonState nextState = ButtonState(ButtonStates.values[newState]);
      nextState.setData(event.getData());
      emit(nextState);
    }
  }
}
