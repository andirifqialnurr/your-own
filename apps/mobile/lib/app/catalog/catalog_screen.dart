import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../shared_ui/controls/app_button.dart';
import '../../shared_ui/controls/app_text_field.dart';
import '../../shared_ui/feedback/app_status_panel.dart';
import '../../shared_ui/icons/app_icon.dart';
import '../../shared_ui/layout/bounded_page.dart';
import '../../shared_ui/overlays/app_dialog.dart';
import '../../shared_ui/surfaces/app_card.dart';
import '../../shared_ui/theme/app_tokens.g.dart';

enum CatalogSection { actions, fields, feedback, icons }

/// Mounted only by the debug route or owned synthetic tests. No service/store.
class CatalogScreen extends StatefulWidget {
  const CatalogScreen({
    required this.onBack,
    this.initialSection = CatalogSection.actions,
    super.key,
  });
  final VoidCallback onBack;
  final CatalogSection initialSection;

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  late CatalogSection _section = widget.initialSection;
  final _draft = TextEditingController();
  final _readonly = TextEditingController();
  final _disabled = TextEditingController();
  final _invalid = TextEditingController();
  final _fieldFocus = FocusNode();
  final _buttonFocus = FocusNode();
  final _hover = WidgetStatesController({WidgetState.hovered});
  final _pressed = WidgetStatesController({WidgetState.pressed});
  bool _pending = false;
  bool _confirming = false;
  bool _initialized = false;
  int _attempts = 0;
  String? _error;
  bool? _confirmed;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final sample = AppLocalizations.of(context).catalogSample;
      for (final controller in [_readonly, _disabled, _invalid]) {
        controller.text = sample;
      }
      _initialized = true;
    }
  }

  @override
  void dispose() {
    for (final controller in [_draft, _readonly, _disabled, _invalid]) {
      controller.dispose();
    }
    _fieldFocus.dispose();
    _buttonFocus.dispose();
    _hover.dispose();
    _pressed.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    // Synchronous guard also blocks a second activation before the next frame.
    if (_pending) return;
    final strings = AppLocalizations.of(context);
    if (_draft.text.trim().isEmpty) {
      setState(() => _error = strings.catalogRequired);
      _fieldFocus.requestFocus();
      return;
    }
    setState(() {
      _pending = true;
      _attempts++;
      _error = null;
    });
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    setState(() {
      _pending = false;
      _error = AppLocalizations.of(context).catalogFailure;
    });
  }

  Future<void> _confirm() async {
    if (_confirming) return;
    _confirming = true;
    try {
      final strings = AppLocalizations.of(context);
      final result = await showAppConfirmation(
        context: context,
        title: strings.catalogDialogTitle,
        description: strings.catalogDialogBody,
        cancelLabel: strings.catalogCancel,
        confirmLabel: strings.catalogConfirm,
      );
      if (mounted) setState(() => _confirmed = result);
    } finally {
      _confirming = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context);
    final names = [
      s.catalogActions,
      s.catalogFields,
      s.catalogFeedback,
      s.catalogIcons,
    ];
    return Scaffold(
      body: SafeArea(
        child: BoundedPage(
          storageKey: 'catalog-scroll',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppButton(
                label: s.back,
                symbol: AppSymbol.back,
                kind: AppButtonKind.ghost,
                onPressed: widget.onBack,
              ),
              const SizedBox(height: AppTokens.space16),
              Semantics(
                header: true,
                child: Text(
                  s.catalogTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              const SizedBox(height: AppTokens.space12),
              Text(s.catalogNotice),
              const SizedBox(height: AppTokens.space16),
              Wrap(
                spacing: AppTokens.space8,
                runSpacing: AppTokens.space8,
                children: [
                  for (final section in CatalogSection.values)
                    AppButton(
                      key: ValueKey('catalog-${section.name}'),
                      label: names[section.index],
                      selected: _section == section,
                      onPressed: () => setState(() => _section = section),
                    ),
                ],
              ),
              const SizedBox(height: AppTokens.space24),
              ...switch (_section) {
                CatalogSection.actions => _actions(s),
                CatalogSection.fields => _fields(s),
                CatalogSection.feedback => _feedback(s),
                CatalogSection.icons => [
                  Wrap(
                    spacing: AppTokens.space12,
                    runSpacing: AppTokens.space12,
                    children: [
                      for (final symbol in AppSymbol.values)
                        SizedBox(
                          width: 168,
                          child: AppCard(
                            compact: true,
                            child: Column(
                              children: [
                                AppIcon(symbol),
                                const SizedBox(height: AppTokens.space8),
                                Text(symbol.name, textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              },
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _actions(AppLocalizations s) => [
    Wrap(
      spacing: AppTokens.space12,
      runSpacing: AppTokens.space12,
      children: [
        AppButton(
          label: s.catalogPrimary,
          kind: AppButtonKind.primary,
          symbol: AppSymbol.add,
          onPressed: () {},
        ),
        AppButton(label: s.catalogSecondary, onPressed: () {}),
        AppButton(
          label: s.catalogGhost,
          kind: AppButtonKind.ghost,
          onPressed: () {},
        ),
        AppButton(label: s.catalogDisabled, onPressed: null),
        AppButton(
          label: s.catalogSave,
          busy: true,
          busyLabel: s.catalogBusy,
          onPressed: () {},
        ),
        AppButton(label: s.catalogSelected, selected: true, onPressed: () {}),
        AppButton(
          label: s.catalogHover,
          statesController: _hover,
          onPressed: () {},
        ),
        AppButton(
          label: s.catalogPressed,
          statesController: _pressed,
          onPressed: () {},
        ),
        AppButton(
          key: const ValueKey('catalog-focus'),
          label: s.catalogFocus,
          focusNode: _buttonFocus,
          onPressed: () {},
        ),
        AppIconButton(
          label: s.close,
          symbol: AppSymbol.close,
          onPressed: () {},
        ),
      ],
    ),
    const SizedBox(height: AppTokens.space24),
    AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            header: true,
            child: Text(
              s.catalogCardTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: AppTokens.space8),
          Text(s.catalogCardBody),
        ],
      ),
    ),
    const SizedBox(height: AppTokens.space24),
    AppButton(
      key: const ValueKey('catalog-dialog'),
      label: s.catalogDialog,
      onPressed: _confirm,
    ),
    if (_confirmed != null)
      Semantics(
        liveRegion: true,
        child: Text(_confirmed! ? s.catalogConfirmed : s.catalogCancelled),
      ),
  ];

  List<Widget> _fields(AppLocalizations s) => [
    AppTextField(
      key: const ValueKey('catalog-draft'),
      label: s.catalogNote,
      helper: s.catalogHelper,
      error: _error,
      controller: _draft,
      focusNode: _fieldFocus,
      maxLines: 3,
    ),
    const SizedBox(height: AppTokens.space16),
    AppButton(
      key: const ValueKey('catalog-save'),
      label: s.catalogSave,
      symbol: AppSymbol.save,
      kind: AppButtonKind.primary,
      busy: _pending,
      busyLabel: s.catalogBusy,
      onPressed: _submit,
    ),
    const SizedBox(height: AppTokens.space24),
    Text(s.catalogAttempts(_attempts)),
    const SizedBox(height: AppTokens.space16),
    AppTextField(
      label: s.catalogReadonly,
      helper: s.catalogReadonlyHint,
      controller: _readonly,
      readOnly: true,
    ),
    const SizedBox(height: AppTokens.space24),
    AppTextField(
      label: s.catalogDisabledField,
      controller: _disabled,
      enabled: false,
    ),
    const SizedBox(height: AppTokens.space24),
    AppTextField(
      label: s.catalogInvalidField,
      controller: _invalid,
      error: s.catalogRequired,
    ),
  ];

  List<Widget> _feedback(AppLocalizations s) => [
    for (final (kind, title, body) in [
      (AppStatusKind.loading, s.catalogLoading, s.catalogLoadingBody),
      (AppStatusKind.empty, s.catalogEmpty, s.catalogEmptyBody),
      (AppStatusKind.error, s.catalogError, s.catalogFailure),
      (
        AppStatusKind.unavailable,
        s.catalogUnavailable,
        s.catalogUnavailableBody,
      ),
    ]) ...[
      AppStatusPanel(
        kind: kind,
        title: title,
        description: body,
        actionLabel: kind == AppStatusKind.error ? s.retry : null,
        onAction: kind == AppStatusKind.error ? () {} : null,
      ),
      const SizedBox(height: AppTokens.space16),
    ],
  ];
}
