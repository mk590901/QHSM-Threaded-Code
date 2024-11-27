import 'package:flutter_bloc/flutter_bloc.dart';
import '../events/switch_events.dart';
import '../events/event.dart';
import '../state_machines/basic_state_machine.dart';
import '../state_machines/switch_advanced_state_machine.dart';
import '../states/switch_advanced_state.dart';

class SwitchAdvancedBloc extends Bloc<Event, SwitchAdvancedState> {
  BasicStateMachine? _stateMachine;

  SwitchAdvancedBloc(super.state) {
    _stateMachine = SwitchAdvancedStateMachine(SwitchAdvancedState.state_(SwitchAdvancedStates.off));
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
    on<True>((event, emit) {
      done(event, emit);
    });
    on<False>((event, emit) {
      done(event, emit);
    });

  }

  void done(Event event, Emitter<SwitchAdvancedState> emit) {
    int newState = _stateMachine!.dispatch(event);
    if (newState >= 0) {
      SwitchAdvancedState nextState = SwitchAdvancedState(SwitchAdvancedStates.values[newState]);
      nextState.setData(event.getData());
      emit(nextState);
    }
  }
}
