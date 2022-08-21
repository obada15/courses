import 'dart:async';
import 'package:Courses/Bloc/SubjectBloc.dart';
import 'package:Courses/DataStore.dart';
import 'package:Courses/Helper/AppColors.dart';
import 'package:Courses/Helper/AppTextStyle.dart';
import 'package:Courses/Helper/ThemeConstant.dart';
import 'package:Courses/Views/BaseUI.dart';
import 'package:Courses/Widget/HelperWigets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoView extends BaseUI<SubjectBloc> {
  final String  videoUrl;
  final String  description;
  VideoView({required this.videoUrl,required this.description}) : super(bloc: SubjectBloc());

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
        " ",
        nameUI: "Course"
    );
  }
  bool landscape=false;
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder:
        (BuildContext context, Orientation orientation) {
      if (orientation == Orientation.landscape) {
        landscape=true;
      } else {
        landscape=false;
      }
      return Scaffold(
        appBar: landscape?AppBar(toolbarHeight: 0,):AppBar(
          backgroundColor: AppColors.white,

          centerTitle: true,

          toolbarHeight: 60, // Set this height
          iconTheme: IconThemeData(color: AppColors.black),
          brightness: Brightness.light,
          leadingWidth: 50,
          title:helper.mainTextView(
              texts: [" "], textsStyle: [AppTextStyle.largeBlackBold]),

          leading: Transform(
            transform: Matrix4.translationValues(8, 0, 0.0),
            child: ModalRoute.of(context)?.canPop == true
                ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: AppColors.gray,
              ),

              onPressed: () {
                Navigator.of(context).pop(1);
              },
            )
                : null,
          ),
        ),

        body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    Container(
                        height:landscape?MediaQuery.of(context).size.height: MediaQuery.of(context).size.height/3,
                        width: MediaQuery.of(context).size.width,
                        child:  YoutubePlayerBuilder(
                          onExitFullScreen: () {
                            // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
                            SystemChrome.setPreferredOrientations(DeviceOrientation.values);
                          },
                          player: YoutubePlayer(
                            controller: _controller,
                            // showVideoProgressIndicator: true,
                            progressIndicatorColor: AppColors.primary,
                            progressColors: ProgressBarColors(playedColor: AppColors.primary,bufferedColor: AppColors.silver,
                                backgroundColor: AppColors.white,handleColor: AppColors.primary),
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
                            },
                          ),
                          onEnterFullScreen: (){
                            SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
                          },
                          builder: (context, player) => Scaffold(
                            body: ListView(
                              children: [
                                player,
                              ],
                            ),
                          ),
                        )
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 50,horizontal: 10),child: Text(dataStore!.user!.data!.user!.id.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: AppColors.black),),)
                  ],
                ),
                landscape?Container(height: 0,): Container(
                  margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                  child:Padding(child:
                  /*Text("مرض كورو (بالإنجليزية: kuru)‏ مرض تدريجي في الجهاز العصبي المركزي الذي هو نوع من التهاب الدماغ الإسفنجي المعدي موجود في البشر يتسم بتزايد انعدام التناسق الحركي ويصل إلى حد الشلل والوفاة في غضون سنة من ظهور الأعراض، يعتقد أنه ينتقل عن طريق آكل لحوم البشر، خاصة عندما يأكلوا الدماغ، حيث أن جسيمات البريون تتركز بشكل خاص. المرض اختفى تقريبا عندما تم التخلي عن أكل لحوم البشر. كورو مرض غير قابل للشفاء ومن اضطرابات الجهاز العصبي. ومن المعروف عن هذا الوباء انه انتشر في بابوا غينيا الجديدة في منتصف القرن العشرين، ووقت سابق.",
                      style: TextStyle(color: AppColors.primary,fontSize: 20,),textAlign: TextAlign.end,)*/
                  Text(widget.description,
                    style: TextStyle(color: AppColors.primary,fontSize: 20,),textAlign: TextAlign.end,)

                    ,padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),),

                ),
              ],
            )

        ),
      );
    });
  }
  RegExp regExp = new RegExp(
    r'.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/)|(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*',
    caseSensitive: false,
    multiLine: false,
  );
  @override
  void init() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoUrl!,
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

  @override
  Widget buildUI(BuildContext context) {
    // TODO: implement buildUI
    throw UnimplementedError();
  }
}
