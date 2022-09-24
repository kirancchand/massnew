import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:massnew/Models/BannerModel.dart';
import 'package:massnew/Models/CheckOutPage.dart';
import 'package:massnew/Models/ClientListModel.dart';
import 'package:massnew/Models/ClientRegModel.dart';
import 'package:massnew/Models/CompanyCertificateModel.dart';
import 'package:massnew/Models/ExamSubmitModel.dart';
import 'package:massnew/Models/ExamView.dart';
import 'package:massnew/Models/MarketingLogin.dart';
import 'package:massnew/Models/MarketingProfile.dart';
import 'package:massnew/Models/MyCourseViewModel.dart';
import 'package:massnew/Models/RedeemCodeModel.dart';
import 'package:massnew/Models/StudentCertificate.dart';
import 'package:massnew/Models/cartDisplayModel.dart';
import 'package:massnew/Models/companyLoginModel.dart';
import 'package:massnew/Models/companyProfileModek.dart';
import 'package:massnew/Models/fullCourseViewModel.dart';
import 'package:massnew/Models/loginModel.dart';
import 'package:massnew/Models/pdfAndVideoModel.dart';
import 'package:massnew/Models/profileModel.dart';
import 'package:massnew/Models/registrationModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> preferenceValue() async {
  var pref = await SharedPreferences.getInstance();
  return pref.getString('sid');
}

Future<LoginClass> loginApi({
  String pass,
  String uname,
}) async {
  Dio dio = new Dio();

  FormData formData = FormData.fromMap({
    "civil_id": uname,
    "password": pass,
  });
  try {
    var response = await dio.post(
      "https://masshseconsultant.com/Student/index.php/Api_hse_student/student_login",
      data: formData,
    );
    // print(response.data);

    //print('2222');
    var data = jsonDecode(response.data);
    var status = data['data']['success'];
    if (status != '200') {
      return null;
    } else {
      return loginClassFromJson(response.data);
    }
  } catch (e) {
    print(e);
  }
}

Future forgetPasswordApi({
  String uname,
}) async {
  Dio dio = new Dio();

  FormData formData = FormData.fromMap({
    "mailid": uname,
  });
  try {
    var response = await dio.post(
      "https://masshseconsultant.com/Student/index.php/Api_hse_student/forgotpassword",
      data: formData,
    );
      print(response);
      print(jsonDecode(response.data));
    return jsonDecode(response.data);
    // var status = data['data']['success'];
    // if (status) {
    //   return null;
    // } else {
    //   return marketingLoginModelFromJson(response.data);
    // }
  } catch (e) {
    print(e);
  }
}

Future<RegistrationClass> editprofileApi({
  File file,
  String email,
  String fname,
  String lname,
  String phone,
  String pass,
  String civil,
  String passport,
  String qualification,
  String gender,
  String dob,
}) async {
  Dio dio = new Dio();
  String fileName = file.path.split('/').last;
  //print(file.path);
  FormData formData = FormData.fromMap({
    "rmail": email,
    "rfname": fname,
    "rlname": lname,
    "rphone": phone,
    "rpswd": pass,
    "rcivil": civil,
    "rpasspo": passport,
    "rqualification": qualification,
    "rgender": gender,
    "rdob": dob,
    "image_file": await MultipartFile.fromFile(file.path, filename: fileName),
  });
  try {
    var response = await dio.post(
      "https://masshseconsultant.com/Student/index.php/Api_hse_student/student_profile_update",
      data: formData,
    );
    // print('1111');
    // print(response.data);
    // print('2222');
    return registrationClassFromJson(response.data);
  } catch (e) {
    print(e);
  }
}

Future<MyCourseViewClass> myCourseViewApi() async {
  Dio dio = new Dio();
  var sid = await preferenceValue();
  FormData formData = FormData.fromMap({
    "user_id": sid,
  });
  try {
    var response = await dio.post(
      "https://masshseconsultant.com/Student/index.php/Api_hse_student/student_course_view",
      data: formData,
    );
    // print('1111');
    // print(sid);
    return myCourseViewClassFromJson(response.data);
  } catch (e) {
    print(e);
  }
}

