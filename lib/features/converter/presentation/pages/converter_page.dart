import 'package:flutter/material.dart';
import 'package:borno_setu/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/conversion_type.dart';
import '../providers/converter_provider.dart';
import '../widgets/conversion_toggle.dart';
import '../widgets/text_input_card.dart';
import '../widgets/text_output_card.dart';

class ConverterPage extends ConsumerStatefulWidget {
  const ConverterPage({super.key});

  @override
  ConsumerState<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends ConsumerState<ConverterPage> {
  final _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(converterNotifierProvider);
    final notifier = ref.read(converterNotifierProvider.notifier);

    // Sync controller when state changes externally (e.g., swap, load from history)
    if (_inputController.text != state.inputText) {
      _inputController.text = state.inputText;
    }

    final hintText = state.direction == ConversionType.bijoyToUnicode
        ? l10n.inputHintBijoy
        : l10n.inputHintUnicode;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: ConversionToggle(
                selected: state.direction,
                onChanged: (type) {
                  notifier.toggleDirection();
                  _inputController.clear();
                },
              ),
            ),
            const SizedBox(height: 16),
            TextInputCard(
              controller: _inputController,
              hintText: hintText,
              onChanged: (text) => notifier.setInput(text),
              onClear: () {
                _inputController.clear();
                notifier.clear();
              },
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.filled(
                  onPressed: () {
                    notifier.swapTexts();
                  },
                  icon: const Icon(Icons.swap_vert),
                  tooltip: l10n.swapButton,
                ),
                const SizedBox(width: 16),
                FilledButton.icon(
                  onPressed: state.inputText.isEmpty
                      ? null
                      : () => notifier.convert(),
                  icon: const Icon(Icons.translate),
                  label: Text(l10n.convertButton),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextOutputCard(
              text: state.outputText,
              onSaveToHistory: () async {
                await notifier.saveToHistory();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.savedToHistory)),
                  );
                }
              },
            ),
            if (state.error != null) ...[
              const SizedBox(height: 8),
              Text(
                state.error!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
