import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import 'app_focus_outline.dart';
import 'app_tokens.g.dart';

class FontLicenseDialog extends StatefulWidget {
  const FontLicenseDialog({super.key});

  @override
  State<FontLicenseDialog> createState() => _FontLicenseDialogState();
}

class _FontLicenseDialogState extends State<FontLicenseDialog> {
  Future<String>? _license;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _license ??= DefaultAssetBundle.of(
      context,
    ).loadString('assets/fonts/OFL.txt');
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return AlertDialog(
      scrollable: true,
      title: Text(strings.fontLicense),
      content: SizedBox(
        width: AppTokens.formMax,
        child: FutureBuilder<String>(
          future: _license,
          builder: (context, snapshot) => Text(
            snapshot.hasError
                ? strings.licenseError
                : snapshot.data ?? strings.licenseLoading,
          ),
        ),
      ),
      actions: [
        AppFocusOutline(
          child: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(strings.close),
          ),
        ),
      ],
    );
  }
}
