import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:plastic_punk/screens/game/overlay/widgets/loading_widget.dart';
import 'package:plastic_punk/screens/game/overlay/widgets/login_dialog.dart';
import 'package:plastic_punk/services/auth/auth_service.dart';
import 'package:plastic_punk/services/firebase/firestore_service.dart';
import 'package:plastic_punk/state/game/data/game_state_saved_data.dart';
import 'package:plastic_punk/state/game/levels/level.dart';
import 'package:plastic_punk/state/game/levels/levels.dart';
import 'package:plastic_punk/utils/constants/colors.dart';
import 'package:plastic_punk/utils/constants/fonts.dart';
import 'package:plastic_punk/utils/constants/sizes.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';

class SavesDialog extends ConsumerStatefulWidget {
  final SizeLayout size;
  final bool showEmpty;
  final VoidCallback? onBack;
  final void Function(String slot, Level? level)? onSelect;

  const SavesDialog({
    required this.size,
    this.onBack,
    this.onSelect,
    this.showEmpty = false,
    super.key,
  });

  @override
  ConsumerState<SavesDialog> createState() => _SavesDialogState();
}

class _SavesDialogState extends ConsumerState<SavesDialog> {
  final List<GameStateSavedData> _saves = [];
  bool _loading = false;
  final _dateFormat = DateFormat('d MMMM yyyy hh:mm a');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _tryLoadSaves());
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = ref.read(authServiceProvider).isLoggedIn();
    if (!isLoggedIn) return LoginDialog(size: widget.size, onBack: _back, onLogin: _tryLoadSaves);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.hudBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      constraints: BoxConstraints.tight(AppSizes.message(widget.size)),
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Saves', style: AppFonts.messageTitle(widget.size).copyWith(color: AppColors.hudForeground)),
                const SizedBox(height: 8),
                Expanded(
                  child: _loading ? const LoadingWidget() : _buildContent(),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () => _back(),
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

  Widget _buildContent() {
    List<GameStateSavedDataSlots> slots = GameStateSavedDataSlots.values;
    if (!widget.showEmpty) {
      slots = slots.where((slot) => _saves.any((save) => save.slot == slot.name)).toList();
    }

    if (slots.isEmpty) {
      return Center(
        child: Text(
          'No saves found',
          style: AppFonts.messageBody(widget.size).copyWith(color: AppColors.hudForeground),
        ),
      );
    }

    return ListView.separated(
      itemCount: slots.length,
      itemBuilder: (context, index) {
        final slot = slots[index];
        final save = _saves.firstWhereOrNull((save) => save.slot == slot.name);
        final date = save?.createdAt;
        final dateText = date != null ? _dateFormat.format(date) : '';

        return ListTile(
          title: Text(
            save != null ? (save.name ?? save.slot) : slot.name,
            style: AppFonts.messageBody(widget.size).copyWith(color: AppColors.hudForeground),
          ),
          subtitle: Text(
            save == null ? 'Empty' : 'Level: ${save.level}, Date: $dateText',
            style: AppFonts.messageBody(widget.size).copyWith(color: AppColors.hudForeground.withOpacity(0.5)),
          ),
          onTap: () => _select(slot.name),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 8),
    );
  }

  void _back() {
    widget.onBack?.call();
  }

  void _select(String slot) {
    final saveData = _saves.firstWhereOrNull((save) => save.slot == slot);
    final level = Levels.levels.firstWhereOrNull((e) => e.level == saveData?.level);

    widget.onSelect?.call(slot, level);
  }

  void _tryLoadSaves() async {
    setState(() => _loading = true);

    final saves = await ref.read(firestoreServiceProvider).loadAllGames();

    setState(() {
      _saves.clear();
      _saves.addAll(saves);
      _loading = false;
    });
  }
}