Future<String> uploadFile({
  List<PlatformFile> file,
  String pname,
  String pcourse,
}) async {
  Dio dio = new Dio();
  String fileName = file[0].path.split('/').last;
  var sid = await preferenceValue();
  FormData formData = FormData.fromMap({
    "user_id": sid,
    "projectname": pname,
    // "user_id": 239,
    // "projectname": "Risk Assessemnt in Mina Alzour Refinery",
    // "projectcourse": 46,
    // change
    "projectcourse": pcourse,
    "imagenm": await MultipartFile.fromFile(file[0].path, filename: fileName),
  });
  try {
    var response = await dio.post(
      "https://masshseconsultant.com/Student/index.php/Api_hse_student/add_project",
      data: formData,
    );
    // print('1111');
    // print(response.data);
    // print('2222');
    return jsonDecode(response.data)['data']['success'];
  } catch (e) {
    print(e);
  }
}

Future<FullCourseViewClass> fullCourseViewApi() async {
  try {
    var url = Uri.parse(
        'https://masshseconsultant.com/Student/index.php/Api_hse_student/fullcourse_view');
    var response = await http.post(url);
    final body = jsonDecode(response.body);
    // print(response.body);
    return fullCourseViewClassFromJson(response.body);
  } catch (e) {
    print(e);
  }
}

Future<ProfileClass> profileApi({
  String regno,
}) async {
  Dio dio = new Dio();
  var pref = await SharedPreferences.getInstance();
  var civilid = pref.getString('civilid');

  FormData formData = FormData.fromMap({
    "regno": civilid,
  });
  try {
    var response = await dio.post(
      "https://masshseconsultant.com/Student/index.php/Api_hse_student/student_profile_view",
      data: formData,
    );
    // print('1111');
    // print(response.data);
    // print('2222');
    return profileClassFromJson(response.data);
  } catch (e) {
    print(e);
  }
}

Future<RegistrationClass> registrationApi({
  File file,
  String email,
  String fname,
  String lname,
  String phone,
  String pass,
  String civil,
  String passport,
  String qualification,
  String gender,
  String dob,
}) async {
  Dio dio = new Dio();
  String fileName = file.path.split('/').last;
  //print(file.path);
  FormData formData = FormData.fromMap({
    "rmail": email,
    "rfname": fname,
    "rlname": lname,
    "rphone": phone,
    "rpswd": pass,
    "rcivil": civil,
    "rpasspo": passport,
    "rqualification": qualification,
    "rgender": gender,
    "rdob": dob,
    "image_file": await MultipartFile.fromFile(file.path, filename: fileName),
  });
  try {
    var response = await dio.post(
      "https://masshseconsultant.com/Student/index.php/Api_hse_student/reg_student",
      data: formData,
    );
    // print('1111');
    // print(response.data);
    // print('2222');
    return registrationClassFromJson(response.data);
  } catch (e) {
    print(e);
  }
}

Future<CartDisplayClass> cartdisplayApi({
  String sid,
}) async {
  Dio dio = new Dio();
  var sid = await preferenceValue();
  FormData formData = FormData.fromMap({
    "s_id": sid,
  });
  try {
    var response = await dio.post(
      "https://masshseconsultant.com/Student/index.php/Api_hse_student/display_cart",
      data: formData,
    );
    // print('1111');
    // print(response.data);
    // print('2222');
    return cartDisplayClassFromJson(response.data);
  } catch (e) {
    print(e);
  }
}

