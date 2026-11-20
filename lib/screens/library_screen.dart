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
  static const _icons = [
    Icons.music_note,
    Icons.headphones,
    Icons.folder_outlined
  ];

  List<Widget> _songs() => [
        SectionHeader('Songs', Icons.music_note,
            onViewAll: () => Navigator.pushNamed(context, Routes.liked)),
        for (final s in songs.take(3))
          SongTile(s,
              showMeta: false,
              onTap: () => Navigator.pushNamed(context, Routes.player)),
      ];

  List<Widget> _artists() => [
        SectionHeader('Artists', Icons.edit_outlined, onViewAll: () {}),
        HList(
          112,
          [
            for (final entry in artistNames.indexed)
              ArtistAvatar(
                entry.$1 + 2,
                entry.$2,
                size: 78,
                imageUrl: songs[entry.$1].artworkUrl,
              ),
          ],
        ),
      ];

  List<Widget> _playlists() => [
        const SectionHeader('Playlists', Icons.folder_outlined),
        for (final p in playlists)
          SongTile(p,
              art: 56,
              onTap: () => Navigator.pushNamed(context, Routes.playlist)),
      ];

  @override
  Widget build(BuildContext context) {
    final sections = [
      [_songs(), _artists(), _playlists()],
      [_artists(), _playlists()],
      [_playlists()],
    ][_tab];
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final horizontalPadding = constraints.maxWidth >= 700 ? 24.0 : 16.0;
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: ListView(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  16,
                  horizontalPadding,
                  20,
                ),
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Music Library',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Your favorite songs, artists and playlists',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.hint,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CircleBtn(
                        Icons.search,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  HList(
                    42,
                    [
                      for (var i = 0; i < 3; i++)
                        PillChip(
                          _labels[i],
                          _icons[i],
                          selected: i == _tab,
                          onTap: () => setState(() => _tab = i),
                        ),
                    ],
                  ),
                  for (final section in sections) ...section,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
