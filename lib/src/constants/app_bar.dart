import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:babylai/gen/assets.gen.dart';

import '../../l10n/gen/app_localizations.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Widget? leading;
  final Color? backgroundColor;

  const PrimaryAppBar({
    super.key,
    this.title,
    this.actions,
    this.centerTitle = true,
    this.leading,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null
          ? Text(
              title!,
              style: Theme.of(context).textTheme.titleSmall,
            )
          : null,
      centerTitle: centerTitle,
      actions: actions,
      leading: leading,
      leadingWidth: 80,
      backgroundColor: backgroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class UpdatedPrimaryAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Widget? leading;
  final Color? backgroundColor;

  const UpdatedPrimaryAppBar({
    super.key,
    required this.title,
    this.actions,
    this.centerTitle = true,
    this.leading,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final double? topOffset = -2;
    final bool isAr = AppLocalizations.of(context)!.localeName == 'ar';
    final double? leadingOffset = isAr ? 10 : -10;

    return AppBar(
      actions: actions
          ?.map((e) => Transform.translate(
                offset: Offset(isAr ? 16 : 0, topOffset ?? 0),
                child: e,
              ))
          .toList(),
      title: Transform.translate(
        offset: Offset(leadingOffset ?? 0, topOffset ?? 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              Assets.lib.assets.svg.fullLogo,
              height: 36,
            ),
          ],
        ),
      ),
      leading: Transform.translate(
        offset: Offset(0, topOffset ?? 0),
        child: leading,
      ),
      backgroundColor: backgroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
