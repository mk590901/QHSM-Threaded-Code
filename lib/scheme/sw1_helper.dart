//	Class Sw1Helper automatically generated at 2024-12-02 11:56:58
import '../core/q_hsm_helper.dart';
import '../core/threaded_code_executor.dart';
import '../interfaces/i_switch.dart';

class Sw1Helper {

  final QHsmHelper	helper_ = QHsmHelper('SWITCH');

  final ISwitch _switch;
  static bool process = false;

  Sw1Helper(this._switch) {
    createHelper();
  }

  bool inLoop() {
    return process;
  }

  // void switchEntry([Object? data]) {
  // }
  //
  // void switchInit([Object? data]) {
  // }
  //
  // void idleEntry([Object? data]) {
  // }
  //
  // void idleInit([Object? data]) {
  // }

  void offEntry([Object? data]) {
    turn(false);
  }

  void idleReset([Object? data]) {
    process = false;
  }

  // void idleExit([Object? data]) {
  // }
  //
  // void onExit([Object? data]) {
  // }
  //
  // void onTurn([Object? data]) {
  // }
  //
  // void offExit([Object? data]) {
  // }

  void offTurn([Object? data]) {
    process = true;
  }

  void onEntry([Object? data]) {
    turn(true);
  }

  void turn(bool on) async {

    await Future.delayed(const Duration(milliseconds: 500));

    on ? _switch.t() : _switch.f();

    if (!process) {

      print ('******* turn.process->[$process] *******');

      return;
    }

    _switch.done('TURN');

  }

  void init() {
    helper_.run(helper_.getState(), 'init');
  }

  void run(final String eventName) {
    helper_.run(helper_.getState(), eventName);
  }

  void createHelper() {
    helper_.insert('SWITCH', 'init', ThreadedCodeExecutor(helper_, 'OFF', [
      // switchEntry,
      // switchInit,
      // idleEntry,
      // idleInit,
      offEntry,
    ]));
    helper_.insert('IDLE', 'RESET', ThreadedCodeExecutor(helper_, 'OFF', [
      idleReset,
      // idleExit,
      // switchInit,
      // idleEntry,
      // idleInit,
      offEntry,
    ]));
    helper_.insert('ON', 'RESET', ThreadedCodeExecutor(helper_, 'OFF', [
      idleReset,
      // onExit,
      // idleExit,
      // switchInit,
      // idleEntry,
      // idleInit,
      offEntry,
    ]));
    helper_.insert('ON', 'TURN', ThreadedCodeExecutor(helper_, 'OFF', [
      // onTurn,
      // onExit,
      offEntry,
    ]));
    helper_.insert('OFF', 'RESET', ThreadedCodeExecutor(helper_, 'OFF', [
      idleReset,
      // offExit,
      // idleExit,
      // switchInit,
      // idleEntry,
      // idleInit,
      offEntry,
    ]));
    helper_.insert('OFF', 'TURN', ThreadedCodeExecutor(helper_, 'ON', [
      offTurn,
      // offExit,
      onEntry,
    ]));
  }
}
