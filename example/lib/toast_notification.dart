import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastNotification {
  static void show({
    required BuildContext context,
    required String message,
    required String title,
    IconData icon = CupertinoIcons.chat_bubble_2_fill,
    ToastificationType type = ToastificationType.info,
    ToastificationStyle style = ToastificationStyle.flat,
    Duration animationDuration = const Duration(milliseconds: 200),
    Duration autoCloseDuration = const Duration(seconds: 6),
    required VoidCallback onTap
  }) {
    if (message.isNotEmpty) {
      toastification.dismissAll();
      toastification.show(
          context: context,
          title: Text(title, style: Theme.of(context).textTheme.labelSmall,),
          description: Text(message, style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.outline
          ),),
          alignment: Alignment.topCenter,
          showProgressBar: false,
          icon: Icon(icon, color: Theme.of(context).primaryColor,),
          style: style,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 3),
              spreadRadius: 0,
            )
          ],
          animationBuilder: (context, animation, alignment, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          dismissDirection: DismissDirection.up,
          autoCloseDuration: autoCloseDuration,
          animationDuration: animationDuration,
          callbacks: ToastificationCallbacks(
              onTap: (_) {
                toastification.dismissAll();
                onTap();
              }
          )
      );
    }
  }
}