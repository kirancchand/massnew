import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:massnew/Api/api.dart';
import 'package:massnew/Models/pdfAndVideoModel.dart';
import 'package:video_player/video_player.dart';

class StudyMaterialVid extends StatefulWidget {
  StudyMaterialVid({this.cid, this.desc});
  String cid;
  String desc;
  @override
  _StudyMaterialVidState createState() => _StudyMaterialVidState();
}

class _StudyMaterialVidState extends State<StudyMaterialVid> {
  // GlobalKey<ScaffoldState> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // key: key,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Image.asset(
            "assets/images/massco.png",
            height: 70,
            width: 180,
          ),
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder<PdfAndVideoClass>(
          future: pdfAndVideoApi(cid: widget.cid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        (snapshot
                                .data.data.viewPdfAndVideos.moduleVideo.isEmpty)
                            ? Container(
                                child: Text(
                                  'No Videos File Exist',
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Container(
                                  color: Color(0xff026a36),
                                  height: 200,
                                  width: 400,
                                  child: ChewieListItem(
                                    looping: false,
                                    videoPlayerController:
                                        VideoPlayerController.network(
                                      "https://www.masshseconsultant.com/admin/uploads/" +
                                          snapshot.data.data.viewPdfAndVideos
                                              .moduleVideo,
                                    ),
                                  ),
                                ),
                              ),
                        // Videoplayer(
                        //     link: snapshot
                        //         .data.data.viewPdfAndVideos.moduleVideo,
                        //   ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text(
                              snapshot.data.data.viewPdfAndVideos.moduleName ??
                                  "",
                              style: TextStyle(
                                  color: Color(0xff026a36),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            // Icon(
                            //   Icons.videocam,
                            //   color: Colors.grey,
                            // ),
                            // Text(
                            //   "  3 hours",
                            //   style: TextStyle(
                            //       color: Colors.grey,
                            //       fontWeight: FontWeight.bold),
                            // ),
                            // SizedBox(
                            //   width: 30,
                            // )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Description',
                                style: TextStyle(
                                    color: Color(0xff6c70e9),
                                    fontWeight: FontWeight.bold))),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          widget.desc ?? '',
                          style: TextStyle(color: Colors.grey, height: 1.7),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        // Align(
                        //     alignment: Alignment.centerLeft,
                        //     child: Text('Next study material videos',
                        //         style: TextStyle(
                        //             fontSize: 20,
                        //             color: Color(0xff6c70e9),
                        //             fontWeight: FontWeight.bold))),
                        // Divider(
                        //   thickness: 2,
                        //   color: Color(0xff6c70e9),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.only(top: 5),
                        //   child: SingleChildScrollView(
                        //     child: Wrap(
                        //       children: snapshot.data.data.relatedPdfAndVideos
                        //           .map((e) => VideoWidget(
                        //                 data: e,
                        //               ))
                        //           .toList(),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            } else
              return Container();
          },
        ));
  }
}

// class Videoplayer extends StatelessWidget {
//   Videoplayer({Key key, this.link});
//   String link;
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(25),
//       child: Container(
//         height: 260,
//         width: 400,
//         // child: Image.asset(
//         //   "assets/images/video_thumb.png",
//         //   fit: BoxFit.fill,
//         // ),
//         child: VideosPlayer(
//           maxVideoPlayerHeight: 250,
//           networkVideos: [
//             NetworkVideo(
//                 id: "2",
//                 name: "Elephant Dream",
//                 videoUrl:
//                     "https://www.masshseconsultant.com/admin/uploads/" + link ??
//                         "",
//                 // 'https://www.masshseconsultant.com/admin/uploads/9b87156a6aa68b4b74ce1bb2310eb7cb.mp4',
//                 // "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
//                 // thumbnailUrl:
//                 // "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg",
//                 videoControl: NetworkVideoControl(
//                   fullScreenByDefault: false,
//                   // deviceOrientationsAfterFullScreen: [
//                   //   DeviceOrientation.landscapeRight,
//                   //   DeviceOrientation.landscapeLeft,
//                   //   DeviceOrientation.portraitUp,
//                   //   DeviceOrientation.portraitDown,
//                   // ],
//                 )),
//           ],
//           playlistStyle: Style.Style2,
//         ),
//       ),
//     );
//   }
// }
class ChewieListItem extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;

  ChewieListItem({
    @required this.videoPlayerController,
    this.looping,
    Key key,
  }) : super(key: key);

  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    // Wrapper on top of the videoPlayerController
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 18 / 9,
      // Prepare the video to be played and display the first frame
      autoInitialize: true,
      looping: widget.looping,
      // Errors can occur for example when trying to play a video
      // from a non-existent URL
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // IMPORTANT to dispose of all the used resources
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
