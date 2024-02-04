import 'package:flutter/material.dart';
import 'package:gym_music_app/components/neu_box.dart';
import 'package:gym_music_app/models/playlist_provider.dart';
import 'package:gym_music_app/pages/settings_page.dart';
import 'package:provider/provider.dart';

import 'heart_icon.dart';

// for transition between song page and homepage

class SongPage extends StatefulWidget {
  const SongPage({Key? key}) : super(key: key);
  @override
  SongPageState createState() => SongPageState();
}

class SongPageState extends State<SongPage> {
  bool isFavorite = false;

  //convert duration ito min:sec
  String formatTime(Duration duration) {
    String twoDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        //get playlist
        final playlist = value.playlist;

        //get current song index
        final currentSong = playlist[value.currentSongIndex ?? 0];

        //return scaffold UI
        return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //app bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //back buttom
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                        ),
                        //title
                        const Text(
                          "P L A Y L I S T",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),

                        //menu button
                        IconButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SettingsPage(),
                              )),
                          icon: const Icon(Icons.menu),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //album artwork
                    NeuBox(
                        child: Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                                currentSong.albumArtPath)), //1080*1351

                        //song and the artist name and icon
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //song and artist name
                              Column(
                                children: [
                                  Text(
                                    currentSong.songName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(currentSong.artistName),
                                ],
                              ),
                              //heart icon
                              HeartIcon(
                                isFavorite: isFavorite,
                                onTap: (bool newFavorite) {
                                  setState(() {
                                    isFavorite = newFavorite;
                                  });
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    )),

                    const SizedBox(
                      height: 25,
                    ),

                    //song duraton progress
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //start time
                              Text(formatTime(value.currentDuration)),

                              //shuffle icon
                              const Icon(Icons.shuffle),

                              //repeat icon
                              GestureDetector(
                                child: Icon(Icons.repeat,
                                    color: value.repeatIconColor),
                                onTap: () {
                                  value.toggleRepeatState();
                                  value.repeatCurrentSong();
                                },
                              ),

                              //end time
                              Text(formatTime(value.totalDuration)),
                            ],
                          ),
                        ),

                        //song duration progress
                        SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 5),
                            ),
                            child: Slider(
                              min: 0,
                              max: value.totalDuration.inSeconds.toDouble(),
                              value: value.currentDuration.inSeconds.toDouble(),
                              activeColor:
                                  const Color.fromARGB(255, 28, 32, 28),
                              onChanged: (double double) {
                                //during user sliding
                              },
                              onChangeEnd: (double double) {
                                //after slliding
                                value.seek(Duration(seconds: double.toInt()));
                              },
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //playback controls
                    Row(
                      children: [
                        //skip previous
                        Expanded(
                          child: GestureDetector(
                            onTap: value.playPreviousSong,
                            child: const NeuBox(
                              child: Icon(Icons.skip_previous),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),

                        //play pause
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: value.pauseOrResume,
                            child: NeuBox(
                              child: Icon(value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),

                        //skip next
                        Expanded(
                          child: GestureDetector(
                            onTap: value.playNextSong,
                            child: const NeuBox(
                              child: Icon(Icons.skip_next),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
