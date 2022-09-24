import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:massnew/Api/api.dart';
import 'package:massnew/Models/BannerModel.dart';
import 'package:massnew/Models/MyCourseViewModel.dart';
import 'package:massnew/Models/fullCourseViewModel.dart';
import 'package:massnew/Screens/questionare.dart';
import 'package:massnew/Screens/study_Materialpdf.dart';
import 'package:massnew/Screens/study_material_vid.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen();
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  GlobalKey<ScaffoldState> homekey = GlobalKey();

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, 
      key: homekey,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 140,
          width: MediaQuery.of(context).size.height - 16,
          // margin: EdgeInsets.symmetric(horizontal: 8),
          margin: EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 5.0),

          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              FutureBuilder<HomeBannerModel>(
                future: bannerApi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 195,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/homeimage.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Landing(
                          slides: snapshot.data.data.sliderApi,
                        ),
                      ),
                    );
                  } else
                    return Container(
                      height: 190,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                },
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height - 350,
                width: MediaQuery.of(context).size.width - 20,
                child: DefaultTabController(
                  length: 4,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      TabBar(
                        indicator: ShapeDecoration(
                          color: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        indicatorColor: Colors.transparent,
                        labelPadding: EdgeInsets.symmetric(horizontal: 3),
                        labelColor: Colors.black,
                        unselectedLabelColor: Color(0xff026a37),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        controller: tabController,
                        onTap: (int value) {},
                        tabs: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Text('Course'),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 7),
                            child: Text(
                              'My Courses',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 7),
                            child: Text('Exam'),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 7),
                            child: Text('Project'),
                          ),
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height - 400,

                        child: TabBarView(
                          physics: BouncingScrollPhysics(),
                          controller: tabController,
                          children: [
                            TabCourse(),
                            TabMyCourses(),
                            ExamPart(),
                            ProjectPart()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
       floatingActionButton: FloatingActionButton(
        onPressed: () {
          openwhatsapp();
        },
        backgroundColor: Colors.green,
        // child: const Icon(Icons.whatsapp),
        child:new Image.asset(
                        "assets/images/whatsapp.png",
                        fit: BoxFit.fitWidth,
                      )
      ),
    );
  }
}

void openwhatsapp() async{
      // var whatsapp ="+96569616316";
      var whatsapp ="+96569616316";
      var message="hai";
      // var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=hello";
      var whatsappURl_android = "whatsapp://send?phone="+whatsapp;
      var whatappURL_ios ="https://wa.me/${whatsapp}";
      // var whatappURL_ios ="https://wa.me/${whatsapp}?text=${Uri.parse("hello")}";
      // return "https://wa.me/$whatsapp/?text=${Uri.parse(message)}"; // new line
      //  await launch(whatsappURl_android);
       


      if(Platform.isIOS){
        // for iOS phone only
        if( await canLaunch(whatappURL_ios)){
          await launch(whatappURL_ios, forceSafariVC: false);
        }else{
          Fluttertoast.showToast(msg: "Whatsapp not installed");
        }

      }else{
        // android , web
        // if( await canLaunch(whatsappURl_android)){
        //   await launch(whatsappURl_android);
        // }else{
        //   Fluttertoast.showToast(msg: "Whatsapp not installed");
        // }
        await launch(whatsappURl_android);

      }

}

class ProjectPart extends StatefulWidget {
  const ProjectPart();

  @override
  _ProjectPartState createState() => _ProjectPartState();
}

class _ProjectPartState extends State<ProjectPart> {
  GlobalKey<ScaffoldState> homekey = GlobalKey();
  bool spin = false;
  FilePickerResult resultpdf;
  List _pdf = null;
  List<String> filename = [];

