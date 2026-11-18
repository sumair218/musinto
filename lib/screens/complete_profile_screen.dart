import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../core/widgets.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});
  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  static const _genders = ['Male', 'Female', 'Other'];
  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  final _days = List.generate(31, (i) => '${i + 1}'.padLeft(2, '0'));
  final _years = List.generate(80, (i) => '${1950 + i}');

  int _gender = 0;
  int _day = 5, _month = 4, _year = 46; // 06 May 1996

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      (constraints.maxHeight - 40).clamp(0, double.infinity),
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _RoundIcon(
                            icon: Icons.chevron_left,
                            onTap: () => Navigator.maybePop(context),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Text(
                              'Create New Account',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Center(
                        child: _ProfileAvatar(),
                      ),
                      const SizedBox(height: 28),
                      const AppTextField(
                        hint: 'Pavan Kumar',
                        icon: Icons.person_outline,
                        active: true,
                      ),
                      const SizedBox(height: 14),
                      _genderSelector(),
                      const SizedBox(height: 18),
                      const Text(
                        'Set Date Of Birth',
                        style: TextStyle(fontSize: 11),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 130,
                        child: Row(
                          children: [
                            _wheel(
                                _days, _day, (i) => setState(() => _day = i)),
                            const SizedBox(width: 12),
                            _wheel(
                              _months,
                              _month,
                              (i) => setState(() => _month = i),
                            ),
                            const SizedBox(width: 12),
                            _wheel(
                              _years,
                              _year,
                              (i) => setState(() => _year = i),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      AppButton(
                        label: 'Continue',
                        onTap: () =>
                            Navigator.pushNamed(context, Routes.language),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget _genderSelector() => Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 8)],
        ),
        child: Row(
          children: List.generate(_genders.length, (i) {
            final selected = i == _gender;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _gender = i),
                child: Container(
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected ? AppColors.dark : Colors.transparent,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Text(_genders[i],
                      style: TextStyle(
                          fontSize: 11,
                          color: selected ? Colors.white : AppColors.dark)),
                ),
              ),
            );
          }),
        ),
      );

  Widget _wheel(
          List<String> items, int selected, ValueChanged<int> onChanged) =>
      Expanded(
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.grey, borderRadius: BorderRadius.circular(12)),
          child: CupertinoPicker(
            itemExtent: 34,
            scrollController:
                FixedExtentScrollController(initialItem: selected),
            selectionOverlay: const SizedBox.shrink(),
            onSelectedItemChanged: onChanged,
            children: List.generate(
              items.length,
              (i) => Center(
                child: Text(items[i],
                    style: TextStyle(
                      fontSize: i == selected ? 20 : 12,
                      fontWeight:
                          i == selected ? FontWeight.w700 : FontWeight.w400,
                      color: i == selected ? AppColors.dark : AppColors.hint,
                    )),
              ),
            ),
          ),
        ),
      );
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar();

  @override
  Widget build(BuildContext context) => Stack(
        clipBehavior: Clip.none,
        children: [
          const CircleAvatar(
            radius: 42,
            backgroundColor: AppColors.grey,
            backgroundImage: AssetImage('lib/assets/images/English_Singer.png'),
          ),
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: AppColors.pink,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
}

class _RoundIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _RoundIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 34,
          height: 34,
          decoration: const BoxDecoration(
              color: AppColors.grey, shape: BoxShape.circle),
          child: Icon(icon, size: 18),
        ),
      );
}
