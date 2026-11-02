import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/lost_found_item.dart';
import '../widgets/app_colors.dart';
import '../widgets/primary_button.dart';

class CreateItemPage extends StatefulWidget {
  const CreateItemPage({super.key});

  @override
  State<CreateItemPage> createState() => _CreateItemPageState();
}

class _CreateItemPageState extends State<CreateItemPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  String _category = 'Бусад';
  bool _isLost = true;
  XFile? _image;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String label) => InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(color: AppColors.muted, fontSize: 12),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(13),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFEDEDF2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.purple),
        ),
      );

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null && mounted) setState(() => _image = image);
  }

  void _continue() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Зүйлийн нэрийг оруулна уу.')),
      );
      return;
    }
    final item = LostFoundItem(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      location: _locationController.text.trim(),
      category: _category,
      isLost: _isLost,
      createdAt: DateTime.now(),
      imagePath: _image?.path,
    );
    Navigator.of(context).pop(item);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Зар оруулах',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          centerTitle: true,
          backgroundColor: AppColors.background,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFEDEDF2)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _image == null
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_photo_alternate_outlined,
                                  size: 32, color: AppColors.purple),
                              SizedBox(height: 8),
                              Text('Зураг нэмэх',
                                  style: TextStyle(
                                      color: AppColors.muted, fontSize: 12)),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(11),
                            child: Image.file(File(_image!.path),
                                fit: BoxFit.contain),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Зарын төрөл',
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(value: true, label: Text('Алдсан')),
                    ButtonSegment(value: false, label: Text('Олсон')),
                  ],
                  selected: {_isLost},
                  onSelectionChanged: (selection) =>
                      setState(() => _isLost = selection.first),
                  style: SegmentedButton.styleFrom(
                    selectedBackgroundColor: AppColors.purple,
                    selectedForegroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 17),
                TextField(
                  controller: _titleController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: _decoration('Зүйлийн нэр'),
                ),
                const SizedBox(height: 13),
                TextField(
                  controller: _locationController,
                  decoration: _decoration('Байршил'),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 13),
                DropdownButtonFormField<String>(
                  initialValue: _category,
                  decoration: _decoration('Ангилал'),
                  items: const ['Бусад', 'Цахилгаан бараа', 'Түлхүүр', 'Цүнх', 'Бичиг баримт']
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category,
                                style: const TextStyle(fontSize: 12)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => _category = value);
                  },
                ),
                const SizedBox(height: 13),
                TextField(
                  controller: _descriptionController,
                  maxLines: 4,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: _decoration('Зүйлийг тайлбарлана уу'),
                ),
                const SizedBox(height: 22),
                PrimaryButton(label: 'Нийтлэх', onPressed: _continue),
              ],
            ),
          ),
        ),
      );
}
