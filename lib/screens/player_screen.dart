import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/ui.dart';
import '../data/mock.dart';

/// Full-screen music player. Tap the artwork to switch circle <-> vinyl.
class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});
  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _spin =
      AnimationController(vsync: this, duration: const Duration(seconds: 12))..repeat();
  bool _vinyl = false;
  int _tab = 1;

  @override
  void dispose() {
    _spin.dispose();
    super.dispose();
  }

  Widget get _art => _vinyl
      ? Container(
          width: 260,
          height: 260,
          decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
          child: const Center(child: ClipOval(child: CoverArt(2, w: 110, icon: Icons.person))),
        )
      : const ClipOval(child: CoverArt(2, w: 260, icon: Icons.person));

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: ListView(padding: const EdgeInsets.all(16), children: [
            Center(
              child: GestureDetector(
                onTap: () => Navigator.maybePop(context),
                child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                        color: const Color(0xFFDDDDDD), borderRadius: BorderRadius.circular(4))),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () => setState(() => _vinyl = !_vinyl),
                child: RotationTransition(turns: _spin, child: _art),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Saul Mate - By Emmy Stark',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            const Text('Emmy Stark, Jhon Snow, Eddy brok',
                style: TextStyle(fontSize: 11, color: AppColors.hint)),
            const SizedBox(height: 8),
            PlayerControls(onPlayChanged: (p) => p ? _spin.repeat() : _spin.stop()),
            const SizedBox(height: 12),
            UnderlineTabs(const ['Similar', 'Up Next'],
                const [Icons.auto_awesome, Icons.list], _tab, (i) => setState(() => _tab = i)),
            const SizedBox(height: 8),
            for (final s in (_tab == 0 ? songs.reversed : songs))
              SongTile(s,
                  showMeta: false,
                  trailing: const Icon(Icons.drag_handle, color: AppColors.hint)),
          ]),
        ),
      );
}
