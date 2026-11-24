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
                        color: const Color(0xFFDDDDDD),
                        borderRadius: BorderRadius.circular(4))),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 150,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFFC52C),
                    Color(0xFF4DB9FF),
                    Color(0xFF315BEA),
                  ],
                ),
              ),
              child: const Stack(
                children: [
                  Positioned(
                    left: 16,
                    top: 18,
                    child: Text(
                      'Tough Life',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    top: 38,
                    child: Text(
                      'PODCAST',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 22,
                    bottom: -12,
                    child: Icon(Icons.headphones,
                        size: 112, color: Color(0xFFFF78B2)),
                  ),
                  Positioned(
                    right: 55,
                    bottom: 28,
                    child: Icon(Icons.mic, size: 44, color: Color(0xFF202640)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('Saul Mate - By Emmy Stark',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            const Text('Emmy Stark, Jhon Snow, Eddy brok',
                style: TextStyle(fontSize: 11, color: AppColors.hint)),
            const SizedBox(height: 8),
            const PlayerControls(),
            const SectionHeader('Up - Next', Icons.list),
            for (final e in episodes)
              SongTile(e, art: 76, artH: 44, trailing: const SizedBox.shrink()),
          ]),
        ),
      );
}
