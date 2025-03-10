import 'package:babylai/src/core/widgets/help_option_card.dart';
import 'package:babylai/src/presentation/help_screen/start_screen.dart';
import 'package:babylai/src/presentation/help_screen/store/help_screen_store.dart';
import 'package:babylai/src/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../constants/app_bar.dart';
import '../../core/widgets/loading_widget.dart';
import '../../di/service_locator.dart';
import '../../utils/primary_alert.dart';
import '../chat_screen/chat_screen.dart';
import '../chat_screen/store/chat_screen_store.dart';
import 'package:babylai/src/domain/entity/help_screen_entity.dart';

class HelpScreen extends StatefulWidget {
  final VoidCallback onBack;

  const HelpScreen({super.key, required this.onBack});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final HelpScreenStore _helpScreenStore = getIt<HelpScreenStore>();
  final ChatScreenStore _chatScreenStore = getIt<ChatScreenStore>();

  @override
  void initState() {
    super.initState();
    _helpScreenStore.getHelpScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PrimaryAppBar(
          title: context.localizations.title,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              widget.onBack();
            },
          ),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 18),
            child: Observer(
              builder: (context) {
                return _helpScreenStore.isLoading
                    ? Loading()
                    : _helpScreenStore.success
                        ? _buildListContent()
                        : _errorState();
              },
            )),
        floatingActionButton: Observer(
            builder: (_) => _chatScreenStore.sessionEntity != null
                ? FloatingActionButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: const CircleBorder(),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            option: _chatScreenStore.option,
                            onBack: widget.onBack,
                          ),
                        ),
                      );
                    },
                    tooltip: 'Chat',
                    child: const Icon(Icons.chat_bubble, color: Colors.white),
                  )
                : SizedBox.shrink()));
  }

  Widget _buildListContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Text(_helpScreenStore.helpScreen?.title ?? '',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor)),
              SizedBox(
                height: 8,
              ),
              Text(
                _helpScreenStore.helpScreen?.description ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: Theme.of(context).hintColor),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Expanded(child: _buildList()),
        SizedBox(
          height: 16,
        ),
        SafeArea(
          child: Text(
            'Powered by BabylAI',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(fontSize: 9, color: Theme.of(context).hintColor),
          ),
        )
      ],
    );
  }

  Widget _errorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            SizedBox(height: 16),
            Text(
              context.localizations.error_title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              context.localizations.error_message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                _helpScreenStore.getHelpScreen();
              },
              icon: Icon(Icons.refresh, color: Colors.white,),
              label: Text(context.localizations.try_again),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView.separated(
      itemCount: _helpScreenStore.helpScreen?.options.length ?? 0,
      separatorBuilder: (context, index) => SizedBox(
        height: 0,
      ),
      itemBuilder: (context, index) {
        final option = _helpScreenStore.helpScreen?.options[index];
        if (option != null) {
          return HelpOptionCard(
              option: option,
              onTap: () {
                goChat(option);
              });
        } else {
          return Text('Error loading content');
        }
      },
    );
  }

  void goChat(Option option) {
    if (_chatScreenStore.sessionEntity != null) {
      if (_chatScreenStore.sessionEntity!.optionId == option.id) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              option: _chatScreenStore.option,
              onBack: widget.onBack,
            ),
          ),
        );
      } else {
        showDialog(
            context: this.context,
            builder: (ctx) => CustomAlert(
                title: context.localizations.active_chat,
                content: context.localizations.active_chat_desc,
                action1Text: context.localizations.close,
                action1Callback: () {
                  _chatScreenStore.closeSession();
                  Navigator.pop(ctx);
                },
                action2Text: context.localizations.cancel,
                action2Callback: () {
                  Navigator.pop(ctx);
                }));
      }
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatScreen(
                    option: option,
                    onBack: widget.onBack,
                  )));
    }
  }
}
