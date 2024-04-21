import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plastic_punk/screens/game/overlay/widgets/loading_widget.dart';
import 'package:plastic_punk/services/user/user_service.dart';
import 'package:plastic_punk/utils/constants/colors.dart';
import 'package:plastic_punk/utils/constants/fonts.dart';
import 'package:plastic_punk/utils/constants/sizes.dart';
import 'package:plastic_punk/utils/constants/strings.dart';
import 'package:plastic_punk/utils/widgets/size_layout.dart';

class LoginDialog extends ConsumerStatefulWidget {
  final SizeLayout size;
  final VoidCallback? onLogin;
  final VoidCallback? onBack;

  const LoginDialog({required this.size, this.onLogin, this.onBack, super.key});

  @override
  ConsumerState<LoginDialog> createState() => _LoginDialogState();

  static void show(BuildContext context, {VoidCallback? onLogin, VoidCallback? onBack}) {
    Widget buildLoginContent(SizeLayout size) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          color: Colors.transparent,
          child: LoginDialog(
            size: size,
            onLogin: onLogin,
            onBack: onBack,
          ),
        ),
      );
    }

    showDialog(
      context: context,
      builder: (context) => SizeLayoutBuilder(
        small: (_, __) => buildLoginContent(SizeLayout.small),
        medium: (_, __) => buildLoginContent(SizeLayout.medium),
        large: (_, __) => buildLoginContent(SizeLayout.large),
      ),
    );
  }
}

class _LoginDialogState extends ConsumerState<LoginDialog> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  bool _showPassword = false;
  bool _loading = false;
  String _error = '';
  bool _signIn = false;

  @override
  void initState() {
    super.initState();
    _emailFocus.requestFocus();
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
      constraints: BoxConstraints.tightFor(width: AppSizes.message(widget.size).width),
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_signIn ? 'Sign up' : 'Login',
                  style: AppFonts.messageTitle(widget.size).copyWith(color: AppColors.hudForeground)),
              const SizedBox(height: 32),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle:
                      AppFonts.messageBody(widget.size).copyWith(color: AppColors.hudForeground.withOpacity(0.5)),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.hudForeground),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.hudForeground),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
                style: AppFonts.messageBody(widget.size).copyWith(color: AppColors.hudForeground),
                controller: _emailController,
                onFieldSubmitted: (value) => _passwordFocus.requestFocus(),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle:
                      AppFonts.messageBody(widget.size).copyWith(color: AppColors.hudForeground.withOpacity(0.5)),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.hudForeground),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.hudForeground),
                  ),
                  suffix: IconButton(
                    onPressed: () => setState(() => _showPassword = !_showPassword),
                    icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility, color: AppColors.hudForeground),
                  ),
                ),
                obscureText: !_showPassword,
                style: AppFonts.messageBody(widget.size).copyWith(color: AppColors.hudForeground),
                controller: _passwordController,
                onSubmitted: (value) => _tryLogin,
              ),
              if (_error.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  _error,
                  style: AppFonts.messageBody(widget.size).copyWith(color: AppColors.hudForeground.withOpacity(0.7)),
                ),
              ],
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  text: _signIn ? 'Already have an account?' : 'Don\'t have an account? ',
                  style: AppFonts.messageBody(widget.size).copyWith(color: AppColors.hudForeground),
                  children: [
                    TextSpan(
                      text: _signIn ? 'Log in' : 'Sign up',
                      style: AppFonts.messageLink(widget.size).copyWith(color: AppColors.hudLink),
                      recognizer: TapGestureRecognizer()..onTap = () => setState(() => _signIn = !_signIn),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.buttonForeground,
                  foregroundColor: AppColors.buttonBackground,
                  textStyle: AppFonts.button(widget.size),
                ),
                onPressed: _tryLogin,
                child: Text(_signIn ? 'Sign up' : 'Login'),
              ),
            ],
          ),
          Positioned.fill(
              child: Visibility(
            visible: _loading,
            child: Container(color: Colors.black.withOpacity(0.4), child: const Center(child: LoadingWidget())),
          )),
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

  void _tryLogin() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) return;

    setState(() => _loading = true);

    final errorMessage = _signIn
        ? await ref.read(userServiceProvider.notifier).signUp(email, password)
        : await ref.read(userServiceProvider.notifier).login(email, password);

    if (errorMessage != null) {
      setState(() {
        _loading = false;
        _error = errorMessage;
      });
      return;
    }

    setState(() {
      _loading = false;
      _error = '';
    });

    widget.onLogin?.call();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Enter an email address';

    RegExp regex = RegExp(AppStrings.emailValidationPattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }
}
