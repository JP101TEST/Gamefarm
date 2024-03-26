import 'package:audioplayers/audioplayers.dart';

my_sound background = new my_sound.start();

class my_sound {
  late AudioPlayer my_player;
  
  my_sound.start() {
    my_player = AudioPlayer();
  }

  //เล่นเสียงตามที่กำหนด
  Future<void> play_sound(String sound_source) async {
    my_player.play(AssetSource(sound_source));
  }

  //หยุดเล่นเสียง
  Future<void> stop_sound() async {
    my_player.stop();
  }
}