Future<String> cartdeleteApi({
  String crid,
}) async {
  Dio dio = new Dio();
  var sid = await preferenceValue();
  FormData formData = FormData.fromMap({
    "s_id": sid,
    "crid": crid,
  });
  try {
    var response = await dio.post(
      "https://masshseconsultant.com/Student/index.php/Api_hse_student/deletecartitem",
      data: formData,
    );
    // print('1111');
    // print(response.data['delete_cart']);
    // print('2222');
    return jsonDecode(response.data)['data']['delete_cart'];
  } catch (e) {
    print(e);
  }
}

Future<String> cartAddApi({
  String cid,
}) async {
  Dio dio = new Dio();
  var sid = await preferenceValue();
  FormData formData = FormData.fromMap({
    "student_id": sid,
    "course_id": cid,
  });
  try {
    var response = await dio.post(
      "https://masshseconsultant.com/Student/index.php/Api_hse_student/student_cart",
      data: formData,
    );
    //print('1111');
    return jsonDecode(response.data)['data']['student_cart'];
  } catch (e) {
    print(e);
  }
}

Future<CheckOutClass> confirmCheckOut({String couponcode}) async {
  Dio dio = new Dio();
  var sid = await preferenceValue();
  FormData formData = FormData.fromMap({
    "coupon": couponcode,
    "userid": sid,
  });
  try {
    var response = await dio.post(
      "https://masshseconsultant.com/Student/index.php/Api_hse_student/proceedcheck",
      data: formData,
    );
    //print('1111');
    //print(sid);
    //print(response.data);
    return checkOutClassFromJson(response.data);
  } catch (e) {
    print(e);
  }
}

Future<ExamViewClass> examViewApi({
  String qpcode,
  String examname,
  String coursecode,
  String coursename,
}) async {
  Dio dio = new Dio();
  var pref = await SharedPreferences.getInstance();
  var civil_id = pref.getString('civilid');

  FormData formData = FormData.fromMap({
    // "qp_code": "MASS-DOC-0101AGT",
    // "xamname": "AGT TEST",
    // "corsname": "NASP  Diploma",
    // "corscode": "MASS-DOC-0000ND",
    "qp_code": qpcode,
    "xamname": examname,
    "corsname": coursename,
    "corscode": coursecode,
    "civilId": civil_id,
    //change1
  });
  try {
    var response = await dio.post(
      "https://masshseconsultant.com/Student/index.php/Api_hse_student/get_exam_view",
      data: formData,
    );
    return examViewClassFromJson(response.data);
  } catch (e) {
    print(e);
  }
}

Future<ExamSubmitModel> submitAnswer({
  // List<Map<String, String>> answers,
  var answers,
  String qcode,
  String qcourse,
  String examregno,
}) async {
  Dio dio = new Dio();
  String answer = jsonEncode(answers);
  FormData formData = FormData.fromMap({
    "xamregno": "$examregno",
    "question_code": "$qcode",
    "questions_course": "$qcourse",
    "answers": "$answer"
  });
  try {
    var response = await dio.post(
      "https://masshseconsultant.com/Student/index.php/Api_hse_student/checkaswerpaper",
      data: formData,
    );
    //print(2);
    //print(jsonDecode(response.data));
    return examSubmitModelFromJson(response.data);
  } catch (e) {
    print(e);
  }
}

Future<StudentCertificate> studentCertificates() async {
  Dio dio = new Dio();
  var pref = await SharedPreferences.getInstance();
  var civil_id = pref.getString('civilid');
  FormData formData = FormData.fromMap({
    "civilid": civil_id,

    // "civilid": 281103020417,
    // change
  });
  try {
    var response = await dio.post(
      "https://masshseconsultant.com/Student/index.php/Api_hse_student/student_certificate_view",
      data: formData,
    );

    // print(response.data);

    return studentCertificateFromJson(response.data);
  } catch (e) {
    print(e);
  }
}