  Future getPdf() async {
    resultpdf = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['pdf', 'doc'],
    );
    return resultpdf.files;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MyCourseViewClass>(
        future: myCourseViewApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              key: homekey,
              body: ModalProgressHUD(
                inAsyncCall: spin,
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data.data.studentCourseView.length,
                        // shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: CircleAvatar(
                                    radius: 25,
                                    // backgroundColor: Colors.red,
                                    backgroundImage: NetworkImage(
                                      'https://www.masshseconsultant.com/admin/uploads/' +
                                              snapshot
                                                  .data
                                                  .data
                                                  .studentCourseView[index]
                                                  .coursePic ??
                                          '',
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot
                                                .data
                                                .data
                                                .studentCourseView[index]
                                                .course ??
                                            '',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            height: 25,
                                            decoration: BoxDecoration(
                                              color: Color(0xff026a37),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: MaterialButton(
                                                onPressed: () async {
                                                  var d = await getPdf();
                                                  setState(() {
                                                    _pdf = d;
                                                  });

                                                  print(d);
                                                  if (_pdf != null) {
                                                    setState(() {
                                                      spin = true;
                                                    });
                                                    String message = await uploadFile(
                                                        file: _pdf,
                                                        pname: snapshot
                                                            .data
                                                            .data
                                                            .studentCourseView[
                                                                index]
                                                            .course,
                                                        pcourse: snapshot
                                                            .data
                                                            .data
                                                            .studentCourseView[
                                                                index]
                                                            .id);
                                                    print(message);
                                                    setState(() {
                                                      spin = false;
                                                    });
                                                    if (message == '200') {
                                                      homekey.currentState
                                                          .showSnackBar(SnackBar(
                                                              backgroundColor:
                                                                  Color(
                                                                      0xff026a37),
                                                              content: Text(
                                                                  'Successfully uploaded')));
                                                      setState(() {
                                                        _pdf = null;
                                                      });
                                                    } else {
                                                      homekey.currentState
                                                          .showSnackBar(SnackBar(
                                                              backgroundColor:
                                                                  Color(
                                                                      0xff026a37),
                                                              content: Text(
                                                                  'Unable to upload ')));
                                                    }
                                                  } else {
                                                    homekey.currentState
                                                        .showSnackBar(SnackBar(
                                                            backgroundColor:
                                                                Color(
                                                                    0xff026a37),
                                                            content: Text(
                                                                'upload the file first')));
                                                  }
                                                },
                                                child: Text(
                                                  'UPLOAD',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                  ),
                                                )),
                                          ),
                                          // Container(
                                          //   height: 25,
                                          //   decoration: BoxDecoration(
                                          //     color: Color(0xff026a37),
                                          //     borderRadius:
                                          //         BorderRadius.circular(5),
                                          //   ),
                                          //   child: MaterialButton(
                                          //     onPressed: () async {

                                          //     },
                                          //     child: Text(
                                          //       'SUBMIT',
                                          //       style: TextStyle(
                                          //         fontSize: 13,
                                          //         color: Colors.white,
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        }),
                  ),
                ),
              ),
            );
          } else
            return Container();
        });
  }
}

class TabMyCourses extends StatelessWidget {
  TabMyCourses();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MyCourseViewClass>(
        future: myCourseViewApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data.data.studentCourseView.length,
                    // shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: (snapshot.data.data.studentCourseView[index]
                                    .coursePic.isEmpty)
                                ? Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    color: Colors.green,
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.green,
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: CircleAvatar(
                                      radius: 25,
                                      // backgroundColor: Colors.red,
                                      backgroundImage: NetworkImage(
                                        'https://www.masshseconsultant.com/admin/uploads/' +
                                                snapshot
                                                    .data
                                                    .data
                                                    .studentCourseView[index]
                                                    .coursePic ??
                                            '',
                                      ),
                                    ),
                                  ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data.data.studentCourseView[index]
                                            .course ??
                                        '',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height: 25,
                                        decoration: BoxDecoration(
                                            color: Color(0xff026a37),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: MaterialButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      StudyMaterialPdf(
                                                    cid: snapshot
                                                            .data
                                                            .data
                                                            .studentCourseView[
                                                                index]
                                                            .id ??
                                                        '',
                                                    desc: snapshot
                                                            .data
                                                            .data
                                                            .studentCourseView[
                                                                index]
                                                            .courseDesc ??
                                                        "",
                                                  ),
                                                ));
                                          },
                                          child: Text(
                                            'View PDF',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: Color(0xff026a37),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: MaterialButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        StudyMaterialVid(
                                                          desc: snapshot
                                                                  .data
                                                                  .data
                                                                  .studentCourseView[
                                                                      index]
                                                                  .courseDesc ??
                                                              '',
                                                          cid: snapshot
                                                                  .data
                                                                  .data
                                                                  .studentCourseView[
                                                                      index]
                                                                  .id ??
                                                              '',
                                                        )));
                                          },
                                          child: Text(
                                            'View Videos',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    }),
              ),
            );
          } else
            return Container();
        });
  }
}

class TabCourse extends StatelessWidget {
  TabCourse();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FullCourseViewClass>(
      future: fullCourseViewApi(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: EdgeInsets.only(top: 5),
            child: SingleChildScrollView(
              child: Wrap(
                children: snapshot.data.data.details
                    .map((e) => CourseWid(data: e))
                    .toList(),
              ),
            ),
          );
        } else
          return Container(
              child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff026a37)),
            ),
          ));
      },
    );
  }
}

