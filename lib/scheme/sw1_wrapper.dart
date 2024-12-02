import '../interfaces/i_switch.dart';
import '../core/q_hsm_helper.dart';
import '../core/threaded_code_executor.dart';

class Sw1Wrapper {

	QHsmHelper	helper_ = QHsmHelper('SWITCH');

	final ISwitch _switch;
	static bool process = false;

	Sw1Wrapper (this._switch) {
		createHelper();
	}

	bool inLoop() {
		return process;
	}

	// void SWITCHEntry() {
	// 	print("inside SWITCHEntry");
	// }

	// void SWITCHExit() {
	// 	print("inside SWITCHExit");
	// }

	// void SWITCHInit() {
	// 	print("inside SWITCHInit");
	// }

	// void IDLEEntry() {
	// 	print("inside IDLEEntry");
	// }

	// void IDLEExit() {
	// 	print("inside IDLEExit");
	// }

	// void IDLEInit() {
	// 	print("inside IDLEInit");
	// }

	void IDLEReset() {
		process = false;
		print("inside IDLEReset -> ******* [$process] *******");
	}

	void ONEntry() {
		print("inside ONEntry [$process]");
		//Future.microtask(() {
			turn(true);
		//});
	}

	// void ONExit() {
	// 	print("inside ONExit");
	// }

	// void ONTurn() {
	// 	print("inside ONTurn");
	// }

	void OFFEntry() {
		print("inside OFFEntry [$process]");
		//Future.microtask(() {
			turn(false);
		//});
	}

	// void OFFExit() {
	// 	print("inside OFFExit");
	// }

	void OFFTurn() {
		process = true;
		print("inside OFFTurn -> [$process]");
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

	void run(String eventName) {
		helper_.run(helper_.getState(), eventName);
	}

  void createHelper() {
		helper_.insert('SWITCH', 'init', ThreadedCodeExecutor(helper_, 'OFF', [
			// SWITCHEntry,
			// SWITCHInit,
			// IDLEEntry,
			// IDLEInit,
			OFFEntry,
		]));

		helper_.insert('OFF', 'RESET', ThreadedCodeExecutor(helper_, 'OFF', [
			IDLEReset,
			// OFFExit,
			// IDLEExit,
			// SWITCHInit,
			// IDLEEntry,
			// IDLEInit,
			OFFEntry,
		]));

		helper_.insert('ON', 'RESET', ThreadedCodeExecutor(helper_, 'OFF', [
			IDLEReset,
			// ONExit,
			// IDLEExit,
			// SWITCHInit,
			// IDLEEntry,
			// IDLEInit,
			OFFEntry,
		]));

		helper_.insert('ON', 'TURN', ThreadedCodeExecutor(helper_, 'OFF', [
			// ONTurn,
			// ONExit,
			OFFEntry,
		]));

		helper_.insert('OFF', 'TURN', ThreadedCodeExecutor(helper_, 'ON', [
			OFFTurn,
			// OFFExit,
			ONEntry,
		]));

	}
	
}
