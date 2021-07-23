import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/src/wave.dart';

class LiquidCustomProgressIndicatorView extends ProgressIndicator {
  ///The widget to show in the center of the progress indicator.
  final Widget? center;

  ///The direction the liquid travels.
  final Axis direction;

  LiquidCustomProgressIndicatorView({
    required this.direction,
    Key? key,
    double value = 0.5,
    Color? backgroundColor,
    Animation<Color>? valueColor,
    this.center,
  }) : super(
          key: key,
          value: value,
          backgroundColor: backgroundColor,
          valueColor: valueColor,
        );

  Color _getValueColor(BuildContext context) =>
      valueColor?.value ?? Theme.of(context).accentColor;

  @override
  State<StatefulWidget> createState() =>
      _LiquidCustomProgressIndicatorViewState();
}

class _LiquidCustomProgressIndicatorViewState
    extends State<LiquidCustomProgressIndicatorView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Colors.white,
          width: 5,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            left: 0,
            top: 0,
            child: Wave(
              value: widget.value,
              color: widget._getValueColor(context),
              direction: widget.direction,
            ),
          ),
          if (widget.center != null) Center(child: widget.center),
        ],
      ),
    );
  }
}
