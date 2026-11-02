import 'dart:io';
import 'package:flutter/material.dart';
import '../models/lost_found_item.dart';
import '../widgets/app_colors.dart';
import 'create_item_page.dart';
import 'item_detail_page.dart';
import 'messages_page.dart';
import 'profile_page.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedFilter = 0;
  int _selectedTab = 0;
  final List<LostFoundItem> _items = [];
  final Set<LostFoundItem> _saved = {};

  Future<void> _createItem() async {
    final item = await Navigator.of(context).push<LostFoundItem>(
      MaterialPageRoute(builder: (_) => const CreateItemPage()),
    );
    if (item != null && mounted) {
      setState(() {
        _items.insert(0, item);
        _selectedTab = 0;
      });
    }
  }

  Future<void> _openItem(LostFoundItem item) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => ItemDetailPage(
          item: item,
          isSaved: _saved.contains(item),
          onSavedChanged: (saved) => setState(() {
            if (saved) {
              _saved.add(item);
            } else {
              _saved.remove(item);
            }
          }),
        ),
      ),
    );
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = _items.where((item) {
      if (_selectedFilter == 1) return item.isLost;
      if (_selectedFilter == 2) return !item.isLost;
      return true;
    }).toList();

    final pages = [
      _HomeFeed(
        items: filteredItems,
        selectedFilter: _selectedFilter,
        onFilterChanged: (value) => setState(() => _selectedFilter = value),
        onOpenItem: _openItem,
        onNotifications: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const NotificationsPage()),
        ),
      ),
      SearchPage(items: _items, onOpenItem: _openItem),
      _SavedPage(items: _saved.toList(), onOpenItem: _openItem),
      ProfilePage(savedCount: _saved.length, itemCount: _items.length),
    ];

    return Scaffold(
      body: SafeArea(child: IndexedStack(index: _selectedTab, children: pages)),
      floatingActionButton: _selectedTab == 0
          ? FloatingActionButton(
              onPressed: _createItem,
              backgroundColor: AppColors.purple,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: const CircleBorder(),
              child: const Icon(Icons.add, size: 28),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) {
          if (index == 1) {
            setState(() => _selectedTab = 1);
          } else {
            setState(() => _selectedTab = index);
            if (index == 0) return;
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.purple,
        unselectedItemColor: AppColors.muted,
        selectedFontSize: 9,
        unselectedFontSize: 9,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined, size: 20), label: 'Нүүр'),
          BottomNavigationBarItem(icon: Icon(Icons.search, size: 20), label: 'Хайлт'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border, size: 20), label: 'Хадгалсан'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline, size: 20), label: 'Профайл'),
        ],
      ),
    );
  }
}

class _HomeFeed extends StatelessWidget {
  const _HomeFeed({
    required this.items,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.onOpenItem,
    required this.onNotifications,
  });

  final List<LostFoundItem> items;
  final int selectedFilter;
  final ValueChanged<int> onFilterChanged;
  final ValueChanged<LostFoundItem> onOpenItem;
  final VoidCallback onNotifications;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 9, 12, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: AppColors.purple, size: 19),
                    const SizedBox(width: 5),
                    const Text('Миний ойролцоо', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    const Icon(Icons.keyboard_arrow_down, size: 17),
                    const Spacer(),
                    IconButton(onPressed: onNotifications, icon: const Icon(Icons.notifications_none, size: 21)),
                    IconButton(
                      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MessagesPage())),
                      icon: const Icon(Icons.chat_bubble_outline, size: 19),
                    ),
                  ],
                ),
                _SearchField(hint: 'Хайх зүйл...', onChanged: (_) {}),
                const SizedBox(height: 10),
                Row(
                  children: ['Бүгд', 'Алдсан', 'Олсон'].asMap().entries.map((entry) {
                    final active = selectedFilter == entry.key;
                    return Padding(
                      padding: const EdgeInsets.only(right: 7),
                      child: ChoiceChip(
                        label: Text(entry.value), selected: active,
                        onSelected: (_) => onFilterChanged(entry.key), showCheckmark: false,
                        labelStyle: TextStyle(color: active ? Colors.white : AppColors.ink, fontSize: 10),
                        backgroundColor: const Color(0xFFF0F0F3), selectedColor: AppColors.purple,
                        side: BorderSide.none, visualDensity: VisualDensity.compact,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text('Одоогоор зар алга', style: TextStyle(color: AppColors.muted, fontSize: 13)))
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 78),
                    itemCount: items.length,
                    itemBuilder: (context, index) => _ItemTile(item: items[index], onTap: () => onOpenItem(items[index])),
                  ),
          ),
        ],
      );
}

class _SavedPage extends StatelessWidget {
  const _SavedPage({required this.items, required this.onOpenItem});
  final List<LostFoundItem> items;
  final ValueChanged<LostFoundItem> onOpenItem;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const Padding(padding: EdgeInsets.all(18), child: Text('Хадгалсан', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700))),
          Expanded(child: items.isEmpty
              ? const Center(child: Text('Хадгалсан зар алга', style: TextStyle(color: AppColors.muted, fontSize: 13)))
              : ListView(children: items.map((item) => _ItemTile(item: item, onTap: () => onOpenItem(item))).toList())),
        ],
      );
}

class _ItemTile extends StatelessWidget {
  const _ItemTile({required this.item, required this.onTap});
  final LostFoundItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        leading: SizedBox(
          width: 61, height: 69,
          child: item.imagePath == null
              ? const ColoredBox(color: Color(0xFFF3F3F6), child: Icon(Icons.image_outlined, color: AppColors.muted))
              : Image.file(File(item.imagePath!), fit: BoxFit.cover),
        ),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _StatusPill(isLost: item.isLost),
          const SizedBox(height: 4),
          Text(item.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(item.location.isEmpty ? item.category : item.location, maxLines: 1, overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10, color: AppColors.muted)),
        ]),
        trailing: const Icon(Icons.chevron_right, color: AppColors.muted, size: 18),
      );
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.isLost});
  final bool isLost;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(color: isLost ? const Color(0xFFFFE5E8) : const Color(0xFFE0F4E6), borderRadius: BorderRadius.circular(10)),
        child: Text(isLost ? 'Алдсан' : 'Олсон', style: TextStyle(fontSize: 9, color: isLost ? const Color(0xFFE95A68) : const Color(0xFF46A86A))),
      );
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.hint, required this.onChanged});
  final String hint;
  final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) => SizedBox(
        height: 39,
        child: TextField(onChanged: onChanged, decoration: InputDecoration(
          hintText: hint, hintStyle: const TextStyle(color: AppColors.muted, fontSize: 11),
          prefixIcon: const Icon(Icons.search, size: 18, color: AppColors.muted), contentPadding: EdgeInsets.zero,
          filled: true, fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFEDEDF2))),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.purple)),
        )),
      );
}

