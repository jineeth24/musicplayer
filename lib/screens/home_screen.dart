import 'package:flutter/material.dart';
import 'package:musicp/models/play_list_provider.dart';
import 'package:musicp/models/song.dart';
import 'package:musicp/screens/settings_screen.dart';
import 'package:musicp/screens/song_screen.dart';
import 'package:musicp/themes/dark_mode.dart';
import 'package:musicp/themes/theme_provider.dart';
import 'package:provider/provider.dart';

import '../widget/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late final dynamic playlistProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playlistProvider=Provider.of<PlaylistProvider>(context,listen: false);
  }
  void goToSong(int songIndex){
    playlistProvider.currentSongIndex=songIndex;
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SongScreen()));
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("P L A Y L I S T"),
      ),
      drawer: CustomDrawer(),
      body: Consumer<PlaylistProvider>(builder: (context, value, child) {
        List<Song> playList = value.playlist;
        return ListView.builder(
            itemCount: playList.length,
            itemBuilder: (context, index) {
              final Song song = playList[index];
              return SizedBox(
                // height: 100,
                // width: 300,
                child: ListTile(
                  onTap: (){goToSong(index);},
                  title: Text(song.songName),
                  subtitle: Text(song.artistName),
                  leading: SizedBox(
                    width: 50,
                    height:60 ,
                      child: Image.asset(
                    song.imagePath,
                    fit: BoxFit.cover,
                  )),
       
                ),
              );
            });
      }),
    );
  }
}
