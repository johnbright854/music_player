import 'package:flutter/material.dart';
import 'package:music_player/model/playlist_provider.dart';
import 'package:provider/provider.dart';
import '../components/nue_box.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  // bool isActiveShuffle = false;

  String formatTime(Duration duration){
    String twoDigitSeconds = duration.inSeconds.remainder(60).toString().padLeft(2,'0');
    String formattedTime = "${duration.inMinutes}:${twoDigitSeconds}";

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(builder: (context, value, child){
      final playlist = value.activeSong();
      final currentSong = playlist[value.currentSongIndex ?? 0];

      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: ()=>
                          Navigator.pop(context),
                          icon: Icon(Icons.arrow_back)),
                      Text('P L A Y L I S T'),
                      Icon(Icons.menu)
                    ],
                  ),
                  SizedBox(height: 20,),
                  NueBox(
                      child: Column(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(currentSong.albumArtImagePath)),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(currentSong.songName, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
                                  Text(currentSong.artistName,style: TextStyle(fontSize: 15),)
                                ],
                              ),
                              Icon(Icons.favorite, color: Colors.red,)
                            ],
                          ),
                        ],
                      )),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(formatTime(value.currentDuration)),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    Provider.of<PlaylistProvider>(context, listen: false).toggleShuffle();
                                  });
                                },
                              icon: Icon(Icons.shuffle),
                              color: value.isActiveShuffle ? Colors.orange : Colors.black,),
                            Text('Shuffle', style: TextStyle(fontSize: 10),)
                          ],

                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: (){
                                setState(() {
                                  Provider.of<PlaylistProvider>(context, listen: false).toggleRepeat();                            });
                              },
                              icon: Icon(Icons.repeat, color: value.isRepeatMode ? Colors.orange : Colors.black,)),
                          Text('Repeat', style: TextStyle(fontSize: 10),)
                          ],
                        ),
                        Text(formatTime(value.totalDuration))
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0)
                    ),
                    child: Slider(
                        min: 0,
                        max: value.totalDuration.inSeconds.toDouble(),
                        activeColor: Colors.green,
                        value: value.currentDuration.inSeconds.toDouble(),
                        onChanged: (double double) {

                        },
                        onChangeEnd: (double double){
                          value.seek(Duration(seconds: double.toInt()));
                        },
                        ),

                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: NueBox(child:
                        GestureDetector(
                            onTap: value.playPreviousSong,
                            child: Icon(Icons.skip_previous))),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        flex: 2,
                        child: NueBox(child:
                        GestureDetector(
                            onTap: value.pauseOrResume,
                            child: Icon(value.isPlaying ? Icons.pause : Icons.play_arrow))),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: NueBox(child:
                        GestureDetector(
                            onTap: value.playNextSong,
                            child: Icon(Icons.skip_next))),
                      ),


                    ],)
                ]
            ),
          ),
        ),
      );
      }
      );
    }

  }

