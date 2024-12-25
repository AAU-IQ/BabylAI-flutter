import 'package:babylai/gen/assets.gen.dart';
import 'package:babylai/src/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' as Intl;
import 'package:lottie/lottie.dart';
import '../../domain/entity/message/message_entity.dart';

class MessageBubble extends StatelessWidget {
  final MessageEntity message;

  const MessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (message.text == "thinking" && message.senderType == SenderType.ai) {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              children: [
                Lottie.asset(
                  Assets.lib.assets.lottie.robot,
                  width: 65,
                  height: 65,
                  fit: BoxFit.fill,
                  animate: true,
                  repeat: true,
                ),
                Text(
                  context.localizations.ai_loading,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ),
      );
    }

    final isUser = message.isSentByUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Directionality(
          textDirection: TextDirection.ltr, // Enforce LTR layout
          child: isUser
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 4, horizontal: 16),
                padding: const EdgeInsets.all(12),
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75),
                decoration: BoxDecoration(
                  color: message.getColor(context),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                    bottomLeft: const Radius.circular(16),
                    bottomRight: const Radius.circular(0),
                  ),
                ),
                child: Text(
                  message.text,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  Intl.DateFormat('hh:mm a').format(message.time),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      color: Theme.of(context).hintColor),
                ),
              )
            ],
          )
              : Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 19, left: 16),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: SvgPicture.asset(
                      message.iconName,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: message.getColor(context),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 4, horizontal: 10),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width *
                            0.75),
                    decoration: BoxDecoration(
                      color: message.getColor(context),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: const Radius.circular(0),
                        bottomRight: const Radius.circular(16),
                      ),
                    ),
                    child: message.senderType == SenderType.agent
                        ? Text(
                      message.text,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface,
                          fontSize: 14),
                    )
                        : Directionality(
                          textDirection: TextDirection.rtl,
                          child: MarkdownBody(
                                                data: message.text,
                                              ),
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      Intl.DateFormat('hh:mm a').format(message.time),
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(
                          fontSize: 10,
                          color: Theme.of(context).hintColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}