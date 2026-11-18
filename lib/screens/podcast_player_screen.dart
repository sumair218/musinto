import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/ui.dart';
import '../data/mock.dart';

class PodcastPlayerScreen extends StatelessWidget {
  const PodcastPlayerScreen({super.key});

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
            const SizedBox(height: 16),
            const CoverArt(4, w: double.infinity, h: 150, radius: 12, icon: Icons.mic),
            const SizedBox(height: 16),
            const Text('Saul Mate - By Emmy Stark',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            const Text('Emmy Stark, Jhon Snow, Eddy brok',
                style: TextStyle(fontSize: 11, color: AppColors.hint)),
            const SizedBox(height: 8),
            const PlayerControls(),
            const SectionHeader('Up - Next', Icons.list),
            for (final e in episodes) SongTile(e, art: 76, artH: 44, trailing: const SizedBox.shrink()),
          ]),
        ),
      );
}
