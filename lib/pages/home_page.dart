import 'package:flutter/material.dart';
import 'package:gym_music_app/components/my_drawer.dart';
import 'package:gym_music_app/components/neu_box.dart';
import 'package:gym_music_app/models/playlist_provider.dart';
import 'package:gym_music_app/pages/song_page.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../models/songs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final dynamic playlistProvider;

  @override
  void initState() {
    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  void goToSong(int songIndex) {
    playlistProvider.currentSongIndex = songIndex;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SongPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("P L A Y L I S T"),
      ),
      drawer: const MyDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          final List<Song> playlist = value.playlist;
          final List<Song> filteredPlaylist = playlist
              .where((song) =>
                  song.songName
                      .toLowerCase()
                      .contains(value.searchQuery.toLowerCase()) ||
                  song.artistName
                      .toLowerCase()
                      .contains(value.searchQuery.toLowerCase()))
              .toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (query) {
                    value.setSearchQuery(query);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    hintText: 'Search for songs or artists',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              if (value.searchQuery
                  .isEmpty) // Show carousel only when the search is empty
                NeuBox(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 350.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                    ),
                    items: playlist.map((song) {
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () => goToSong(playlist.indexOf(song)),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: AssetImage(song.albumArtPath),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              if (value.searchQuery.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredPlaylist.length,
                    itemBuilder: (context, index) {
                      final Song song = filteredPlaylist[index];
                      return ListTile(
                        title: Text(song.songName),
                        subtitle: Text(song.artistName),
                        leading: Image.asset(song.albumArtPath),
                        onTap: () => goToSong(index),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
