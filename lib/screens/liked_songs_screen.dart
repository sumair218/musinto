import 'package:flutter/material.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../core/ui.dart';
import '../data/mock.dart';

class LikedSongsScreen extends StatelessWidget {
  const LikedSongsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: ListView(padding: const EdgeInsets.all(16), children: [
            const TopBar([CircleBtn(Icons.queue_music), CircleBtn(Icons.shuffle)]),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: const Color(0xFFEDEFF4), borderRadius: BorderRadius.circular(12)),
              child: Row(children: [
                const Icon(Icons.music_note, size: 28),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Saved Songs',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    Text('25+ Songs', style: TextStyle(fontSize: 10, color: AppColors.hint)),
                  ]),
                ),
                CircleBtn(Icons.play_arrow,
                    size: 44,
                    primary: true,
                    onTap: () => Navigator.pushNamed(context, Routes.player)),
              ]),
            ),
            const SizedBox(height: 8),
            for (final s in songs)
              SongTile(s, showMeta: false, onTap: () => Navigator.pushNamed(context, Routes.player)),
          ]),
        ),
      );
}
