import '../events/switch_events.dart';
import '../events/event.dart';
import '../interfaces/trans_methods.dart';
import '../states/switch_advanced_state.dart';
import 'basic_state_machine.dart';
import 'state.dart';
import 'trans.dart';

class SwitchAdvancedStateMachine extends BasicStateMachine {
  SwitchAdvancedStateMachine(super.currentState);

  @override
  void create() {
    states_[SwitchAdvancedState.state_(SwitchAdvancedStates.off)] = State([
      Trans(Disable(),  SwitchAdvancedState.state_(SwitchAdvancedStates.disabled_off), OnDisableOff()),
      Trans(Reset(),    SwitchAdvancedState.state_(SwitchAdvancedStates.off), OnNothing()),
      Trans(Down(),     SwitchAdvancedState.state_(SwitchAdvancedStates.off2on), OnDown()),
      Trans(False(),    SwitchAdvancedState.state_(SwitchAdvancedStates.off), OnNothing()),
      Trans(True(),     SwitchAdvancedState.state_(SwitchAdvancedStates.on), OnNothing()),
    ]);

    states_[SwitchAdvancedState.state_(SwitchAdvancedStates.on)] = State([
      Trans(Disable(),  SwitchAdvancedState.state_(SwitchAdvancedStates.disabled_on), OnDisableOn()),
      Trans(Reset(),    SwitchAdvancedState.state_(SwitchAdvancedStates.off), OnNothing()),
      Trans(Down(),     SwitchAdvancedState.state_(SwitchAdvancedStates.on2off), OnDown()),
      Trans(False(),    SwitchAdvancedState.state_(SwitchAdvancedStates.off), OnNothing()),
      Trans(True(),     SwitchAdvancedState.state_(SwitchAdvancedStates.on), OnNothing()),
    ]);

    states_[SwitchAdvancedState.state_(SwitchAdvancedStates.disabled_off)] = State([
      Trans(Enable(),   SwitchAdvancedState.state_(SwitchAdvancedStates.off), OnEnableOff()),
    ]);

    states_[SwitchAdvancedState.state_(SwitchAdvancedStates.disabled_on)] = State([
      Trans(Enable(),   SwitchAdvancedState.state_(SwitchAdvancedStates.on), OnEnableOn()),
    ]);

    states_[SwitchAdvancedState.state_(SwitchAdvancedStates.off2on)] = State([
      Trans(Reset(),    SwitchAdvancedState.state_(SwitchAdvancedStates.off), OnNothing()),
      Trans(Up(),       SwitchAdvancedState.state_(SwitchAdvancedStates.on), OnUp())
    ]);

    states_[SwitchAdvancedState.state_(SwitchAdvancedStates.on2off)] = State([
      Trans(Reset(),    SwitchAdvancedState.state_(SwitchAdvancedStates.on), OnNothing()),
      Trans(Up(),       SwitchAdvancedState.state_(SwitchAdvancedStates.off), OnUp())
    ]);
  }

  @override
  String? getEventName(int event) {
    // TODO: implement getEventName
    throw UnimplementedError();
  }

  @override
  String? getStateName(int state) {
    String result = SwitchAdvancedStates.values[state].name;
    return result;
  }

  @override
  void publishEvent(Event event) {
    // TODO: implement publishEvent
  }

  @override
  void publishState(int state) {
    // TODO: implement publishState
  }
}
