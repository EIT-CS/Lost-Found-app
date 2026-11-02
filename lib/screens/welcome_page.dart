import 'package:flutter/material.dart';
import '../widgets/app_colors.dart';
import '../widgets/lost_found_illustration.dart';
import '../widgets/primary_button.dart';
import 'login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(17, 20, 17, 58),
            child: Column(
              children: [
                const Spacer(flex: 3),
                const LostFoundIllustration(),
                const SizedBox(height: 3),
                const Text(
                  'Lost & Found',
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.7,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Алдсан зүйлээ олж, олсон зүйлээ\nэзэнд нь хүргэе',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
                const Spacer(flex: 4),
                PrimaryButton(
                  label: 'Эхлэх',
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const LoginPage(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
