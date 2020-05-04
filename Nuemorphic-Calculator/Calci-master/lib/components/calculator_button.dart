import 'package:flutter/material.dart';
//constants
import 'package:calculator/utilities/constants.dart';

class CalculatorButton extends StatefulWidget {
  const CalculatorButton({
    this.icon = null,
    this.text,
    this.style,
    this.isZero = false,
    @required this.onPressed,
    this.isPressed,
  });

  final text;
  final style;
  final isZero;
  final onPressed;
  final icon;
  final isPressed;

  @override
  _CalculatorButtonState createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() => _isPressed = true);
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final squareSideLength = width / 5;
    final buttonWidth = squareSideLength * (widget.isZero ? 2.2 : 1);
    final buttonSize = Size(buttonWidth, squareSideLength);

    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          width: buttonSize.width,
          height: buttonSize.height,
          child: Center(
            child: Align(
              alignment: Alignment((widget.isZero ? -0.6 : 0), 0),
              child: widget.icon == null
                  ? Text(
                      widget.text,
                      style:
                          _isPressed ? KButtonPressedTextStyle : widget.style,
                    )
                  : Icon(
                      widget.icon,
                      color: _isPressed
                          ? KOperatorTextColor
                          : KSpecialOperatorTextColor,
                    ),
            ),
          ),
          decoration:
              _isPressed ? KConcaveButtonShadow : KConvexButtonBoxShadow,
        ),
      ),
    );
  }
}
