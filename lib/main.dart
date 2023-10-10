import 'dart:html';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homescreen(),
    );
    }
    }
    class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  final recorder = FlutterSoundRecorder();
  @override
  void initState(){
    initRecorder();
    super.initState();
  }
  initRecorder()async{
   final State =await Permission.microphone.request();
   if (State != PermissionStatus.granted) {
    throw 'Permission not granted';

     
   }

    recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(seconds: 200));

  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              if (recorder.isRecording) {
                recorder.stopRecorder();
                setState(() {});
              }else {
              recorder.startRecorder(toFile: 'aduio');
              setState(() {});
              }
            }, 
            child:recorder.isRecording? Icon(Icons.stop) :
             Icon(Icons.play_arrow)),
            
             ElevatedButton(onPressed: (){}, child: Icon(Icons.music_note)),
          ],
        ),
      ),
    );
  }
}