import 'package:flutter/material.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../core/ui.dart';
import '../data/mock.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _open(BuildContext c) => Navigator.pushNamed(c, Routes.playlist);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: ListView(padding: const EdgeInsets.fromLTRB(16, 12, 16, 16), children: [
          Row(children: [
            const Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text.rich(
                  TextSpan(text: 'Hello.! ', children: [
                    TextSpan(text: 'Pavan', style: TextStyle(color: AppColors.pink)),
                    TextSpan(text: ' 👋'),
                  ]),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Text('Good Morning', style: TextStyle(fontSize: 11, color: AppColors.hint)),
              ]),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.auto_awesome, size: 14, color: AppColors.pink),
              label: const Text('Ai Mix', style: TextStyle(fontSize: 11, color: AppColors.dark)),
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFFFD0DC)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            ),
          ]),
          const SizedBox(height: 16),
          HList(40, [
            for (final c in ['Devotion', 'Workout', 'Party', 'Romance'])
              PillChip(c, Icons.local_fire_department_outlined),
          ]),
          const SectionHeader('Quick Play', Icons.auto_awesome),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            for (final e in ['Strom H...', 'Jui - LoFi', 'Saul Mate', 'Jack - Sui'].indexed)
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, Routes.player),
                child: Column(children: [
                  CoverArt(e.$1 + 1, w: 66, radius: 10),
                  const SizedBox(height: 4),
                  Text(e.$2, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w500)),
                ]),
              ),
          ]),
          const SectionHeader('Daily Mix', Icons.music_note),
          HList(126, [
            for (var i = 1; i <= 3; i++)
              GestureDetector(
                  onTap: () => _open(context), child: PosterCard('Daily Mix $i', i + 1, h: 100)),
          ]),
          SectionHeader('Energetic Hollywood', Icons.bolt, onViewAll: () => _open(context)),
          for (final s in songs.take(2)) SongTile(s, onTap: () => _open(context)),
          SectionHeader('Untouched Beats', Icons.music_note, onViewAll: () => _open(context)),
          const HList(124, [
            PosterCard('Anova Bee By Amma Brok', 2),
            PosterCard('Pink Dream by Emma Brok', 1),
            PosterCard('Night Drive', 0),
          ]),
          SectionHeader('Top Voices', Icons.mic_none, onViewAll: () {}),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            for (final e in artistNames.indexed) ArtistAvatar(e.$1 + 2, e.$2),
          ]),
        ]),
      );
}