Future<String> uploadResearchFile({
  List<PlatformFile> file,
  String pname,
  String pcourse,
}) async {
  Dio dio = new Dio();
  String fileName = file[0].path.split('/').last;
  var sid = await preferenceValue();

  FormData formData = FormData.fromMap({
    "user_id": sid,
    "projectname": "research",
    // "projectcourse": "18",
    "projectcourse": pcourse,
    //change
    //courseid
    "files": await MultipartFile.fromFile(file[0].path, filename: fileName),
  });
  try {
    var response = await dio.post(
      "https://masshseconsultant.com/Student/index.php/Api_hse_student/insert_project",
      data: formData,
    );
    // print('1111');
    // print(response.data);
    // print('2222');
    return jsonDecode(response.data)['data']['success'];
  } catch (e) {
    print(e);
  }
}

Future<PdfAndVideoClass> pdfAndVideoApi({String cid}) async {
  Dio dio = new Dio();
  FormData formData = FormData.fromMap({
    // "course_id": 18,
    "course_id": cid,
    // change
  });
  try {
    var response = await dio.post(
      "https://masshseconsultant.com/Student/index.php/Api_hse_student/view_pdf",
      data: formData,
    );
    // print('1111');
    // print(sid);

    return pdfAndVideoClassFromJson(response.data);
  } catch (e) {
    print(e);
  }
}

Future<CompanyLoginModel> companyLoginApi({
  String pass,
  String uname,
}) async {
  Dio dio = new Dio();

  FormData formData = FormData.fromMap({
    "Username": uname,
    "Password": pass,
  });
  try {
    var response = await dio.post(
      "https://masshseconsultant.com/Student/index.php/Api_hse_student/company_login",
      data: formData,
    );
    // print(response.data);
    //print('2222');
    var data = jsonDecode(response.data);
    var status = data['data']['success'];
    if (status != '200') {
      return null;
    } else {
      return companyLoginModelFromJson(response.data);
    }
  } catch (e) {
    print(e);
  }
}

Future<MarketingLoginModel> marketingLoginApi({
  String pass,
  String uname,
}) async {
  Dio dio = new Dio();

  FormData formData = FormData.fromMap({
    "Username": uname,
    "password": pass,
  });
  try {
    var response = await dio.post(
      "https://masshseconsultant.com/Student/index.php/Api_hse_student/marketing_login",
      data: formData,
    );
    //print(response.data);
    //print('2222');
    var data = jsonDecode(response.data);
    var status = data['data']['success'];
    if (status != '200') {
      return null;
    } else {
      return marketingLoginModelFromJson(response.data);
    }
  } catch (e) {
    print(e);
  }
}

Future<MarketingProfileModel> marketingrofileApi() async {
  Dio dio = new Dio();
  var pref = await SharedPreferences.getInstance();
  var email = pref.getString('m_email');

  FormData formData = FormData.fromMap({
    // "email": "hashimmohammedkw@gmail.com",
    "email": email,
    //change
  });
  try {
    var response = await dio.post(
      "https://masshseconsultant.com/Student/index.php/Api_hse_student/trainer_profile_view",
      data: formData,
    );
    // print('1111');
    // print(response.data);
    // print('2222');
    return marketingProfileModelFromJson(response.data);
  } catch (e) {
    print(e);
  }
}

Future<ClientListModel> clientListApi() async {
  var pref = await SharedPreferences.getInstance();
  var tid = pref.getString('tid');
  Dio dio = new Dio();

  FormData formData = FormData.fromMap({
    // "trainer_id": 14,
    "trainer_id": tid,
    //change
  });
  try {
    var response = await dio.post(
      "https://masshseconsultant.com/Student/index.php/Api_hse_student/client_list",
      data: formData,
    );
    // print('1111');
    //print(response.data);
    // print('2222');
    return clientListModelFromJson(response.data);
  } catch (e) {
    print(e);
  }
}

