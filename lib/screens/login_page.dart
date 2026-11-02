import 'package:flutter/material.dart';
import '../widgets/app_colors.dart';
import '../widgets/primary_button.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  InputDecoration _fieldDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) =>
      InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.muted, fontSize: 12),
        prefixIcon: Icon(icon, size: 17, color: const Color(0xFF9293A1)),
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 13),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFEDEDF2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.purple),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(19, 20, 19, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Нэвтрэх',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 28),
                _SocialButton(
                  icon: const Text(
                    'G',
                    style: TextStyle(
                      color: Color(0xFF4285F4),
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  label: 'Google-ээр нэвтрэх',
                  onPressed: () => _showMessage('Google нэвтрэлт удахгүй нэмэгдэнэ.'),
                ),
                const SizedBox(height: 11),
                _SocialButton(
                  icon: const Icon(Icons.apple, size: 21, color: AppColors.ink),
                  label: 'Apple-ээр нэвтрэх',
                  onPressed: () => _showMessage('Apple нэвтрэлт удахгүй нэмэгдэнэ.'),
                ),
                const SizedBox(height: 27),
                const _OrDivider(),
                const SizedBox(height: 25),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: _fieldDecoration(
                    hint: 'И-мэйл',
                    icon: Icons.mail_outline,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: _hidePassword,
                  textInputAction: TextInputAction.done,
                  decoration: _fieldDecoration(
                    hint: 'Нууц үг',
                    icon: Icons.lock_outline,
                    suffix: IconButton(
                      onPressed: () => setState(() => _hidePassword = !_hidePassword),
                      icon: Icon(
                        _hidePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        size: 17,
                        color: const Color(0xFF9293A1),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  label: 'Нэвтрэх',
                  onPressed: () {
                    if (_emailController.text.trim().isEmpty ||
                        _passwordController.text.isEmpty) {
                      _showMessage('И-мэйл болон нууц үгээ оруулна уу.');
                      return;
                    }
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute<void>(
                        builder: (_) => const HomePage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 19),
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text(
                      'Бүртгэлгүй юу? ',
                      style: TextStyle(color: AppColors.muted, fontSize: 11),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const RegisterPage(),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Бүртгүүлэх',
                        style: TextStyle(color: AppColors.purple, fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final Widget icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 47,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: icon,
          label: Text(
            label,
            style: const TextStyle(
              color: AppColors.ink,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            side: BorderSide.none,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
          ),
        ),
      );
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) => Row(
        children: [
          const Expanded(child: Divider(color: Color(0xFFEDEDF2))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: Text(
              'эсвэл',
              style: TextStyle(color: AppColors.muted.withValues(alpha: 0.8), fontSize: 10),
            ),
          ),
          const Expanded(child: Divider(color: Color(0xFFEDEDF2))),
        ],
      );
}
