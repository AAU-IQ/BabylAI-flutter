import 'package:babylai/src/core/widgets/rounded_button.dart';
import 'package:babylai/src/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:babylai/src/domain/entity/help_screen_entity.dart';

class HelpOptionCard extends StatelessWidget {
  final Option option;
  final VoidCallback onTap;

  const HelpOptionCard({
    Key? key,
    required this.option,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 0.2,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ExpansionTile(
        shape: Border(),
        title: Text(
          option.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              option.paragraphs.join("\n"),
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Theme.of(context).hintColor,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: RoundedButtonWidget(
                buttonText: context.localizations.chat_button,
                buttonTextSize: 13,
                onPressed: onTap,
              )
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}