class CourseWid extends StatelessWidget {
  CourseWid({this.data});
  Detail data;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 260,
       margin: EdgeInsets.symmetric(vertical: 8),
      width: (MediaQuery.of(context).size.width / 2) - 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (data.coursePic.isNotEmpty)
              ? Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(
                            // (data.coursePic.isNotEmpty)
                            //   ?
                            'https://www.masshseconsultant.com/admin/uploads/' +
                                    data.coursePic ??
                                ''
                            // : 'https://www.masshseconsultant.com/admin/uploads/11f8835ff2e8fcc9520327b0ffc3d19a.jpg'
                            ),
                        fit: BoxFit.cover),
                  ),
                )
              : Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.only(left: 6),
            child: Text(
              '${data.course}' ?? '',
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.only(left: 6),
            child: Text(
              data.catname ?? "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Landing extends StatefulWidget {
  Landing({this.slides, this.link});
  List<SliderApi> slides;
  String link;
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int _currentPage = 0;
  PageController _controller = PageController();

  List<Widget> _pages = [];
  _onchanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void initState() {
    super.initState();
    addtoList();
  }

  addtoList() {
    for (int i = 0; i < widget.slides.length; i++) {
      print( widget.slides[i].slideImage);
      var parts;
      // var parts = widget.slides[i].slideImage.split('.')[1].trim();
      // print("sdddddddddddddddddddddsddsdds"+parts);
      (widget.slides[i].slideImage.isNotEmpty)
          ? _pages.add(
              // parts = widget.slides[i].slideImage.split('.')[1].trim();
              widget.slides[i].slideImage.split('.')[1].trim()=="mp4"?
              Container(
                padding: EdgeInsets.only(left: 20),
                height: 200,
                width: 400,
                child: ChewieListItem(
                                    slide:widget.slides[i].slideImage,
                                    looping: false,
                                    videoPlayerController:
                                        VideoPlayerController.network(
                                      'https://www.masshseconsultant.com/admin/uploads/' +
                                          widget.slides[i].slideImage),
                                    )
              ):Container(
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://www.masshseconsultant.com/admin/uploads/' +
                              widget.slides[i].slideImage),
                      fit: BoxFit.fill),
                ),
              ),
            )
          : Container(
              height: 190,
              width: 180,
              color: Colors.grey,
            );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {},
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: <Widget>[
              PageView.builder(
                scrollDirection: Axis.horizontal,
                onPageChanged: _onchanged,
                controller: _controller,
                itemCount: _pages.length,
                allowImplicitScrolling: true,
                itemBuilder: (context, int index) {
                  return _pages[index];
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(
                      _pages.length,
                      (int index) {
                        return Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            height: 3,
                            width: (index == _currentPage) ? 25 : 25,
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: (index == _currentPage)
                                  ? Colors.white
                                  : Colors.green[900],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ChewieListItem extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final String slide;


  ChewieListItem({
    @required this.videoPlayerController,
    this.looping,
    this.slide,
    Key key,
  }) : super(key: key);

  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
  ChewieController _chewieController;
  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    // Wrapper on top of the videoPlayerController
     initializeVideoPlayer();
    
  }


 void _initController(String link) {
        _videoPlayerController = VideoPlayerController.network('https://www.masshseconsultant.com/admin/uploads/' +widget.slide)
        ..initialize()
          .then((value) => VideoPlayerController.network(
            'https://www.masshseconsultant.com/admin/uploads/' +widget.slide,
          )..initialize()
            .then((_){
              setState(() {

              });
              /// play after initialization
          }));
  }


  Future<void> initializeVideoPlayer() async {
      // print("Sdddddddddddddddd"+widget.slide);
      if (_videoPlayerController == null) {
      // If there was no controller, just create a new one
       _initController(widget.slide);
    } else {
      // If there was a controller, we need to dispose of the old one first
      final oldController = _videoPlayerController;

      // Registering a callback for the end of next frame
      // to dispose of an old controller
      // (which won't be used anymore after calling setState)
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await oldController.dispose();

        // Initing new controller
        _initController(widget.slide);
      });

      // Making sure that controller is not used by setting it to null
      setState(() {
        _videoPlayerController = null;
      });
    }
    
      // _videoPlayerController = VideoPlayerController.network('https://www.masshseconsultant.com/admin/uploads/' +widget.slide)
      //   ..initialize()
      //     .then((value) => VideoPlayerController.network(
      //       'https://www.masshseconsultant.com/admin/uploads/' +widget.slide,
      //     )..initialize()
      //       .then((_){
      //         setState(() {

      //         });
      //         /// play after initialization
      //     }));
        // .then((_) {
        //   // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        //   setState(() {});
        // });
     
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 18 / 9,
      // Prepare the video to be played and display the first frame
      autoInitialize: true,
      looping: widget.looping,
      // Errors can occur for example when trying to play a video
      // from a non-existent URL
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            "Try Again",
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
      child: _chewieController != null ?
          Chewie(
            controller: _chewieController,
          ):Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Loading'),
            ],
            ),
    );
  }

  @override
  void dispose() {
    
    // IMPORTANT to dispose of all the used resources
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}