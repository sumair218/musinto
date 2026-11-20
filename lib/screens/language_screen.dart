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
  static const _languages = [
    'Hindi',
    'English',
    'Gujarati',
    'Punjabi',
    'Marathi',
    'Tamil /\nTelugu',
  ];
  static const _assets = [
    'lib/assets/images/Hindi_Singer.png',
    'lib/assets/images/English_Singer.png',
    'lib/assets/images/Tealgu_Singer.png',
    'lib/assets/images/Punjabi_Singer.png',
    'lib/assets/images/Marathi_singer.png',
    'lib/assets/images/Tealgu_Singer.png',
  ];
  final Set<int> _selected = {2};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.maybePop(context),
                child: const CircleAvatar(
                  key: Key('language-close'),
                  radius: 22,
                  backgroundColor: AppColors.grey,
                  child: Icon(Icons.close, size: 20, color: AppColors.dark),
                ),
              ),
              const SizedBox(height: 34),
              const Text(
                'Select Your Music\nLanguage',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  height: 1.18,
                ),
              ),
              const SizedBox(height: 38),
              Expanded(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _languages.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 2.18,
                  ),
                  itemBuilder: (_, i) => _tile(i),
                ),
              ),
              AppButton(
                label: 'Continue',
                height: 58,
                borderRadius: 18,
                fontSize: 16,
                onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.main,
                  (_) => false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tile(int i) {
    final selected = _selected.contains(i);
    return GestureDetector(
      key: Key('language-option-$i'),
      onTap: () => setState(() {
        if (selected) {
          _selected.remove(i);
        } else {
          _selected.add(i);
        }
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFFEEF3) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppColors.pink : const Color(0xFFDADADD),
            width: selected ? 1.5 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  _languages[i],
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    height: 1.15,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 76,
              height: double.infinity,
              child: Image.asset(
                _assets[i],
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
