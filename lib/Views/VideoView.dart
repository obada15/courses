import 'dart:async';
import 'package:Courses/Bloc/SubjectBloc.dart';
import 'package:Courses/Helper/AppColors.dart';
import 'package:Courses/Views/BaseUI.dart';
import 'package:Courses/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoView extends BaseUI<SubjectBloc> {
  final String  videoUrl;
  VideoView({required this.videoUrl}) : super(bloc: SubjectBloc());

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends BaseUIState<VideoView> {

  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  @override
  AppBar buildAppBar() {
    return helper.mainAppBar(
        context,
        scaffoldKey,
        "Course",
        nameUI: "Course"
    );
  }
  @override
  Widget buildUI(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:  YoutubePlayerBuilder(
            onExitFullScreen: () {
              // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
              SystemChrome.setPreferredOrientations(DeviceOrientation.values);
            },
            player: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: AppColors.primary,
              topActions: <Widget>[
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    _controller.metadata.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  onPressed: () {
                    // log('Settings Tapped!');
                  },
                ),
              ],
              onReady: () {
                _isPlayerReady = true;
              },
              onEnded: (data) {
                //_controller
                //   .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
                _showSnackBar('Next Video Started!');
              },
            ),
            builder: (context, player) => Scaffold(
              body: ListView(
                children: [
                  player,
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
  RegExp regExp = new RegExp(
    r'.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/)|(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*',
    caseSensitive: false,
    multiLine: false,
  );
  @override
  void init() {
    final videoID = regExp.firstMatch(widget.videoUrl)!.group(1); // <- This is the fix

    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }
   void listener() {
     if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
       setState(() {
         _playerState = _controller.value.playerState;
         _videoMetaData = _controller.metadata;
       });
     }
   }

   @override
   void deactivate() {
     // Pauses video while navigating to next page.
     _controller.pause();
     super.deactivate();
   }

   @override
   void dispose() {
     _controller.dispose();
     _idController.dispose();
     _seekToController.dispose();
     super.dispose();
   }
   Widget _text(String title, String value) {
     return RichText(
       text: TextSpan(
         text: '$title : ',
         style: const TextStyle(
           color: Colors.blueAccent,
           fontWeight: FontWeight.bold,
         ),
         children: [
           TextSpan(
             text: value,
             style: const TextStyle(
               color: Colors.blueAccent,
               fontWeight: FontWeight.w300,
             ),
           ),
         ],
       ),
     );
   }

   Color _getStateColor(PlayerState state) {
     switch (state) {
       case PlayerState.unknown:
         return Colors.grey[700]!;
       case PlayerState.unStarted:
         return Colors.pink;
       case PlayerState.ended:
         return Colors.red;
       case PlayerState.playing:
         return Colors.blueAccent;
       case PlayerState.paused:
         return Colors.orange;
       case PlayerState.buffering:
         return Colors.yellow;
       case PlayerState.cued:
         return Colors.blue[900]!;
       default:
         return Colors.blue;
     }
   }

   Widget get _space => const SizedBox(height: 10);

   Widget _loadCueButton(String action) {
     return Expanded(
       child: MaterialButton(
         color: Colors.blueAccent,
         onPressed: _isPlayerReady
             ? () {
           if (_idController.text.isNotEmpty) {
             var id = YoutubePlayer.convertUrlToId(
               _idController.text,
             ) ??
                 '';
             if (action == 'LOAD') _controller.load(id);
             if (action == 'CUE') _controller.cue(id);
             FocusScope.of(context).requestFocus(FocusNode());
           } else {
             _showSnackBar('Source can\'t be empty!');
           }
         }
             : null,
         disabledColor: Colors.grey,
         disabledTextColor: Colors.black,
         child: Padding(
           padding: const EdgeInsets.symmetric(vertical: 14.0),
           child: Text(
             action,
             style: const TextStyle(
               fontSize: 18.0,
               color: Colors.white,
               fontWeight: FontWeight.w300,
             ),
             textAlign: TextAlign.center,
           ),
         ),
       ),
     );
   }

   void _showSnackBar(String message) {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
         content: Text(
           message,
           textAlign: TextAlign.center,
           style: const TextStyle(
             fontWeight: FontWeight.w300,
             fontSize: 16.0,
           ),
         ),
         backgroundColor: Colors.blueAccent,
         behavior: SnackBarBehavior.floating,
         elevation: 1.0,
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(50.0),
         ),
       ),
     );
   }
}
