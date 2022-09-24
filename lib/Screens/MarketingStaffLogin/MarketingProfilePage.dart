import 'package:flutter/material.dart';
import 'package:massnew/Api/api.dart';
import 'package:massnew/Models/MarketingProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../FirstPage.dart';

class MarketingProfileScreen extends StatefulWidget {
  MarketingProfileScreen({Key key}) : super(key: key);

  @override
  _MarketingProfileScreenState createState() => _MarketingProfileScreenState();
}

class _MarketingProfileScreenState extends State<MarketingProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<MarketingProfileModel>(
      future: marketingrofileApi(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(color: Color(0xff026a37)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        child: (snapshot.data.data.trainerProfileView[0]
                                .trainerPic.isNotEmpty)
                            ? CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                  'https://www.masshseconsultant.com/admin/uploads/' +
                                          snapshot
                                              .data
                                              .data
                                              .trainerProfileView[0]
                                              .trainerPic ??
                                      '',
                                ),
                              )
                            : CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey,
                              )),
                    Text(
                      snapshot.data.data.trainerProfileView[0].trainerName ??
                          '',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot.data.data.trainerProfileView[0].trainerId ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Color(0xff026a37),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      var pref = await SharedPreferences.getInstance();
                      pref.clear();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FirstPage(),
                          ),
                          (route) => false);
                    },
                    child: Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}
