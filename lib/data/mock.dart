/// Demo data. Replace with your API / database models.
class Song {
  final String title, artists, meta;
  final int seed; // picks placeholder art colours
  const Song(this.title, this.artists, this.meta, this.seed);
}

const songs = [
  Song('Edm House - By Unimagines', 'Emmy Stark, Jhon Snow, Eddy brok', 'Playlist | 25M Views', 0),
  Song('Party Night - Doom Spot', 'Doom Spot, Jhon Snow, Eddy brok', 'Song | 24K Views', 1),
  Song('Endor Spark - Repair', 'Tarin, Kevin, Bob Sammy', 'Song | 45M Views', 2),
  Song('Saturday - Kelly Clen', 'Kelly Clen, Kevin, Doom Spot', 'Song | 246K Views', 3),
  Song('Strom Huise - By Emmy Stark', 'Emmy Stark, Jhon Snow, Eddy brok', 'Song | 12K Views', 4),
  Song('Party Night Lo-Fi', 'Eddy Sins, Worsen, Doom', 'Song | 654K Views', 1),
];

const playlists = [
  Song('Party Night - Doom Spot', 'Doom Spot, Jhon Snow, Eddy brok', '12 Songs | 12 Hours', 1),
  Song('Endor Spark - Repair', 'Tarin, Kevin, Bob Sammy', '18 Songs | 3 Hours', 2),
];

final episodes = List.generate(
  4,
  (i) => Song('Party Night - Doom Spot', 'Doom Spot, Jhon Snow, Eddy brok',
      '#${42 + i % 3} | 24K Views | 13 Days Ago', 3),
);

const artistNames = ['Aaditya Gandhi', 'Prabhu Ramaswamy', 'Megha Padkare'];
