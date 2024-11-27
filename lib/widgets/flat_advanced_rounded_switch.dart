import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../size_config.dart';
import '../blocks/switch_advanced_bloc.dart';
import '../events/switch_events.dart';
import '../states/switch_advanced_state.dart';
import '../interfaces/i_click.dart';

class FlatAdvancedRoundedSwitch extends StatelessWidget implements IClick {
  final String uuid = const Uuid().v4().toString();

  final Color canvasTColor;
  final Color canvasFColor;
  final Color canvasDColor;
  final Color canvasUColor;
  final Color iconTColor;
  final Color iconFColor;
  final Color iconDColor;
  final Color iconUColor;
  final Color canvasDisabledColor;
  final Color iconDisabledColor;
  final double width;
  final double height;
  final double borderRadius;
  final double borderWidth;
  final Color borderTColor;
  final Color borderFColor;
  final Color borderDColor;
  final Color borderUColor;
  final IconData? T;
  final IconData? F;
  final VoidCallback? onUpAction;
  final VoidCallback? onDownAction;

  late GestureDetector gestureDetector;

  final SwitchAdvancedBloc switchBloc = SwitchAdvancedBloc(SwitchAdvancedState(SwitchAdvancedStates.off));

  FlatAdvancedRoundedSwitch({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 4,
    this.borderWidth = 1,
    this.borderTColor = Colors.black,
    this.borderFColor = Colors.black,
    this.borderDColor = Colors.black,
    this.borderUColor = Colors.black,
    this.canvasTColor = Colors.transparent,
    this.canvasFColor = Colors.transparent,
    this.canvasDColor = Colors.black26,
    this.canvasUColor = Colors.black26,
    this.iconTColor = Colors.black,
    this.iconFColor = Colors.black,
    this.iconDColor = Colors.black,
    this.iconUColor = Colors.black,
    this.canvasDisabledColor = Colors.black12,
    this.iconDisabledColor = Colors.black26,
    this.T = Icons.toggle_on_outlined,
    this.F = Icons.toggle_off_outlined,
    this.onUpAction,
    this.onDownAction,
  });

  @override
  void click() {
    gestureDetector.onTapDown?.call(TapDownDetails());
    gestureDetector.onTapUp?.call(TapUpDetails(kind: PointerDeviceKind.touch));
  }

  void t() {
    try {
      switchBloc.add(True());
    } catch (exception) {
      debugPrint("******* reset error *******");
    }
  }

  void f() {
    try {
      switchBloc.add(False());
    } catch (exception) {
      debugPrint("******* reset error *******");
    }
  }

  void reset() {
    try {
      switchBloc.add(Reset());
    } catch (exception) {
      debugPrint("******* reset error *******");
    }
  }

  void enable() {
    try {
      switchBloc.add(Enable());
    } catch (exception) {
      debugPrint("******* enable error *******");
    }
  }

  void disable() {
    try {
      switchBloc.add(Disable());
    } catch (exception) {
      debugPrint("******* disable error *******");
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double? borderRadius_ = w_(borderRadius);
    double? borderWidth_ = w_(borderWidth);
    return BlocProvider<SwitchAdvancedBloc>(
       create: (_) {
        return switchBloc;
      },
      child: BlocBuilder<SwitchAdvancedBloc, SwitchAdvancedState>(builder: (context, state) {
        gestureDetector = GestureDetector(
          onTapDown: (details) {
            context.read<SwitchAdvancedBloc>().add(Down(uuid));
            onDownAction?.call();
          },
          onTapUp: (details) {
            context.read<SwitchAdvancedBloc>().add(Up(uuid));
            onUpAction?.call();
          },
          onTapCancel: () {
            context.read<SwitchAdvancedBloc>().add(Reset());
          }
          ,
          child: Container(
            width: w_(width),
            height: h_(height),
            decoration: BoxDecoration(
              color: getCanvasColor(state.state()),
              borderRadius: BorderRadius.circular(borderRadius_!),
              border: Border.all(color: getBorderColor(state.state()), width: borderWidth_!),
            ),
            child: Center(
              child: Icon(getIcon(state.state()),
                  size: h_(height * getIconSize(state.state())), color: getIconColor(state.state())),
            ),
          ),
        );
        return gestureDetector;
      }),
    );
  }

  Color? getIconColor(SwitchAdvancedStates state) {
    Color? result = iconFColor;
    switch(state) {
      case SwitchAdvancedStates.off:
        result = iconFColor;
        break;
      case SwitchAdvancedStates.on:
        result = iconTColor;
        break;
      case SwitchAdvancedStates.off2on:
        result = iconUColor;
        break;
      case SwitchAdvancedStates.on2off:
        result = iconDColor;
        break;
      case SwitchAdvancedStates.disabled_off:
      case SwitchAdvancedStates.disabled_on:
        result = iconDisabledColor;
        break;
      default:
    }
    return result;
  }

  double getIconSize(SwitchAdvancedStates state) {
    double result = 0.8;
    switch(state) {
      case SwitchAdvancedStates.off:
      case SwitchAdvancedStates.on:
        result = 0.8;
        break;
      case SwitchAdvancedStates.off2on:
      case SwitchAdvancedStates.on2off:
        result = 0.95;
        break;
      default:
    }
    return result;
  }

  IconData? getIcon(SwitchAdvancedStates state) {
    IconData? result = F;
    switch (state) {
      case SwitchAdvancedStates.off:
      case SwitchAdvancedStates.disabled_off:
        result = F;
        break;
      case SwitchAdvancedStates.on:
      case SwitchAdvancedStates.disabled_on:
        result = T;
        break;
      default:
    }
    return result;
  }

  Color? getCanvasColor(SwitchAdvancedStates state) {
    Color? result = canvasFColor;
    switch(state) {
      case SwitchAdvancedStates.off:
        result = canvasFColor;
        break;
      case SwitchAdvancedStates.on:
        result = canvasTColor;
        break;
      case SwitchAdvancedStates.off2on:
        result = canvasUColor;
        break;
      case SwitchAdvancedStates.on2off:
        result = canvasDColor;
        break;
      case SwitchAdvancedStates.disabled_off:
      case SwitchAdvancedStates.disabled_on:
        result = canvasDisabledColor;
        break;
      default:
    }
    return result;
  }

  getBorderColor(SwitchAdvancedStates state) {
    Color? result = borderFColor;
    switch(state) {
      case SwitchAdvancedStates.off:
        result = borderFColor;
        break;
      case SwitchAdvancedStates.on:
        result = borderTColor;
        break;
      case SwitchAdvancedStates.off2on:
        result = borderUColor;
        break;
      case SwitchAdvancedStates.on2off:
        result = borderDColor;
        break;
      default:
    }
    return result;
  }

}
