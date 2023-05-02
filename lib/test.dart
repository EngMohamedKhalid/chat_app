import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:chat_app/models/take_photo.dart';
import 'package:chat_app/shared/components/attachments/save_attach_message_service.dart';
import 'package:chat_app/shared/network/remote/fire_store/message_store_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    initRecorder();
    super.initState();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  final recorder = FlutterSoundRecorder();
  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Permission not granted';
    }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future startRecord() async {
    await recorder.startRecorder(
        toFile: "audi",
    );
  }

  Future stopRecorder() async {
    final filePath = await recorder.stopRecorder();
    File file = File(filePath!);
    //print('Recorded file path: $filePath');
    var name = basename(filePath);
    var refStorage= FirebaseStorage.instance.ref("records/$name.acc");
    await refStorage.putFile(file);
    var url = await refStorage.getDownloadURL();

    print(url);
  }
  // error initializing ADB:Android Debug Bridge not found
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  Center(
          child :TextButton(
              onPressed: () async{
                if (recorder.isRecording) {
                  await stopRecorder();
                  setState(() {});
                } else {
                  await startRecord();
                  setState(() {});
                }
              } ,
              child:recorder.isRecording? const Text("stop") : const Text("recored")
          )
      ),
    );
  }
}
