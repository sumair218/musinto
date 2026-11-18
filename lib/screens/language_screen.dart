import 'package:flutter/material.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../core/widgets.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});
  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  static const _languages = ['Hindi', 'English', 'Gujarati', 'Punjabi', 'Marathi', 'Tamil / Telugu'];
  static const _assets = [
    'lib/assets/images/Hindi_Singer.png',
    'lib/assets/images/English_Singer.png',
    'lib/assets/images/Tealgu_Singer.png',
    'lib/assets/images/Punjabi_Singer.png',
    'lib/assets/images/Marathi_singer.png',
    'lib/assets/images/Tealgu_Singer.png',
  ];
  int _selected = 2;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              GestureDetector(
                onTap: () => Navigator.maybePop(context),
                child: const CircleAvatar(
                  radius: 17,
                  backgroundColor: AppColors.grey,
                  child: Icon(Icons.close, size: 16, color: AppColors.dark),
                ),
              ),
              const SizedBox(height: 28),
              const Text('Select Your Music\nLanguage',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, height: 1.3)),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  itemCount: _languages.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 2.4,
                  ),
                  itemBuilder: (_, i) => _tile(i),
                ),
              ),
              AppButton(
                label: 'Continue',
                onTap: () => Navigator.pushNamedAndRemoveUntil(context, Routes.main, (_) => false),
              ),
            ]),
          ),
        ),
      );

  Widget _tile(int i) {
    final selected = i == _selected;
    return GestureDetector(
      onTap: () => setState(() => _selected = i),
      child: Container(
        padding: const EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFFEEF3) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: selected ? AppColors.pink : const Color(0xFFE6E6E6)),
        ),
        child: Row(children: [
          Expanded(
              child: Text(_languages[i],
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500))),
          ClipOval(
            child: Image.asset(
              _assets[i],
              width: 28,
              height: 28,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
        ]),
      ),
    );
  }
}
