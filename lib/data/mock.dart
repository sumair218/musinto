/// Demo data. Replace with your API / database models.
class Song {
  final String title, artists, meta;
  final int seed; // picks placeholder art colours
  final String? artworkUrl;
  const Song(this.title, this.artists, this.meta, this.seed, {this.artworkUrl});
}

const songs = [
  Song(
    'Edm House - By Unimagines',
    'Emmy Stark, Jhon Snow, Eddy brok',
    'Playlist | 25M Views',
    0,
    artworkUrl:
        'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?auto=format&fit=crop&w=640&q=80',
  ),
  Song(
    'Party Night - Doom Spot',
    'Doom Spot, Jhon Snow, Eddy brok',
    'Song | 24K Views',
    1,
    artworkUrl:
        'https://images.unsplash.com/photo-1501386761578-eac5c94b800a?auto=format&fit=crop&w=640&q=80',
  ),
  Song(
    'Endor Spark - Repair',
    'Tarin, Kevin, Bob Sammy',
    'Song | 45M Views',
    2,
    artworkUrl:
        'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?auto=format&fit=crop&w=640&q=80',
  ),
  Song(
    'Saturday - Kelly Clen',
    'Kelly Clen, Kevin, Doom Spot',
    'Song | 246K Views',
    3,
    artworkUrl:
        'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?auto=format&fit=crop&w=640&q=80',
  ),
  Song(
    'Strom Huise - By Emmy Stark',
    'Emmy Stark, Jhon Snow, Eddy brok',
    'Song | 12K Views',
    4,
    artworkUrl:
        'https://images.unsplash.com/photo-1516280440614-37939bbacd81?auto=format&fit=crop&w=640&q=80',
  ),
  Song(
    'Party Night Lo-Fi',
    'Eddy Sins, Worsen, Doom',
    'Song | 654K Views',
    1,
    artworkUrl:
        'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=640&q=80',
  ),
];

const playlists = [
  Song(
    'Party Night - Doom Spot',
    'Doom Spot, Jhon Snow, Eddy brok',
    '12 Songs | 12 Hours',
    1,
    artworkUrl:
        'https://images.unsplash.com/photo-1501386761578-eac5c94b800a?auto=format&fit=crop&w=640&q=80',
  ),
  Song(
    'Endor Spark - Repair',
    'Tarin, Kevin, Bob Sammy',
    '18 Songs | 3 Hours',
    2,
    artworkUrl:
        'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?auto=format&fit=crop&w=640&q=80',
  ),
];

final episodes = List.generate(
  4,
  (i) => Song('Party Night - Doom Spot', 'Doom Spot, Jhon Snow, Eddy brok',
      '#${42 + i % 3} | 24K Views | 13 Days Ago', 3,
      artworkUrl: songs[i].artworkUrl),
);

const artistNames = ['Aaditya Gandhi', 'Prabhu Ramaswamy', 'Megha Padkare'];
