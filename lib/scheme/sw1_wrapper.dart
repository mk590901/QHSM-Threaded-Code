import '../interfaces/i_switch.dart';
import '../q_hsm_helper.dart';
import '../threaded_code_executor.dart';
import '../utils.dart';

class Sw1Wrapper {

	QHsmHelper	helper_ = QHsmHelper('SWITCH');

	//late String currentState = '';
	late String currentState = 'OFF';

	final ISwitch _switch;
	static bool process = false;
	//Map<String, void Function()> lookupTable = <String, void Function()>{};
	Sw1Wrapper (this._switch) {
		//createWalker();
		createHelper();
	}

	bool inLoop() {
		return process;
	}

	// void createWalker() {
	// 	lookupTable[createKey("SWITCH","Q_ENTRY")]	= SWITCHEntry;
	// 	lookupTable[createKey("SWITCH","Q_EXIT")]	= SWITCHExit;
	// 	lookupTable[createKey("SWITCH","Q_INIT")]	= SWITCHInit;
	// 	lookupTable[createKey("IDLE","Q_ENTRY")]	= IDLEEntry;
	// 	lookupTable[createKey("IDLE","Q_EXIT")]	= IDLEExit;
	// 	lookupTable[createKey("IDLE","Q_INIT")]	= IDLEInit;
	// 	lookupTable[createKey("IDLE","RESET")]	= IDLEReset;
	// 	lookupTable[createKey("ON","Q_ENTRY")]	= ONEntry;
	// 	lookupTable[createKey("ON","Q_EXIT")]	= ONExit;
	// 	lookupTable[createKey("ON","TURN")]	= ONTurn;
	// 	lookupTable[createKey("OFF","Q_ENTRY")]	= OFFEntry;
	// 	lookupTable[createKey("OFF","Q_EXIT")]	= OFFExit;
	// 	lookupTable[createKey("OFF","TURN")]	= OFFTurn;
	// }

	void SWITCHEntry() {
		print("inside SWITCHEntry");
	}

	void SWITCHExit() {
		print("inside SWITCHExit");
	}

	void SWITCHInit() {
		print("inside SWITCHInit");
	}

	void IDLEEntry() {
		print("inside IDLEEntry");
	}

	void IDLEExit() {
		print("inside IDLEExit");
	}

	void IDLEInit() {
		print("inside IDLEInit");
	}

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

	void ONExit() {
		print("inside ONExit");
	}

	void ONTurn() {
		print("inside ONTurn");
	}

	void OFFEntry() {
		print("inside OFFEntry [$process]");
		//Future.microtask(() {
			turn(false);
		//});
	}

	void OFFExit() {
		print("inside OFFExit");
	}

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

	void initChain() {
		helper_.run(helper_.getState(), 'init');
	}

	// void doreset() {
	// 	helper_.run(helper_.getState(), 'RESET');
	// }
	//
	// void doturn() {
	// 	helper_.run(helper_.getState(), 'TURN');
	// }

	void run(String eventName) {
		helper_.run(helper_.getState(), eventName);
	}

	// void resetChain() {
	// 	if (currentState == 'OFF') {
	// 		OFFResetChain();
	// 	}
	// 	else
	// 	if (currentState == 'ON') {
	// 		ONResetChain();
	// 	}
	// }

	// void turnChain() {
	// 	if (currentState == 'OFF') {
	// 		OFFTurnChain();
	// 	}
	// 	else
	// 	if (currentState == 'ON') {
	// 		ONTurnChain();
	// 	}
	// }

	// void OFFResetChain() {
	// 	Future.microtask(() {
	// 		IDLEReset();
	// 		OFFExit();
	// 		IDLEExit();
	// 		SWITCHInit();
	// 		IDLEEntry();
	// 		IDLEInit();
	// 		OFFEntry();
	// 		currentState = 'OFF';
	// 	});
	// }

	// void OFFTurnChain() {
	// 	Future.microtask(() {
	// 		OFFTurn();
	// 		OFFExit();
	// 		ONEntry();
	// 		currentState = 'ON';
	// 	});
	// }

	// void ONTurnChain() {
	// 	Future.microtask(() {
	// 		ONTurn();
	// 		ONExit();
	// 		OFFEntry();
	// 		currentState = 'OFF';
	// 	});
	// }

	// void ONResetChain() {
	// 	Future.microtask(() {
	// 		IDLEReset();
	// 		ONExit();
	// 		IDLEExit();
	// 		SWITCHInit();
	// 		IDLEEntry();
	// 		IDLEInit();
	// 		OFFEntry();
	// 		currentState = 'OFF';
	// 	});
	// }

  void createHelper() {
		helper_.insert('SWITCH', 'init', ThreadedCodeExecutor(helper_, 'OFF', [
			SWITCHEntry,
			SWITCHInit,
			IDLEEntry,
			IDLEInit,
			OFFEntry,
		]));

		helper_.insert('OFF', 'RESET', ThreadedCodeExecutor(helper_, 'OFF', [
			IDLEReset,
			OFFExit,
			IDLEExit,
			SWITCHInit,
			IDLEEntry,
			IDLEInit,
			OFFEntry,
		]));

		helper_.insert('ON', 'RESET', ThreadedCodeExecutor(helper_, 'OFF', [
			IDLEReset,
			ONExit,
			IDLEExit,
			SWITCHInit,
			IDLEEntry,
			IDLEInit,
			OFFEntry,
		]));

		helper_.insert('ON', 'TURN', ThreadedCodeExecutor(helper_, 'OFF', [
			ONTurn,
			ONExit,
			OFFEntry,
		]));

		helper_.insert('OFF', 'TURN', ThreadedCodeExecutor(helper_, 'ON', [
			OFFTurn,
			OFFExit,
			ONEntry,
		]));

	}
	
}