Future<CompanyProfileClass> companyProfileApi() async {
  Dio dio = new Dio();
  var pref = await SharedPreferences.getInstance();
  var regno = pref.getString('c_regno');

  FormData formData = FormData.fromMap({
    "reg_no": regno,
  });
  try {
    var response = await dio.post(
      "https://masshseconsultant.com/Student/index.php/Api_hse_student/company_profile_view",
      data: formData,
    );
    // print(response.data);
    //print('2222');
    var data = jsonDecode(response.data);
    return companyProfileClassFromJson(response.data);
  } catch (e) {
    print(e);
  }
}

Future<String> companyAppointment({
  String name,
  String email,
  String detail,
  String phno,
  String date,
  String time,
}) async {
  Dio dio = new Dio();
  FormData formData = FormData.fromMap({
    "name": "$name",
    "email": "$email",
    "phone": "$phno",
    "date": "$date",
    "time": "$time",
    "details": "$detail"
  });
  try {
    var response = await dio.post(
      "https://masshseconsultant.com/Student/index.php/Api_hse_student/appointment",
      data: formData,
    );
    //print(2);
    //print(jsonDecode(response.data));
    return jsonDecode(response.data)["data"]["Registeration"];
  } catch (e) {
    print(e);
  }
}

Future<ClientRegModel> clientRegistrationApi({
  String cname,
  String cemail,
  String cphno,
  String company,
  String comment,
  String latitude,
  String longitude
}) async {
  var pref = await SharedPreferences.getInstance();
  var tid = pref.getString('tid');
  Dio dio = new Dio();
  FormData formData = FormData.fromMap({
    // "trainer_id": "14",
    // "client_name": "ABCD",
    // "client_mail": "sssss@gmail.com",
    // "client_phone": "1234567877",
    // "client_company": "Rosu",
    "trainer_id": "$tid",
    "client_name": "$cname",
    "client_mail": "$cemail",
    "client_phone": "$cphno",
    "client_company": "$company",
    "notes": "$comment",
    "latitude":"$latitude",
    "longitude":"$longitude"
  });

  try {
    var response = await dio.post(
      "https://masshseconsultant.com/Student/index.php/Api_hse_student/client_register",
      data: formData,
    );
    //print('client1');
    print(clientRegModelFromJson(response.data));
    //print('client2');
    return clientRegModelFromJson(response.data);
  } catch (e) {
    print(e);
  }
}

Future<CompanyCertificateClass> companyCertificateApi() async {
  Dio dio = new Dio();
  var pref = await SharedPreferences.getInstance();
  var regno = pref.getString('c_regno');

  FormData formData = FormData.fromMap({
    "reg_no": regno,
    // "reg_no": "20200612_013_COMP_MASS",
  });
  try {
    var response = await dio.post(
      "https://masshseconsultant.com/Student/index.php/Api_hse_student/company_certification_view",
      data: formData,
    );
    // print(response.data);
    //print('2222');
    var data = jsonDecode(response.data);
    return companyCertificateClassFromJson(response.data);
  } catch (e) {
    print(e);
  }
}

Future<HomeBannerModel> bannerApi() async {
  try {
    var url = Uri.parse(
        'https://masshseconsultant.com/Student/index.php/Api_hse_student/slider_api');
    var response = await http.post(url);
    final body = jsonDecode(response.body);
    // print(response.body);
    return homeBannerModelFromJson(response.body);
  } catch (e) {
    print(e);
  }
}

Future<RedeemCodeModel> redeemCodeApi() async {
  Dio dio = new Dio();
  var sid = await preferenceValue();
  var pref = await SharedPreferences.getInstance();
  var civilid = pref.getString('civilid');

  FormData formData = FormData.fromMap({
    "civilid": civilid,
    "stid": sid,
  });
  try {
    var response = await dio.post(
      "https://masshseconsultant.com/Student/index.php/Api_hse_student/reqcheckcode",
      data: formData,
    );
    // print(response.data);
    //print('2222');
    var data = jsonDecode(response.data);
    return redeemCodeModelFromJson(response.data);
  } catch (e) {
    print(e);
  }
}
