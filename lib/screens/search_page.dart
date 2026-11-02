import 'dart:io';
import 'package:flutter/material.dart';
import '../models/lost_found_item.dart';
import '../widgets/app_colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.items, required this.onOpenItem});
  final List<LostFoundItem> items;
  final ValueChanged<LostFoundItem> onOpenItem;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  String _query = '';
  int _filter = 0;
  String _category = 'Бүх ангилал';

  @override
  void dispose() { _searchController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final items = widget.items.where((item) {
      final matchesText = item.title.toLowerCase().contains(_query.toLowerCase()) || item.location.toLowerCase().contains(_query.toLowerCase());
      final matchesType = _filter == 0 || (_filter == 1 && item.isLost) || (_filter == 2 && !item.isLost);
      final matchesCategory = _category == 'Бүх ангилал' || item.category == _category;
      return matchesText && matchesType && matchesCategory;
    }).toList();
    return Column(children: [
      const Padding(padding: EdgeInsets.fromLTRB(18, 18, 18, 15), child: Text('Хайлт', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700))),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 14), child: TextField(
        controller: _searchController,
        onChanged: (value) => setState(() => _query = value),
        decoration: InputDecoration(hintText: 'Хайх зүйл...', prefixIcon: const Icon(Icons.search, size: 19), filled: true, fillColor: Colors.white, contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(11), borderSide: const BorderSide(color: Color(0xFFEDEDF2))), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(11), borderSide: const BorderSide(color: Color(0xFFEDEDF2)))),
      )),
      const SizedBox(height: 12),
      SingleChildScrollView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 14), child: Row(children: ['Бүгд', 'Алдсан', 'Олсон'].asMap().entries.map((entry) => Padding(padding: const EdgeInsets.only(right: 7), child: ChoiceChip(label: Text(entry.value), selected: _filter == entry.key, showCheckmark: false, onSelected: (_) => setState(() => _filter = entry.key), selectedColor: AppColors.purple, labelStyle: TextStyle(color: _filter == entry.key ? Colors.white : AppColors.ink, fontSize: 10), side: BorderSide.none))).toList())),
      Padding(padding: const EdgeInsets.fromLTRB(14, 5, 14, 12), child: DropdownButtonFormField<String>(initialValue: _category, decoration: const InputDecoration(labelText: 'Ангилал', border: OutlineInputBorder()), items: const ['Бүх ангилал', 'Бусад', 'Цахилгаан бараа', 'Түлхүүр', 'Цүнх', 'Бичиг баримт'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(), onChanged: (v) { if (v != null) setState(() => _category = v); })),
      Expanded(child: items.isEmpty ? const Center(child: Text('Илэрц олдсонгүй', style: TextStyle(color: AppColors.muted))) : ListView(children: items.map((item) => ListTile(onTap: () => widget.onOpenItem(item), leading: SizedBox(width: 52, child: item.imagePath == null ? const Icon(Icons.image_outlined) : Image.file(File(item.imagePath!), fit: BoxFit.cover)), title: Text(item.title), subtitle: Text(item.location.isEmpty ? item.category : item.location), trailing: Icon(item.isLost ? Icons.search : Icons.check_circle_outline, color: AppColors.purple))).toList())),
    ]);
  }
}
