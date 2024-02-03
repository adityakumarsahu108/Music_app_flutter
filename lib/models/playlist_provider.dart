import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:gym_music_app/models/songs.dart';

class PlaylistProvider extends ChangeNotifier {
  bool _isRepeatActive = false;
  bool _isRepeatTempActive = false;
  //playlist of songs
  final List<Song> _playlist = [
    //song 1
    Song(
        songName: "Like a God",
        artistName: "The Weeknd",
        albumArtPath: "assets/images/likeagod.jpg",
        audioPath: "audio/likeagod.mp3"),

    //song 2
    Song(
        songName: "Popular",
        artistName: "The Weeknd",
        albumArtPath: "assets/images/popular.jpg",
        audioPath: "audio/starboy.mp3"),
    //song 3
    Song(
        songName: "Starboy",
        artistName: "The Weeknd",
        albumArtPath: "assets/images/starboy.jpg",
        audioPath: "audio/starboy.mp3"),
    //song 4
    Song(
        songName: "Top 10 The Weeknd",
        artistName: "The Weeknd",
        albumArtPath: "assets/images/all_weeknd.png",
        audioPath: "audio/all_weeknd.mp3"),
    //song 5
    Song(
        songName: "Best of Hindi English Remix ",
        artistName: "Remix",
        albumArtPath: "assets/images/hindi_english.jpg",
        audioPath: "audio/hindi_english.mp3"),
  ];

  //current song playing index
  int? _currentSongIndex;

  //AUDIO PLAYER
//audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

//duration
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

//constructor
  PlaylistProvider() {
    listenToDuration();
  }

//initially not playing
  bool _isPlaying = false;

//play the song
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

//pause the current song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

//resume the song
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

//pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

//seek to a specific position
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

//play next song;
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        //go to the next song if not last
        _currentSongIndex = _currentSongIndex! + 1;
      } else {
        //if last then loop back
        _currentSongIndex = 0;
      }
      play();
    }
  }

//play previou song
  void playPreviousSong() async {
    //if more than 4 seconds then restart the current song
    if (_currentDuration.inSeconds > 4) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        _currentSongIndex = _currentSongIndex! - 1;
        play();
      } else {
        //if first then loop to last
        _currentSongIndex = _playlist.length - 1;
        play();
      }
    }
  }

  // Function to repeat the current song after it ends
  void repeatCurrentSong() async {
    if (_currentSongIndex != null) {
      // Seek to the beginning of the current song
      seek(Duration.zero);
      // Play the current song again
      play();
    }
  }

//listen to the duration
  void listenToDuration() {
    //listen to the total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    //listen for current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    //listen for the song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  // Method to toggle the repeat state
  void toggleRepeatState() {
    _isRepeatActive = !_isRepeatActive;
    _isRepeatTempActive = true;
    notifyListeners();

    // Set a delay to revert the temporary color after a few seconds
    Future.delayed(const Duration(seconds: 1), () {
      _isRepeatTempActive = false;
      notifyListeners();
    });
  }

//dispose of the audio player

  /*
  G E T T E R S
  */

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;
  // Getter for the repeat icon color
  Color get repeatIconColor {
    if (_isRepeatTempActive) {
      return const Color.fromARGB(255, 0, 0, 0); // Set your temporary color
    } else {
      return _isRepeatActive ? const Color.fromARGB(255, 0, 0, 0) : Colors.grey;
    }
  }

  /*
  S E T T E R S
  */
  set currentSongIndex(int? newIndex) {
    //update current song index
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play(); //play the song at the new index
    }

    //update UI
    notifyListeners();
  }
}
