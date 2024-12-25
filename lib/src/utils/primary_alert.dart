import 'dart:ui';

import 'package:babylai/src/core/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget {
  final String title;
  final String content;
  final String action1Text;
  final VoidCallback action1Callback;
  final String action2Text;
  final VoidCallback action2Callback;

  const CustomAlert({
    Key? key,
    required this.title,
    required this.content,
    required this.action1Text,
    required this.action1Callback,
    required this.action2Text,
    required this.action2Callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Padding(
          padding: EdgeInsets.zero,
          child: AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceBetween,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            actions: [
              Row(
                children: [
                  Expanded(
                      child: RoundedButtonWidget(
                        buttonText: action1Text,
                        onPressed: action1Callback,
                      )
                  ),
                  SizedBox(width: 8,),
                  Expanded(
                      child: RoundedButtonWidget(
                        buttonText: action2Text,
                        onPressed: action2Callback,
                        buttonColor: Theme.of(context).colorScheme.onInverseSurface,
                        textColor: Theme.of(context).colorScheme.outline,
                      )
                  ),
                ],
              )
            ],
            title: Text(
                title,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).primaryColor
                ),
            ),
            content: Text(
                content,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface
                )
            ),
          ),
        ),
      ),
    );
  }
}