import 'package:collection/collection.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_punk/state/game/game_state.dart';
import 'package:plastic_punk/state/game/messages/message.dart';
import 'package:plastic_punk/utils/constants/colors.dart';
import 'package:plastic_punk/utils/constants/fonts.dart';
import 'package:plastic_punk/utils/constants/sizes.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';
import 'package:url_launcher/url_launcher.dart';

extension MessageUtils on Message {
  List<TextSpan> body(SizeLayout size) {
    // This pattern matches <link:link_id> text
    final urlPattern = RegExp(r'<link:(\d+)>', caseSensitive: false);
    Iterable<RegExpMatch> matches = urlPattern.allMatches(message);

    List<TextSpan> spanList = [];
    int lastMatchEnd = 0;

    for (var match in matches) {
      final String matchedText = message.substring(match.start, match.end);

      // Add non-URL text
      if (match.start > lastMatchEnd) {
        spanList.add(TextSpan(text: message.substring(lastMatchEnd, match.start)));
      }

      // Add URL text
      final linkId = match.group(1);
      final link = links.firstWhereOrNull((element) => element.id == linkId);

      if (link == null) {
        spanList.add(TextSpan(text: matchedText));
        continue;
      }

      spanList.add(TextSpan(
          text: link.text,
          style: AppFonts.messageLink(size).copyWith(color: AppColors.hudLink),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              final uri = Uri.tryParse(link.url);
              if (uri == null) return;

              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              }
            }));

      lastMatchEnd = match.end;
    }

    // Add any remaining non-URL text
    if (lastMatchEnd < message.length) {
      spanList.add(TextSpan(text: message.substring(lastMatchEnd, message.length)));
    }

    return spanList;
  }
}

class MessageOverlay extends ConsumerWidget {
  static const String overlayId = 'message';

  final FlameGame game;

  const MessageOverlay({required this.game, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(builder: (context, constraints) {
      final size = SizeLayoutBuilder.of(context);
      return SizeLayoutBuilder(
        small: (context, child) => _buildContent(context, size),
        medium: (context, child) => _buildContent(context, size),
        large: (context, child) => _buildContent(context, size),
      );
    });
  }

  Widget _buildContent(BuildContext context, SizeLayout size) {
    return Material(
      type: MaterialType.transparency,
      child: MessageContent(size: size, game: game),
    );
  }
}

class MessageContent extends ConsumerWidget {
  final SizeLayout size;
  final FlameGame game;

  const MessageContent({required this.size, required this.game, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final message = ref.read(gameStateProvider).message;
    if (message == null) return const SizedBox();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // onTap: () => _next(message, ref),
      child: Container(
        color: Colors.black.withOpacity(0.4),
        padding: const EdgeInsets.all(24),
        child: SafeArea(
          child: Center(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.hudBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              constraints: BoxConstraints.tight(AppSizes.message(size)),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(message.title, style: AppFonts.messageTitle(size).copyWith(color: AppColors.hudForeground)),
                  const SizedBox(height: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      child: RichText(
                        text: TextSpan(
                          style: AppFonts.messageBody(size).copyWith(color: AppColors.hudForeground),
                          children: message.body(size),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.buttonForeground,
                      foregroundColor: AppColors.buttonBackground,
                      textStyle: AppFonts.button(size),
                    ),
                    onPressed: () => _next(message, ref),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _next(Message message, WidgetRef ref) {
    ref.read(gameStateProvider.notifier).hideMessage();
    if (message.next != null) {
      ref.read(gameStateProvider.notifier).showMessage(message.next!);
    }
  }
}
