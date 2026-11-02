import 'dart:io';
import 'package:flutter/material.dart';
import '../models/lost_found_item.dart';
import '../widgets/app_colors.dart';
import 'messages_page.dart';

class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage({super.key, required this.item, this.isSaved = false, this.onSavedChanged});

  final LostFoundItem item;
  final bool isSaved;
  final ValueChanged<bool>? onSavedChanged;

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  late bool _saved = widget.isSaved;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 270,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: item.imagePath == null
                                ? const ColoredBox(
                                    color: Colors.white,
                                    child: Icon(Icons.image_outlined,
                                        size: 70, color: Color(0xFFD8D8DF)),
                                  )
                                : Image.file(File(item.imagePath!),
                                    fit: BoxFit.contain),
                          ),
                          Positioned(
                            top: 8,
                            left: 8,
                            child: _CircleAction(
                              icon: Icons.arrow_back,
                              onTap: () => Navigator.of(context).pop(),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Row(
                              children: [
                                _CircleAction(
                                  icon: _saved
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  onTap: () {
                                    setState(() => _saved = !_saved);
                                    widget.onSavedChanged?.call(_saved);
                                  },
                                ),
                                const SizedBox(width: 8),
                                _CircleAction(
                                  icon: Icons.share_outlined,
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 16,
                            bottom: 13,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text('1 / 1',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(18, 4, 18, 24),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        Align(
                          alignment: Alignment.centerLeft,
                          child: _StatusTag(isLost: item.isLost),
                        ),
                        const SizedBox(height: 9),
                        Text(item.title,
                            style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w700,
                                color: AppColors.ink)),
                        const SizedBox(height: 9),
                        _MetaLine(
                          icon: Icons.location_on_outlined,
                          text: item.location.isEmpty ? 'Байршил оруулаагүй' : item.location,
                        ),
                        const SizedBox(height: 8),
                        _MetaLine(
                          icon: Icons.calendar_month_outlined,
                          text: _formatDate(item.createdAt),
                        ),
                        const SizedBox(height: 23),
                        const Text('Тайлбар',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 7),
                        Text(
                          item.description.isEmpty
                              ? 'Тайлбар оруулаагүй.'
                              : item.description,
                          style: const TextStyle(
                              fontSize: 12, height: 1.55, color: AppColors.ink),
                        ),
                        const SizedBox(height: 19),
                        const Text('Ангилал',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2F2F5),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Text(item.category,
                                style: const TextStyle(fontSize: 11)),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
              child: SizedBox(
                width: double.infinity,
                height: 42,
                child: FilledButton.icon(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => ChatPage(item: item))),
                  icon: const Icon(Icons.chat_bubble_outline, size: 17),
                  label: const Text('Холбоо барих'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.purple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _formatDate(DateTime? date) {
  if (date == null) return 'Огноо оруулаагүй';
  final local = date.toLocal();
  final month = local.month.toString().padLeft(2, '0');
  final day = local.day.toString().padLeft(2, '0');
  final hour = local.hour.toString().padLeft(2, '0');
  final minute = local.minute.toString().padLeft(2, '0');
  return '${local.year}.$month.$day $hour:$minute';
}

class _CircleAction extends StatelessWidget {
  const _CircleAction({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.white.withValues(alpha: 0.9),
        shape: const CircleBorder(),
        child: IconButton(
          onPressed: onTap,
          icon: Icon(icon, size: 19, color: AppColors.purple),
          constraints: const BoxConstraints.tightFor(width: 38, height: 38),
          padding: EdgeInsets.zero,
        ),
      );
}

class _StatusTag extends StatelessWidget {
  const _StatusTag({required this.isLost});
  final bool isLost;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isLost ? const Color(0xFFFFE5E8) : const Color(0xFFE0F4E6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(isLost ? 'Алдсан' : 'Олсон',
            style: TextStyle(
                fontSize: 10,
                color: isLost
                    ? const Color(0xFFE95A68)
                    : const Color(0xFF46A86A))),
      );
}

class _MetaLine extends StatelessWidget {
  const _MetaLine({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Icon(icon, size: 15, color: AppColors.muted),
          const SizedBox(width: 6),
          Expanded(
            child: Text(text,
                style: const TextStyle(color: AppColors.muted, fontSize: 11)),
          ),
        ],
      );
}
