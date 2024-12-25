import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  final Color textColor;
  final Color? borderColor;
  final String? imagePath;
  final double buttonTextSize;
  final double? height;
  final VoidCallback? onPressed;
  final ShapeBorder shape;

  const RoundedButtonWidget({
    Key? key,
    this.buttonText,
    this.buttonColor,
    this.textColor = Colors.white,
    this.onPressed,
    this.imagePath,
    this.borderColor,
    this.shape = const StadiumBorder(),
    this.buttonTextSize = 16.0,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor:  MaterialStateProperty.all<Color>(buttonColor ?? Theme.of(context).primaryColor)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          imagePath != null
              ? Image.asset(
            imagePath!,
            height: 15.0,
          )
              : SizedBox.shrink(),
          SizedBox(width: 5.0),
          Text(
            buttonText!,
            overflow: TextOverflow.clip,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w500,
              fontSize: buttonTextSize,
            ),
          ),
        ],
      ),
    );
  }
}