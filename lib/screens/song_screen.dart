import 'package:flutter/material.dart';
import 'package:musicp/models/play_list_provider.dart';
import 'package:musicp/widget/neu_box.dart';
import 'package:provider/provider.dart';

class SongScreen extends StatelessWidget {
  const SongScreen({super.key});

  //method to convert duration to MIN:sec
  String formatTime(Duration duration){
    String twoDigitSecond=duration.inSeconds.remainder(60).toString().padLeft(2,"0");
    String formattedTime="${duration.inMinutes}:$twoDigitSecond";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
       //get playlist
       final playlist=value.playlist;


       //get currentsong index
       final currentsong=playlist[value.currentSongIndex?? 0];


        //return scaffold
        return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //appbar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //back button
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        }, icon: const Icon(Icons.arrow_back)),

                    //title
                    const Text(" PLAYLIST"),

                    //menubutton
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.menu),
                    )
                  ],
                ),
                SizedBox(height: 50,),

                //songimage
                NeuBox(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                            width: 320,
                          height: 350,
                          child: Image.asset(
                           currentsong.imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      //song and artist
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //SizedBox(width: 0,),
                           Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //sng name
                              Text(
                                currentsong.songName,
                                style:const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              //artist name
                              Text(currentsong.artistName),
                            ],
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              const  SizedBox(
                  height: 25,
                ),

                //song duration
                Column(
                  children: [
                     Padding(
                      padding:const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       
                        children: [
                           //start time
                           Text(formatTime(value.currentDuration)),
                          //repeat icon
                        const  Icon(Icons.repeat),

                          //shuffle icon
                        const  Icon(Icons.shuffle),

                          //end time
                          Text(formatTime(value.totatDuration)),
                        ],
                      ),
                    ),
                    //progress
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 0)),
                      child: Slider(
                        min: 0,
                        max: value.totatDuration.inSeconds.toDouble(),
                        value: value.currentDuration.inSeconds.toDouble(),
                        activeColor: Colors.green,
                        onChanged: (double double) {
                          //during when user slides the slider

                        },
                        onChangeEnd: (double double){
                          //after finishing sliding seek the current duraiton
                          value.seek(Duration(seconds: double.toInt()));
                        },
                      ),
                    ),
                  ],
                ),

                //playback controllers
                Row(
                  children: [
                    //skip previous
                    Expanded(
                      child: GestureDetector(
                        onTap: value.previousSong,
                        child:const NeuBox(
                          child: Icon(Icons.skip_previous),
                        ),
                      ),
                    ),
                  const  SizedBox(width: 20,),
                     //play pause
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap:value.pauseOrResume,
                        child: NeuBox(
                          child: Icon(value.isPlaying?Icons.pause:Icons.play_arrow),
                        ),
                      ),
                    ),
                      const  SizedBox(width: 20,),
                    // skip forward
                     Expanded(
                      child: GestureDetector(
                        onTap: value.playNextSong,
                        child:const NeuBox(
                          child: Icon(Icons.skip_next),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
      }
    );
  }
}
