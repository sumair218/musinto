import 'package:flutter/material.dart';

import '../core/routes.dart';
import '../core/theme.dart';
import '../core/ui.dart';
import '../data/mock.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final normalized = _query.trim().toLowerCase();
    final results = normalized.isEmpty
        ? songs
        : songs.where((song) {
            return song.title.toLowerCase().contains(normalized) ||
                song.artists.toLowerCase().contains(normalized);
          }).toList();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                const Text(
                  'Search',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 14),
                TextField(
                  key: const Key('search-field'),
                  onChanged: (value) => setState(() => _query = value),
                  style: const TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    hintText: 'Search songs, artists, or podcasts',
                    hintStyle:
                        const TextStyle(fontSize: 12, color: AppColors.hint),
                    prefixIcon: const Icon(Icons.search,
                        size: 20, color: AppColors.pink),
                    filled: true,
                    fillColor: AppColors.grey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 14),
                  ),
                ),
                const SizedBox(height: 18),
                if (normalized.isEmpty) ...[
                  const SectionHeader('Browse All', Icons.grid_view),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: const [
                      _BrowseTile('Romance', Icons.favorite, Color(0xFFFFECF2)),
                      _BrowseTile(
                          'Party', Icons.celebration, Color(0xFFFFF1DC)),
                      _BrowseTile(
                          'Workout', Icons.fitness_center, Color(0xFFECEAFF)),
                      _BrowseTile('Podcast', Icons.podcasts, Color(0xFFE2F4F7)),
                    ],
                  ),
                  const SectionHeader('Popular', Icons.local_fire_department),
                ],
                for (final song in results)
                  SongTile(
                    song,
                    showMeta: false,
                    onTap: () => Navigator.pushNamed(context, Routes.player),
                  ),
                if (normalized.isNotEmpty && results.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Center(
                      child: Text(
                        'No matching music found',
                        style: TextStyle(color: AppColors.hint),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BrowseTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _BrowseTile(this.label, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.sizeOf(context).width - 42) / 2;
    return Container(
      width: width > 250 ? 250 : width,
      height: 70,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.pink),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
