import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/model/song.dart';

class PlaylistProvider extends ChangeNotifier{
  final List<Song> _playlist = [
    Song(
        songName: 'Inspirational uplifting',
        audioPath: 'audio/inspirational-uplifting-calm-piano-254764.mp3',
        albumArtImagePath: 'assets/images/abstract-minimalist.avif',
        artistName: 'Love'
    ),
    Song(
        songName: 'Subway Mirage',
        audioPath: 'audio/subway-mirage-261477.mp3',
        albumArtImagePath: 'assets/images/gradient-album-cover-template_23-2150597431.avif',
        artistName: 'Desert'
    ),
    Song(
        songName: 'Deep Electronic',
        audioPath: 'audio/stylish-deep-electronic-262632.mp3',
        albumArtImagePath: 'assets/images/minimalist-dj.avif',
        artistName: 'Spirit'
    ),
    Song(
        songName: 'Cinematic rythmline',
        audioPath: 'audio/cinematic-rythmline.mp3',
        albumArtImagePath: 'assets/images/gradient-album-cover-template_23-2150597431.avif',
        artistName: 'Samuel F Johanns'
    )
  ];
  final List<Song> shuffledSongs = [];
  bool isActiveShuffle = false;
  bool isRepeatMode = false;
  int? _currentSongIndex;

  // audio player
  final AudioPlayer _audioplayer = AudioPlayer();
  // durations
  Duration _totalDuration = Duration.zero;
  Duration _currentDuration = Duration.zero;
  // constructor
  PlaylistProvider(){
    listenToDuration();
  }

  // initially not playing
  bool _isPlaying = false;

void toggleShuffle(){
  isActiveShuffle = !isActiveShuffle;
  if(isActiveShuffle){
    shuffledSongs.clear();
    shuffledSongs.addAll(_playlist);
    shuffledSongs.shuffle();
    print(shuffledSongs.map((Song)=>Song.songName).toList());
  }else{
    shuffledSongs.clear();
  }
  notifyListeners();
}

void toggleRepeat() {
  isRepeatMode = !isRepeatMode;
  notifyListeners();
}

List<Song> activeSong(){
  final activePlaylist = isActiveShuffle ? shuffledSongs : _playlist;
  return activePlaylist;
}
  // play the song
  void play({required bool isActiveShuffle}) async{
    final activePlaylist = isActiveShuffle ? shuffledSongs : _playlist;
    if(currentSongIndex != null){
      final String path = activePlaylist[_currentSongIndex!].audioPath;
      print('My Path: $path');
      await _audioplayer.stop();
      await _audioplayer.play(AssetSource(path));
      _isPlaying = true;
      notifyListeners();
    }
  }
  // pause current song
  void pause() async{
    await _audioplayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // resume playing
  void resume() async{
    await _audioplayer.resume();
    _isPlaying = true;
    notifyListeners();
  }
  // pause or resume
  void pauseOrResume() async{
    if(_isPlaying){
      pause();
    }else{
      resume();
    }
    notifyListeners();
  }

  // seek to a specific position in the current song
  void seek(Duration position) async{
    await _audioplayer.seek(position);
  }
  // play next song
  void playNextSong(){
  final activePlaylist = isActiveShuffle ? shuffledSongs : _playlist;
    if(_currentSongIndex != null){
      if(_currentSongIndex! < activePlaylist.length -1 ){
        currentSongIndex = _currentSongIndex! + 1;
      }else{
        currentSongIndex = 0;
      }
    }
  }
  // play previous song
  void playPreviousSong() {
    final activePlaylist = isActiveShuffle ? shuffledSongs : _playlist;
    if (_currentDuration.inSeconds > 2) {
        seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      }else{
        currentSongIndex = activePlaylist.length - 1;
      }
    }
  }
  // listen to duration
  void listenToDuration(){
    //listen for total duration
    _audioplayer.onDurationChanged.listen((newDuration){
      _totalDuration = newDuration;
      notifyListeners();
    });
    //listen for current duration

    _audioplayer.onPositionChanged.listen((newPosition){
      _currentDuration = newPosition;
      notifyListeners();
    });
    //listen for song completion
    _audioplayer.onPlayerComplete.listen((event)async{
      if(isRepeatMode){
        final activePlaylist = isActiveShuffle ? shuffledSongs : _playlist;
        final String path = activePlaylist[_currentSongIndex!].audioPath;
        await _audioplayer.play(AssetSource(path));
      }
      else{
        playNextSong();
      }
      notifyListeners();
    });
  }
  // dispose of audio player
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  set currentSongIndex(int? songIndex){
    _currentSongIndex = songIndex;
    if(songIndex != null){
      play(isActiveShuffle: isActiveShuffle);
    }
    notifyListeners();
  }
}