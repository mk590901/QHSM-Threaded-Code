import 'package:flutter/material.dart';
import 'interfaces/i_switch.dart';
import 'scheme/sw1_helper.dart';
import 'widgets/flat_advanced_rounded_switch.dart';
import 'widgets/flat_text_rounded_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AppHomePage(title: 'QQHsm/Threaded code (opt)'),
    );
  }
}

class AppHomePage extends StatelessWidget implements ISwitch {

  final String title;
  late FlatAdvancedRoundedSwitch flatSwitch;
  late FlatTextRoundedButton turnButton;

  late Sw1Helper hsmHelper = Sw1Helper(this);

  AppHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text(title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontStyle: FontStyle.italic,
            shadows: [
              Shadow(
                blurRadius: 8.0,
                color: Colors.indigo,
                offset: Offset(3.0, 3.0),
              ),
            ],
          )),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.blur_on_sharp, color: Colors.white, size: 40),
        // Icon widget
        onPressed: () {
          // Add your onPressed logic here
        },
      ),
      backgroundColor: Colors.lightBlue,
    );

    flatSwitch = FlatAdvancedRoundedSwitch(
        width: 72,
        height: 72,
        borderWidth: 0.5,
        canvasFColor: Colors.blueAccent,
        canvasTColor: Colors.blueAccent,
        borderFColor: Colors.white30,
        borderTColor: Colors.white,
        borderDColor: Colors.cyanAccent,
        borderUColor: Colors.cyan,
        iconFColor: Colors.white30,
        iconTColor: Colors.white,
        T: Icons.blur_on_sharp,
        F: Icons.blur_on_sharp,
        onDownAction: () {
        },
        onUpAction: () {
        });

    FlatTextRoundedButton resetButton = FlatTextRoundedButton(
      width: 36,
      height: 12,
      canvasColor: Colors.blueAccent,
      canvasDisabledColor: Colors.blueGrey,
      canvasPressedColor: Colors.indigo,
      textColor: Colors.limeAccent,
      textDisabledColor: Colors.white70,
      textPressedColor: Colors.white,
      text: 'Reset',
      textPressed: 'Reset!',
      textDisabled: 'Disabled',
      borderColor: Colors.white70,
      borderPressedColor: Colors.white30,
      borderDisabledColor: Colors.blueGrey,
      borderWidth: 0.5,
      borderRadius: 8,
      onUpAction: () {
        done('RESET');
        turnButton.enable();
      },
      onDownAction: () {
      },
    );

    turnButton = FlatTextRoundedButton(
      width: 36,
      height: 12,
      canvasColor: Colors.blueAccent,
      canvasDisabledColor: Colors.blueGrey,
      canvasPressedColor: Colors.indigo,
      textColor: Colors.limeAccent,
      textDisabledColor: Colors.white70,
      textPressedColor: Colors.white,
      text: 'Turn',
      textPressed: 'Turn!',
      textDisabled: 'Disabled',
      borderColor: Colors.white70,
      borderPressedColor: Colors.white30,
      borderDisabledColor: Colors.blueGrey,
      borderWidth: 0.5,
      borderRadius: 8,
      onUpAction: () {
        if (hsmHelper.inLoop()) {
         return;
        }
        done('TURN');
        turnButton.disable();
      },
      onDownAction: () {
      },
    );

    void initHsmEngine() {
      //hsmWrapper = /*Sw1Wrapper*/Sw1Helper(this);
      hsmHelper.init();
    }

    Future.microtask(() {
      // Ensure this code runs after the build method completes
      if (context.mounted) {
        initHsmEngine();
      }
    });

    return Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: appBar,
        body: Align(
            alignment: Alignment.center,
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OverflowBar(
                          alignment: MainAxisAlignment.center,
                          children: <Widget>[
                            flatSwitch,
                          ]),

                      const SizedBox(
                        height: 64,
                      ),

                      OverflowBar(
                          alignment: MainAxisAlignment.center,
                          children: <Widget>[
                            resetButton,
                            const SizedBox(
                              width: 8,
                            ),
                            turnButton,
                          ]),
                    ]))));
  }

  @override
  void done(String eventName) {
    hsmHelper.run(eventName);
  }

  @override
  void t() {
    flatSwitch.t();
    print ('flatSwitch->TRUE');
  }

  @override
  void f() {
    flatSwitch.f();
    print ('flatSwitch->FALSE');
  }

}
