import 'dart:convert';
import 'dart:math';
import 'package:babylai/babylai.dart';
import 'package:babylai/l10n/gen/app_localizations.dart';
import 'package:babylai/src/constants/app_bar.dart';
import 'package:babylai/src/constants/app_colors.dart';
import 'package:babylai/src/core/widgets/message_bubble_widget.dart';
import 'package:babylai/src/domain/entity/help_screen_entity.dart';
import 'package:babylai/src/presentation/chat_screen/store/chat_screen_store.dart';
import 'package:babylai/src/services/signalr_service.dart';
import 'package:babylai/src/utils/extensions.dart';
import 'package:babylai/src/utils/primary_alert.dart';
import 'package:flutter/material.dart';
import 'package:babylai/gen/assets.gen.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobx/mobx.dart';

import '../../di/service_locator.dart';
import '../../domain/entity/message/message_entity.dart';

class ChatScreen extends StatefulWidget {
  final Option option;
  const ChatScreen({
    super.key,
    required this.option,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final ChatScreenStore _chatScreenStore = getIt<ChatScreenStore>();
  final TextEditingController _controller = TextEditingController();


  @override
  void initState() {
    super.initState();
    initMessenger();
  }

  @override
  void dispose() {
    if (_chatScreenStore.isSessionClosed) {
      _chatScreenStore.dispose();
    }
    super.dispose();
  }

  void initMessenger() {
    if (_chatScreenStore.sessionEntity == null) {
      _chatScreenStore.dispose();
      if (_chatScreenStore.messages.length == 0) {
        Future.delayed(Duration(seconds: 1), () {
          final welcomeMessage = widget.option.assistant.greeting;
          _chatScreenStore.insertMessage(welcomeMessage, SenderType.ai, false, false);
        });
      }
      _chatScreenStore.initSignalRService(widget.option);
    }

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: widget.option.title,
        actions: [
          Observer(
              builder: (_) => _chatScreenStore.sessionEntity == null
                  ? SizedBox.shrink() : TextButton(
                  onPressed: (){
                    showEndChatAlert();
                  },
                  child: Text(
                    context.localizations.end_chat,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w800
                    ),)
              )
          )
        ],
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          behavior: HitTestBehavior.opaque,
          child: Column(
            children: [
              Expanded(
                child: Observer(
                  builder: (_) => ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.symmetric(vertical: 4),
                    itemCount: _chatScreenStore.messages.length,
                    itemBuilder: (context, index) {
                      final message = _chatScreenStore.messages[index];
                      return MessageBubble(message: message);
                    },
                  ),
                ),
              ),
              Observer(
                builder: (_) => _chatScreenStore.isSessionClosed
                    ? SizedBox.shrink()
                    : _buildInputField(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      _chatScreenStore.insertMessage(text, SenderType.customer, false, true);
      _controller.clear();
    }
  }

  Widget _buildInputField(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        child: Observer(
          builder: (_) => Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 55, // Minimum height
                      maxHeight: 150, // Maximum height
                    ),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null, // Allows it to expand up to maxHeight
                      textAlignVertical: TextAlignVertical.center,
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: context.localizations.message_input_hint,
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) => _sendMessage(),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color:_chatScreenStore.isThinking
                      ? Theme.of(context).colorScheme.surfaceContainer
                      : Theme.of(context).primaryColor,
                  shape: BoxShape.circle
                ),
                child: IconButton(
                  onPressed: _chatScreenStore.isThinking
                      ? null
                      : _sendMessage,
                  icon: Transform.flip(
                      flipX: AppLocalizations.of(context)!.localeName == 'ar' ? true : false,
                      child: SvgPicture.asset(Assets.lib.assets.svg.send, color:
                      _chatScreenStore.isThinking
                          ? Theme.of(context).colorScheme.outline
                          : Colors.white)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showEndChatAlert() {
    showDialog(context: this.context, builder: (ctx) => CustomAlert(
      title: context.localizations.end_chat,
      content: context.localizations.end_chat_desc,
        action1Text: context.localizations.confirm,
        action1Callback: () {
          _chatScreenStore.closeSession();
          Navigator.pop(ctx);
        },
        action2Text: context.localizations.cancel,
        action2Callback: () {
          Navigator.pop(ctx);
        }
    ));
  }

}