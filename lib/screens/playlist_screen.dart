import 'package:flutter/material.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../core/ui.dart';
import '../data/mock.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  void _play(BuildContext c) => Navigator.pushNamed(c, Routes.player);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: ListView(padding: const EdgeInsets.all(16), children: [
            const TopBar([CircleBtn(Icons.share_outlined)]),
            const SizedBox(height: 16),
            const Center(child: CoverArt(0, w: 220, radius: 14, icon: Icons.graphic_eq)),
            const SizedBox(height: 16),
            const Center(
                child: Text('Edm House - By Unimagines',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))),
            const SizedBox(height: 4),
            const Center(
                child: Text('Unimagine Foxes, Jhon Snow, Eddy brok',
                    style: TextStyle(fontSize: 11, color: AppColors.hint))),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const CircleBtn(Icons.shuffle),
              const SizedBox(width: 16),
              CircleBtn(Icons.play_arrow, size: 60, primary: true, onTap: () => _play(context)),
              const SizedBox(width: 16),
              const CircleBtn(Icons.queue_music),
            ]),
            const SizedBox(height: 12),
            for (final s in songs.skip(1)) SongTile(s, onTap: () => _play(context)),
            const SectionHeader('Recommended For You', Icons.music_note),
            const HList(124, [
              PosterCard('Party Pool - Re-Released', 1),
              PosterCard('Bolt Strange - All Songs', 2),
              PosterCard('Night Drive', 0),
            ]),
          ]),
        ),
      );
}
