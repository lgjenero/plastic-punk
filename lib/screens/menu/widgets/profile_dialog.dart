import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_punk/screens/game/overlay/widgets/loading_widget.dart';
import 'package:plastic_punk/screens/game/overlay/widgets/login_dialog.dart';
import 'package:plastic_punk/screens/menu/widgets/flag_button.dart';
import 'package:plastic_punk/screens/menu/widgets/flag_selector_dialog.dart';
import 'package:plastic_punk/services/auth/auth_service.dart';
import 'package:plastic_punk/services/user/user_service.dart';
import 'package:plastic_punk/state/game/logic/achievement_tree.dart';
import 'package:plastic_punk/utils/constants/colors.dart';
import 'package:plastic_punk/utils/constants/fonts.dart';
import 'package:plastic_punk/utils/constants/sizes.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';

class ProfileDialog extends StatelessWidget {
  final SizeLayout size;
  final VoidCallback? onBack;

  const ProfileDialog({required this.size, this.onBack, super.key});

  static void show(BuildContext context) {
    Widget buildProfileContent(SizeLayout size) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          color: Colors.transparent,
          child: ProfileDialog(
            size: size,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
    }

    showDialog(
      context: context,
      builder: (context) => SizeLayoutBuilder(
        small: (_, __) => buildProfileContent(SizeLayout.small),
        medium: (_, __) => buildProfileContent(SizeLayout.medium),
        large: (_, __) => buildProfileContent(SizeLayout.large),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                'Profile',
                style: AppFonts.messageTitle(size).copyWith(color: AppColors.hudForeground),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Flag:',
                    style: AppFonts.messageTitle(size).copyWith(color: AppColors.hudForeground),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(width: 8),
                  Consumer(builder: (context, ref, __) {
                    final flagCode = ref.watch(userServiceProvider.select((e) => e.userData.flag));
                    return FlagButton(flagCode: flagCode, size: size, onPressed: () => _changeFlag(context, ref));
                  }),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                'Achievements',
                style: AppFonts.messageTitle(size).copyWith(color: AppColors.hudForeground),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 8),
              SizedBox(height: AppSizes.messageBadge(size).height, child: _AchievementsList(size: size)),
              const SizedBox(height: 32),
              _ProfileLogin(size: size),
            ],
          ),
          Positioned(
            right: 0,
            child: IconButton(
              onPressed: onBack,
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

  void _changeFlag(BuildContext context, WidgetRef ref) {
    FlagSelectorDialog.show(context,
        onBack: () => Navigator.pop(context),
        onFlagSelected: (flag) {
          ref.read(userServiceProvider.notifier).updateFlag(flag);
          Navigator.pop(context);
        });
  }
}

class _AchievementsList extends ConsumerWidget {
  final SizeLayout size;

  const _AchievementsList({required this.size});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievementIds = ref.watch(userServiceProvider.select((e) => e.userData.achievements));
    final achievements = AchievementTree.nodes.where((e) => achievementIds.contains(e.id));

    if (achievements.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            'No achievements yet. Get playing!',
            style: AppFonts.messageBody(size).copyWith(color: AppColors.hudForeground),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final achievement = achievements.elementAt(index);
        return Image.asset(
          achievement.imagePath,
          width: AppSizes.messageBadge(size).width,
          height: AppSizes.messageBadge(size).height,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 8),
    );
  }
}

class _ProfileLogin extends ConsumerWidget {
  final SizeLayout size;

  const _ProfileLogin({required this.size});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(loggedInUserProvider);

    return isLoggedIn.when(
      data: (user) {
        if (user == null) {
          return FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.buttonForeground,
              foregroundColor: AppColors.buttonBackground,
              textStyle: AppFonts.button(size),
            ),
            onPressed: () => _tryLogin(context),
            child: const Text('Login'),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Logged in as ${user.email}',
              style: AppFonts.messageBody(size).copyWith(color: AppColors.hudForeground),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => _tryLogout(ref),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.buttonForeground,
                foregroundColor: AppColors.buttonBackground,
                textStyle: AppFonts.button(size),
              ),
              child: const Text('Log Out'),
            ),
          ],
        );
      },
      error: (error, stack) {
        return Text(
          'Error: $error',
          style: AppFonts.messageBody(size).copyWith(color: AppColors.hudForeground),
          textAlign: TextAlign.center,
        );
      },
      loading: () => const LoadingWidget(),
    );
  }

  void _tryLogin(BuildContext context) {
    LoginDialog.show(
      context,
      onBack: () => Navigator.pop(context),
      onLogin: () => Navigator.pop(context),
    );
  }

  void _tryLogout(WidgetRef ref) {
    ref.read(userServiceProvider.notifier).logout();
  }
}
