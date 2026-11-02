import 'package:flutter/material.dart';
import '../widgets/app_colors.dart';
import 'messages_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.savedCount, required this.itemCount});
  final int savedCount;
  final int itemCount;

  @override
  Widget build(BuildContext context) => Column(children: [
        Padding(padding: const EdgeInsets.fromLTRB(18, 14, 6, 12), child: Row(children: [const Expanded(child: Text('Профайл', textAlign: TextAlign.center, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700))), IconButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const NotificationsPage())), icon: const Icon(Icons.settings_outlined))])),
        const CircleAvatar(radius: 37, backgroundColor: Color(0xFFEDEBFF), child: Icon(Icons.person, size: 40, color: AppColors.purple)),
        const SizedBox(height: 10),
        const Text('Хэрэглэгч', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        const Text('И-мэйл хаяг холбоогүй', style: TextStyle(fontSize: 11, color: AppColors.muted)),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _Stat(value: '$itemCount', label: 'Зар'),
          _Stat(value: '$savedCount', label: 'Хадгалсан'),
          const _Stat(value: '0', label: 'Чат'),
        ]),
        const SizedBox(height: 22),
        const Divider(height: 1),
        _ProfileRow(icon: Icons.person_outline, title: 'Миний мэдээлэл', onTap: () {}),
        _ProfileRow(icon: Icons.favorite_border, title: 'Хадгалсан зар', onTap: () {}),
        _ProfileRow(icon: Icons.chat_bubble_outline, title: 'Мессеж', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MessagesPage()))),
        _ProfileRow(icon: Icons.notifications_none, title: 'Мэдэгдэл', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const NotificationsPage()))),
        _ProfileRow(icon: Icons.logout, title: 'Гарах', onTap: () => Navigator.of(context).popUntil((route) => route.isFirst)),
      ]);
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});
  final String value, label;
  @override
  Widget build(BuildContext context) => Column(children: [Text(value, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)), const SizedBox(height: 4), Text(label, style: const TextStyle(color: AppColors.muted, fontSize: 10))]);
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow({required this.icon, required this.title, required this.onTap});
  final IconData icon; final String title; final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => ListTile(onTap: onTap, leading: Icon(icon, size: 19, color: AppColors.muted), title: Text(title, style: const TextStyle(fontSize: 12)), trailing: const Icon(Icons.chevron_right, size: 18, color: AppColors.muted));
}
