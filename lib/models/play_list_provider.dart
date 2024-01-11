import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:musicp/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
//play list of songs
  final List<Song> _playlist = [
    Song(
        songName: "Slim shady",
        artistName: "Eminem",
        imagePath: "assets/images/image1.jpeg",
        audioPath: "audio/song1.mp3"),
        //song2
         Song(
        songName: "love ",
        artistName: "Eminem",
        imagePath: "assets/images/image2.jpeg",
        audioPath: "audio/song1.mp3"),
        //song3

         Song(
        songName: "Candy shop",
        artistName: "50 cent",
        imagePath: "assets/images/image3.jpeg",
        audioPath: "audio/song1.mp3"),
  ];

 int? _currentSongIndex; 
/*
audio player
*/
//audio player
final AudioPlayer _audioPlayer=AudioPlayer();

//durations
Duration _currentDuration= Duration.zero;
Duration _totalDuration= Duration.zero;
//constructor
PlaylistProvider(){
  listenToDuration();
}

//initially not playing
bool _isPlaying =false;

//play the song
void play() async{
  final String path=_playlist[_currentSongIndex!].audioPath;
  await _audioPlayer.stop();
  await _audioPlayer.play(AssetSource(path));
  _isPlaying=true;
  notifyListeners();
}

//pause current song
void pause()async{
  await _audioPlayer.pause();
  _isPlaying=false;
  notifyListeners();
}

//resume play
void resume()async{
  await _audioPlayer.resume();
  _isPlaying=true;
  notifyListeners();
}
//pause or resume
void pauseOrResume()async{
  if(_isPlaying){
    pause();
  }
  else{
    resume();
  }
  notifyListeners();
}

//seek
void seek(Duration position)async{
  await _audioPlayer.seek(position);
}

//play next
void playNextSong(){
  if(_currentSongIndex!=null){
    if(_currentSongIndex!<_playlist.length-1){
        //goto next if its not last
        currentSongIndex=_currentSongIndex!+1;
    }else{
      currentSongIndex=0;
    }
  }

}

//play previous
void previousSong()async{
//if duration>2seconds ,restart song
if(_currentDuration.inSeconds>2){
seek(Duration.zero);
}
//if within 2seconds
else if(_currentSongIndex!>0){
  currentSongIndex=_currentSongIndex!-1;
}
else{
  //if its first song,loop to last
  currentSongIndex=_playlist.length-1;
}
}

//listen to duration
void listenToDuration(){
  //listen to total duration
  _audioPlayer.onDurationChanged.listen((newDuration) {
    _totalDuration=newDuration;
    notifyListeners();
  });
  //listen for current duration
  _audioPlayer.onPositionChanged.listen((newPostion) {
    _currentDuration=newPostion;
    notifyListeners();
  });
  //listen to song complete
  _audioPlayer.onPlayerComplete.listen((event) { 
    playNextSong();
  });
}

//dispose audio player





/*
getter
*/
  List<Song> get playlist => _playlist;

  int? get currentSongIndex=>_currentSongIndex;

  bool get isPlaying=>_isPlaying;
  Duration get currentDuration=>_currentDuration;
  Duration get totatDuration=>_totalDuration;


  /*
  setter
  */
 set currentSongIndex(int? newCurrentIndex){
  //update index
  _currentSongIndex=newCurrentIndex;

  if(newCurrentIndex!=null){
    play();//play the new song
  }

  notifyListeners();
}
}
