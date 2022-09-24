import 'package:flutter/material.dart';
import 'package:massnew/Api/api.dart';
import 'package:massnew/Models/BannerModel.dart';
import 'package:massnew/Models/ClientRegModel.dart';
import 'package:geolocator/geolocator.dart';
import '../homeScreen.dart';

class MarketingHomePage extends StatefulWidget {
  MarketingHomePage({Key key}) : super(key: key);

  @override
  _MarketingHomePageState createState() => _MarketingHomePageState();
}

class _MarketingHomePageState extends State<MarketingHomePage> {
    Position _currentPosition;
   static const String _kLocationServicesDisabledMessage =
      'Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';
final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;


  TextEditingController clientname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController companyname = TextEditingController();
  TextEditingController message = TextEditingController();
  GlobalKey<ScaffoldState> keyy = GlobalKey();
  bool check=false;
   @override
  void initState() {
    super.initState();
    _showDialog();
    // _getCurrentPosition();
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: keyy,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [

              SizedBox(
                height: 20,
              ),
              FutureBuilder<HomeBannerModel>(
                future: bannerApi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 210,
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
                height: 30,
              ),
              // FloatingActionButton(
              //   child: const Icon(Icons.my_location),
              //   onPressed: _getCurrentPosition,
              //   ),
              // Text(_currentPosition.toString()),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    SingleTextWidgetss(
                      name: 'Client Name',
                      type: TextInputType.name,
                      icon: Icon(
                        Icons.person_outline_sharp,
                        color: Color(0xff9961be),
                      ),
                      controller: clientname,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SingleTextWidgetss(
                      name: 'Email',
                      type: TextInputType.emailAddress,
                      icon: Icon(
                        Icons.email_outlined,
                        color: Color(0xff9961be),
                      ),
                      controller: email,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SingleTextWidgetss(
                      name: 'Phone Number',
                      type: TextInputType.number,
                      icon: Icon(
                        Icons.lock_outline_sharp,
                        color: Color(0xff9961be),
                      ),
                      controller: phone,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SingleTextWidgetss(
                      name: 'Company Name',
                      type: TextInputType.name,
                      // icon: Icon(
                      //   Icons.person_outline_sharp,
                      //   color: Color(0xff9961be),
                      // ),
                      controller: companyname,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SingleTextWidgetss(
                      name: 'Message',
                      type: TextInputType.name,
                      controller: message,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 40,
                      width: 170,
                      decoration: BoxDecoration(
                        color: Color(0xff026a37),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: MaterialButton(

                        onPressed: () async {
                          if(_currentPosition!=null&&_currentPosition!=null){
                            if (clientname.text.isNotEmpty &&
                                email.text.isNotEmpty &&
                                phone.text.isNotEmpty &&
                                companyname.text.isNotEmpty &&
                                message.text.isNotEmpty) {
                              ClientRegModel c = await clientRegistrationApi(
                                  cname: clientname.text,
                                  cemail: email.text,
                                  cphno: phone.text,
                                  company: companyname.text,
                                  comment: message.text,
                                  latitude:_currentPosition.latitude.toString(),
                                  longitude:_currentPosition.longitude.toString()
                              );
                              if (c.data.success == '200') {
                                keyy.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text(c.data.registeration),
                                  ),
                                );
                                clientname.clear();
                                email.clear();
                                phone.clear();
                                companyname.clear();
                                //afterlogin smthng to do;
                              } else {
                                keyy.currentState.showSnackBar(SnackBar(
                                    content: Text(c.data.registeration)));
                              }
                            } else {
                              keyy.currentState.showSnackBar(
                                  SnackBar(content: Text('fill all fields')));
                            }
                          }else{
                                keyy.currentState.showSnackBar(
                                SnackBar(content: Text('Must Allow Location Massco to use your location data')));
                                _getCurrentPosition();
                          }

                        },
                        child: Text(
                          'Register Client',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



    _showDialog() async {
      await Future.delayed(Duration(milliseconds: 50));
      showDialog(
        context: context,
        builder: (BuildContext context) =>    AlertDialog(
          title: const Text('Disclaimer Policy'),
          content:const Text('MASSCO HSE collects location data to enable Client Registration even when the app is closed or not in use'),
          actions: <Widget>[
            TextButton(
              onPressed: () => {
                setState(() {
                  check = true;
                  _getCurrentPosition();
                }),
                Navigator.pop(context, 'OK')
              },
              child: const Text('OK'),
            ),
          ],
        ),
        // builder: (BuildContext context) {
        //   return new Container(child: new Text('foo'));
        // }
      );
    }


     Future<void> _getCurrentPosition() async {

     

         final hasPermission = await _handlePermission();

         if (!hasPermission) {
           return;
         }

         final position = await _geolocatorPlatform.getCurrentPosition();
         // _updatePositionList(
         //   _PositionItemType.position,
         //   position.toString(),
         // );
         setState(() {
           _currentPosition = position;
         });
         // return position.toString()
         // print(position.toString());


    
  }


  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      // _updatePositionList(
      //   _PositionItemType.log,
      //   _kLocationServicesDisabledMessage,
      // );

      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        // _updatePositionList(
        //   _PositionItemType.log,
        //   _kPermissionDeniedMessage,
        // );

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      // _updatePositionList(
      //   _PositionItemType.log,
      //   _kPermissionDeniedForeverMessage,
      // );

      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    // _updatePositionList(
    //   _PositionItemType.log,
    //   _kPermissionGrantedMessage,
    // );
    return true;
  }

}

class SingleTextWidgetss extends StatelessWidget {
  SingleTextWidgetss({this.name, this.controller, this.icon, this.type});
  String name;
  Widget icon;
  TextEditingController controller;
  TextInputType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          counterText: '',
          suffixIcon: icon,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          hintText: name,
          hintStyle: TextStyle(
            fontSize: 13,
            color: Color(0xff026a37),
          ),
        ),
      ),
    );
  }
}
