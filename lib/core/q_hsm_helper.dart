import 'i_q_hsm_state_machine_helper.dart';
import 'threaded_code_executor.dart';
import 'utils.dart';

class QHsmHelper implements IQHsmStateMachineHelper {

  late String _state;
  final Map<String,ThreadedCodeExecutor> _container = {};

  QHsmHelper(this._state);

  void insert (String state, String event, ThreadedCodeExecutor executor) {
    _container[createKey(state,event)] = executor;
  }

  void run (String state, String event) {
    String key = createKey(state, event);
    if (!_container.containsKey(key)) {
      print('run.error: $state->$event');
      return;
    }
    ThreadedCodeExecutor? executor = _container[key];
    executor?.execute();
  }

  @override
  String getState() {
    return _state;
  }

  @override
  void setState(String state) {
    _state = state;
  }

}