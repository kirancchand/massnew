import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:massnew/Api/api.dart';
import 'package:massnew/Models/CheckOutPage.dart';
import 'package:massnew/Models/RedeemCodeModel.dart';
import 'package:massnew/Models/cartDisplayModel.dart';
import 'package:massnew/Screens/tabScreen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CartPage extends StatefulWidget {
  CartPage();

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int index1 = 0;

  GlobalKey<ScaffoldState> key1 = GlobalKey();

  bool spin = false;

  Widget build(BuildContext context) {
    TextEditingController coupon = TextEditingController();
    void cancelPolicy() {
      showGeneralDialog(
        barrierLabel: "Barrier",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 250),
        context: context,
        pageBuilder: (_, __, ___) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 20),
                      width: MediaQuery.of(context).size.width * .8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 28,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Enter Coupon',
                            style: TextStyle(
                              color: Color(0xff41287B),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
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
                              controller: coupon,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                hintText: 'Coupon Code',
                                hintStyle: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                width: 110,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Color(0xff026a37),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: MaterialButton(
                                  onPressed: () async {
                                    if (coupon.text.isNotEmpty) {
                                      setState(() {
                                        spin = true;
                                      });
                                      CheckOutClass x = await confirmCheckOut(
                                          couponcode: coupon.text);
                                      setState(() {
                                        spin = false;
                                      });
                                      if (x.data.data == "invalidcoupon") {
                                        // key1.currentState.showSnackBar(SnackBar(
                                        //     content: Text(x.data.data)));
                                        Fluttertoast.showToast(
                                            msg: x.data.data);
                                        Navigator.pop(context);
                                      } else {
                                        // key1.currentState.showSnackBar(SnackBar(
                                        //     content: Text(x.data.data)));
                                        Fluttertoast.showToast(
                                            msg: x.data.data);
                                        await Future.delayed(
                                            Duration(seconds: 2));
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => NavBar(
                                              count: 0,
                                            ),
                                          ),
                                        );
                                      }
                                    } else
                                      // key1.currentState.showSnackBar(SnackBar(
                                      //     content:
                                      //         Text('Please enter Coupon')));
                                      Fluttertoast.showToast(
                                          msg: 'Please enter Coupon');
                                  },
                                  child: Text('CONFIRM',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
        resizeToAvoidBottomInset: false, 
        key: key1,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          title: Image.asset(
            'assets/images/massco.png',
            height: 70,
            width: 220,
          ),
          actions: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xff026a37),
                borderRadius: BorderRadius.circular(25),
              ),
              child: MaterialButton(
                onPressed: () async {
                  RedeemCodeModel m = await redeemCodeApi();
                  Fluttertoast.showToast(
                    msg: m.data.reqcheckcode ?? "",
                    fontSize: 15,
                  );
                },
                child: Text(
                  'Code Request',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        body:  SingleChildScrollView(
          child: FutureBuilder<CartDisplayClass>(
            future: cartdisplayApi(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ModalProgressHUD(
                  inAsyncCall: spin,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'CART',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Color(0xff026a37),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            (snapshot.data.data.displayCart.length == 0)
                                ? Container(
                              child: Text('Cart Empty'),
                            )
                                : Container(
                              width: double.infinity,
                              height:
                              MediaQuery.of(context).size.height - 225,
                              child: ListView.builder(
                                itemCount:
                                snapshot.data.data.displayCart.length,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return Row(
                                    children: [
                                      (snapshot.data.data.displayCart[index]
                                          .coursepic.isEmpty)
                                          ? Expanded(
                                        flex: 2,
                                        child: Container(
                                          padding:
                                          EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: CircleAvatar(
                                            radius: 25,
                                            backgroundColor:
                                            Colors.green,
                                            // backgroundImage: AssetImage(
                                            //   'assets/images/pro.jpg',
                                            // ),
                                          ),
                                        ),
                                      )
                                          : Expanded(
                                        flex: 2,
                                        child: Container(
                                          padding:
                                          EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: CircleAvatar(
                                            radius: 25,
                                            backgroundColor:
                                            Colors.amber,
                                            backgroundImage:
                                            NetworkImage(
                                              'https://www.masshseconsultant.com/admin/uploads/' +
                                                  snapshot
                                                      .data
                                                      .data
                                                      .displayCart[
                                                  index]
                                                      .coursepic ??
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
                                                    .displayCart[index]
                                                    .cartCName,
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
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data
                                                        .data
                                                        .displayCart[index]
                                                        .cartItemPrice,
                                                    style: TextStyle(
                                                      color:
                                                      Color(0xff026a37),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              spin = true;
                                            });
                                            String s = await cartdeleteApi(
                                              crid: snapshot
                                                  .data
                                                  .data
                                                  .displayCart[index]
                                                  .cartCId,
                                            );
                                            setState(() {
                                              spin = false;
                                            });
                                            key1.currentState
                                                .showSnackBar(SnackBar(
                                              content: Text(s),
                                            ));
                                            await Future.delayed(
                                                Duration(seconds: 1));
                                            // Navigator.pushReplacement(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) => CartPage(),
                                            //   ),
                                            // );
                                          },
                                          child: Icon(
                                            Icons.delete_outline_sharp,
                                            color: Color(0xff026a37),
                                            size: 19,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Color(0xff90eba6),
                                    Color(0xff25a4b3),
                                  ]),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xff026a37),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  snapshot.data.data.cartTotal ?? '',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xff026a37),
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 45,
                            width: double.infinity,
                            margin:
                            EdgeInsets.only(bottom: 10, left: 25, right: 25),
                            decoration: BoxDecoration(
                              color: Color(0xff026a37),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                if (snapshot.data.data.displayCart.length > 0) {
                                  cancelPolicy();
                                } else {
                                  key1.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text('No item in cart'),
                                    ),
                                  );
                                  // Fluttertoast.showToast(msg: 'No item in cart');
                                }
                              },
                              child: Text(
                                'Purchase',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: Container());
              }
            },
          )
        )

    );
  }
}
