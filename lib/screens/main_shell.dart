import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/ui.dart';
import 'home_screen.dart';
import 'library_screen.dart';
import 'podcasts_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';

/// Bottom-navigation host with the persistent mini player.
class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  static const _icons = [
    Icons.music_note,
    Icons.podcasts,
    Icons.search,
    Icons.queue_music,
    Icons.person
  ];
  static const _labels = ['Music', 'Podcast', 'Search', 'Library', 'Profile'];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(children: [
          Expanded(
            child: IndexedStack(index: _index, children: const [
              HomeScreen(),
              PodcastsScreen(),
              SearchScreen(),
              LibraryScreen(),
              ProfileScreen(),
            ]),
          ),
          if (_index != 2 && _index != 4)
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: const MiniPlayer(),
              ),
            ),
          SafeArea(
            top: false,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(5, (i) {
                      final sel = i == _index;
                      return GestureDetector(
                        onTap: () => setState(() => _index = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(
                            horizontal: sel ? 14 : 10,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: sel ? AppColors.pink : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(children: [
                            Icon(
                              _icons[i],
                              size: 20,
                              color: sel ? Colors.white : AppColors.dark,
                            ),
                            if (sel) ...[
                              const SizedBox(width: 6),
                              Text(
                                _labels[i],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ]),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        ]),
      );
}
