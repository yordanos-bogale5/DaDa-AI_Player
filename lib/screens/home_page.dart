// ignore_for_file: avoid_print

import 'package:alan_voice/alan_voice.dart';
import 'package:app_directory/main_model/music.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<MyMusic> musics = [];
  late MyMusic _selectedMusic = MyMusic(
    id: 1,
    order: 1,
    name: '',
    tagline: '',
    color: '',
    desc: '',
    url: '',
    category: '',
    icon: '',
    image: '',
    lang: '',
  );
  late Color _selectedColor = Colors.blue;
  bool _isPlaying = false;

  final AudioPlayer _audioPlayer = AudioPlayer();
  static const String alanKey = "<Enter your key here>";

  

@override
void initState() {
  super.initState();
  setupAlan();
  fetchMusics();

  _audioPlayer.onPlayerStateChanged.listen((playerState) {
    if (playerState == PlayerState.playing) {
      _isPlaying = true;
    } else {
      _isPlaying = false;
    }
    setState(() {});
  });
}



  setupAlan() {
    AlanVoice.addButton(alanKey, buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT);
    AlanVoice.callbacks.add((command) => _handleCommand(command.data));
  }

  _handleCommand(Map<String, dynamic> response) {
    switch (response["command"]) {
      case "play":
        _playMusic(_selectedMusic.url);
        break;

      case "play_channel":
        final id = response["id"];
        MyMusic newMusic = musics.firstWhere(
          (element) => element.id == id,
          orElse: () => MyMusic(
            id: 1,
            order: 1,
            name: '',
            tagline: '',
            color: '',
            desc: '',
            url: '',
            category: '',
            icon: '',
            image: '',
            lang: '',
          ),
        );
        musics.remove(newMusic);
        musics.insert(0, newMusic);
        _playMusic(newMusic.url);
        break;

      case "stop":
        _audioPlayer.stop();
        break;

      case "next":
        final index = _selectedMusic.id;
        MyMusic newMusic = _getNextMusic(index);
        _playMusic(newMusic.url);
        break;

      case "prev":
        final index = _selectedMusic.id;
        MyMusic newMusic = _getPreviousMusic(index);
        _playMusic(newMusic.url);
        break;

      default:
        print("Command was ${response["command"]}");
        break;
    }
  }

  MyMusic _getNextMusic(int currentIndex) {
    return currentIndex + 1 >= musics.length
        ? musics.firstWhere(
            (element) => element.id == 1,
            orElse: () => MyMusic(
              id: 1,
              order: 1,
              name: '',
              tagline: '',
              color: '',
              desc: '',
              url: '',
              category: '',
              icon: '',
              image: '',
              lang: '',
            ),
          )
        : musics.firstWhere(
            (element) => element.id == currentIndex + 1,
            orElse: () => MyMusic(
              id: 1,
              order: 1,
              name: '',
              tagline: '',
              color: '',
              desc: '',
              url: '',
              category: '',
              icon: '',
              image: '',
              lang: '',
            ),
          );
  }

  MyMusic _getPreviousMusic(int currentIndex) {
    return currentIndex - 1 <= 0
        ? musics.firstWhere(
            (element) => element.id == 1,
            orElse: () => MyMusic(
              id: 1,
              order: 1,
              name: '',
              tagline: '',
              color: '',
              desc: '',
              url: '',
              category: '',
              icon: '',
              image: '',
              lang: '',
            ),
          )
        : musics.firstWhere(
            (element) => element.id == currentIndex - 1,
            orElse: () => MyMusic(
              id: 1,
              order: 1,
              name: '',
              tagline: '',
              color: '',
              desc: '',
              url: '',
              category: '',
              icon: '',
              image: '',
              lang: '',
            ),
          );
  }

  fetchMusics() async {
    try {
      final musicJson = await rootBundle.loadString("assets/music.json");
      musics = MyMusicList.fromJson(musicJson).musics;
      _selectedMusic = musics.isNotEmpty
          ? musics[0]
          : MyMusic(
              id: 1,
              order: 1,
              name: '',
              tagline: '',
              color: '',
              desc: '',
              url: '',
              category: '',
              icon: '',
              image: '',
              lang: '',
            );
      _selectedColor =
          Color(int.tryParse(_selectedMusic.color) ?? Colors.blue.value);
      setState(() {});
    } catch (e) {
      print("Error loading music data: $e");
    }
  }

  _playMusic(String url) {
    _audioPlayer.play(url as Source);
    _selectedMusic = musics.firstWhere(
      (element) => element.url == url,
      orElse: () => MyMusic(
        id: 1,
        order: 1,
        name: '',
        tagline: '',
        color: '',
        desc: '',
        url: '',
        category: '',
        icon: '',
        image: '',
        lang: '',
      ),
    );
    print(_selectedMusic.name);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Music Player"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _selectedMusic.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          CircleAvatar(
            radius: 80,
            backgroundColor: _selectedColor,
            backgroundImage: NetworkImage(_selectedMusic.image),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous),
                onPressed: () => _handleCommand({"command": "prev"}),
              ),
              IconButton(
                icon: _isPlaying ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
                onPressed: () {
                  if (_isPlaying) {
                    _handleCommand({"command": "stop"});
                  } else {
                    _handleCommand({"command": "play"});
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.skip_next),
                onPressed: () => _handleCommand({"command": "next"}),
              ),
            ],
          ),
        ],
      ),
    );
  }
}