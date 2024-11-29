import 'package:flutter/material.dart';
import 'package:music_player/model/playlist_provider.dart';
import 'package:music_player/screens/song_page.dart';
import 'package:provider/provider.dart';
import '../components/my_drawer.dart';
import '../model/song.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSelectedItem = false;
  late final dynamic playlistProvider;

  @override
  void initState() {
    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  void goToSong(int songIndex){
    playlistProvider.currentSongIndex = songIndex;
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SongPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text('P L A Y L I S T'),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: Consumer<PlaylistProvider>(builder: (context, value, child){
        final List<Song> playlist = value.playlist;
        return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index){
          final Song song = playlist[index];
          return ListTile(
            title: Text(song.songName),
            subtitle: Text(song.artistName),
            leading: Image.asset(song.albumArtImagePath, fit: BoxFit.fill,),
            onTap: ()=> goToSong(index),
          );
        }

        );
      }
      ),

    );
  }
}
