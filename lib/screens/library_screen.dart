import 'package:flutter/material.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../core/ui.dart';
import '../data/mock.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});
  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int _tab = 0;
  static const _labels = ['Songs', 'Artists', 'Playlists'];
  static const _icons = [Icons.music_note, Icons.headphones, Icons.folder_outlined];

  List<Widget> _songs() => [
        SectionHeader('Songs', Icons.music_note,
            onViewAll: () => Navigator.pushNamed(context, Routes.liked)),
        for (final s in songs.take(3))
          SongTile(s, showMeta: false, onTap: () => Navigator.pushNamed(context, Routes.player)),
      ];

  List<Widget> _artists() => [
        SectionHeader('Artists', Icons.edit_outlined, onViewAll: () {}),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          for (final e in artistNames.indexed) ArtistAvatar(e.$1 + 2, e.$2),
        ]),
      ];

  List<Widget> _playlists() => [
        const SectionHeader('Playlists', Icons.folder_outlined),
        for (final p in playlists)
          SongTile(p, art: 56, onTap: () => Navigator.pushNamed(context, Routes.playlist)),
      ];

  @override
  Widget build(BuildContext context) {
    final sections = [
      [_songs(), _artists(), _playlists()],
      [_artists(), _playlists()],
      [_playlists()],
    ][_tab];
    return SafeArea(
      child: ListView(padding: const EdgeInsets.fromLTRB(16, 12, 16, 16), children: [
        const Text('Library', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        const Text('All your collected songs, Podcasts, Playlists',
            style: TextStyle(fontSize: 11, color: AppColors.hint)),
        const SizedBox(height: 14),
        HList(42, [
          for (var i = 0; i < 3; i++)
            PillChip(_labels[i], _icons[i], selected: i == _tab, onTap: () => setState(() => _tab = i)),
        ]),
        for (final s in sections) ...s,
      ]),
    );
  }
}
