
// ignore_for_file: avoid_print

import 'package:chat_app/shared/components/attachments//save_gallery_method.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PhotoView extends StatefulWidget {
  const PhotoView({Key? key,required  this.path}) : super(key: key);
  final String path ;
  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.path)..initialize().then((_) {
      setState(() {});
    });
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
 IconData iconData = Icons.play_circle_fill_sharp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        //backgroundColor: kPrimaryColor2,
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 10,top: 5 , bottom: 5),
              onPressed: () {
                 savePhotoToGallery(
                     context:context,
                     path:widget.path
                 );
              },
              icon: const Icon(
                Icons.save_alt_sharp,
                size: 35,
                color:Colors.white,
              ),
          ),
        ],
      ),
      body:widget.path.contains("https://firebasestorage.googleapis.com/v0/b/socialapp-c4833.appspot.com/o/videos")?
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: _controller.value.isInitialized?
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height/1.5,
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller,),
                    ),
                  )
                      :
                  const CircularProgressIndicator(
                    strokeWidth:3,
                  ),
                ),
                IconButton(
                    onPressed:  () {
                        setState(() {
                          _controller.value.isPlaying? _controller.pause() : _controller.play();
                        });
                    },
                    icon: Icon(
                      _controller.value.isPlaying? Icons.pause : iconData,
                       color: Colors.white,
                      size: 42,
                    ),
                )
              ],
            ),
          )
          :
          Center(
        child: ClipRRect(
           borderRadius: BorderRadius.circular(10),
          child: Image.network(widget.path),
        ),
      )
    );
  }
}
