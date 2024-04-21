import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plastic_punk/screens/menu/widgets/flag_button.dart';
import 'package:plastic_punk/utils/constants/colors.dart';
import 'package:plastic_punk/utils/constants/fonts.dart';
import 'package:plastic_punk/utils/constants/sizes.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';

class FlagSelectorDialog extends StatefulWidget {
  final VoidCallback? onBack;
  final void Function(String)? onFlagSelected;

  const FlagSelectorDialog({
    this.onBack,
    this.onFlagSelected,
    super.key,
  });

  @override
  State<FlagSelectorDialog> createState() => _FlagSelectorDialogState();

  static void show(BuildContext context, {VoidCallback? onBack, void Function(String)? onFlagSelected}) {
    Widget buildFlagSelectorContent(SizeLayout size) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          color: Colors.transparent,
          child: FlagSelectorDialog(
            onBack: onBack,
            onFlagSelected: onFlagSelected,
          ),
        ),
      );
    }

    showDialog(
      context: context,
      builder: (context) => SizeLayoutBuilder(
        small: (_, __) => buildFlagSelectorContent(SizeLayout.small),
        medium: (_, __) => buildFlagSelectorContent(SizeLayout.medium),
        large: (_, __) => buildFlagSelectorContent(SizeLayout.large),
      ),
    );
  }
}

class _FlagSelectorDialogState extends State<FlagSelectorDialog> {
  final List<String> _flags = [];

  @override
  void initState() {
    super.initState();
    _loadFlags();
  }

  void _loadFlags() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    if (!mounted) return;

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('flags/'))
        .where((String key) => key.endsWith('.png'))
        .toList();

    final flags = imagePaths.map((path) {
      final parts = path.split('/');
      return parts.last.split('.').first;
    });

    setState(() {
      _flags.addAll(flags);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizeLayoutBuilder(
      small: (context, _) => _buildContent(SizeLayout.small),
      medium: (context, _) => _buildContent(SizeLayout.medium),
      large: (context, _) => _buildContent(SizeLayout.large),
    );
  }

  Widget _buildContent(SizeLayout size) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.hudBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      constraints: BoxConstraints.tightFor(width: AppSizes.message(size).width),
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select your flag',
                style: AppFonts.messageTitle(size).copyWith(color: AppColors.hudForeground),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: _flags
                        .map((flag) => FlagButton(
                              flagCode: flag,
                              size: size,
                              onPressed: () => widget.onFlagSelected?.call(flag),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            child: IconButton(
              onPressed: widget.onBack,
              icon: const Icon(
                Icons.cancel,
                color: AppColors.hudForeground,
                size: 44,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
