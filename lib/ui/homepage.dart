import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zarinpal/zarinpal.dart';
import 'package:flutter_zarinpal3/constants/constant.dart';
import 'package:uni_links/uni_links.dart';
import 'resultpage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FocusNode _focusNodeMobile = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodeAmount = FocusNode();
  final TextEditingController _controllerMobile = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerAmount = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  PaymentRequest _paymentRequest = PaymentRequest();
  late StreamSubscription _streamSubscription;
  String receivedLink = '';

  final Box _boxPaymentResult = Hive.box("paymentResult");

  String merchandID = AppConstants.MERCHANTID;
  String mobileID = AppConstants.MOBILE;
  String emailID = AppConstants.EMAIL;

  String? _paymentUrl;

  bool valuefirst = false;
  bool valuesecond = false;

  String? msg = '';

  var refrence;
  String message = '';

  String statusPay = '';
  String authorityPay = '';

  void initState() {
    super.initState();

    //check payment successful or unsuccessful

    _streamSubscription = linkStream.listen((String? link) {
      receivedLink = link!;
      print("this is receive link ========================> ${receivedLink} ");

      //successfull payment
      //"receivedLink= persiangulf://aryaclub.com?Authority=000000000000000000000000000001141617&Status=OK"

      //unsuccessful payment
      //"receivedLink= persiangulf://aryaclub.com?Authority=000000000000000000000000000001141631&Status=NOK"

      if (receivedLink.toLowerCase().contains('status') &&
          receivedLink.toLowerCase().contains('authority')) {
        statusPay = receivedLink.split('=').last;
        authorityPay = receivedLink.split('?')[1].split('&')[0].split('=')[1];
        print(
            "this is receive statusPay ========================> ${statusPay} ");
        print(
            "this is receive authorityPay ========================> ${authorityPay} ");

        // Vefrication Payment
        // if you set the scheme in your application, You can get the Status and Authority from scheme callback
        // if your callback is a website URL like htt://mydomain.com you don't need verificationPayment function
        ZarinPal().verificationPayment(statusPay, authorityPay, _paymentRequest,
            (isPaymentSuccess, refID, paymentRequest) {
          if (isPaymentSuccess) {
            // The payment operation was successful

            // msg = " پرداخت شما با موفقیت انجام شد. کد پیگیری : ";
            msg = "پرداخت شما با موفقیت انجام شد";
            refrence = refID;

            message = " ${msg}  ${refrence}";
            print(message);

            // Fluttertoast.showToast(
            //     msg: message,
            //     toastLength: Toast.LENGTH_SHORT,
            //     gravity: ToastGravity.CENTER,
            //     backgroundColor: Colors.red,
            //     textColor: Colors.white,
            //     fontSize: 16.0);
            //
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(SnackBar(content: Text(message)));

            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(
            //     content: Row(
            //       children: <Widget>[
            //         Icon(
            //           Icons.add_a_photo,
            //           color: Colors.amberAccent,
            //         ),
            //         Text(
            //           " Hello Coloured Snackbar",
            //           style: TextStyle(color: Colors.white),
            //         ),
            //       ],
            //     ),
            //     duration: Duration(seconds: 5),
            //     backgroundColor: Colors.blueAccent,
            //   ),
            // );

            ////////////////////////////////////////////////////////////////////////////////////////////////////////
            // these fill here
            _boxPaymentResult.put("paymentMessage", msg);
            // _boxPaymentResult.put(
            //   "paymentRefence",
            //   refrence,
            // );
            _boxPaymentResult.put(
                "paymentRefence",
                authorityPay.replaceAll(RegExp(r'^0+(?=.)'), '')
            );
            _boxPaymentResult.put("paymentStatus", statusPay);

            //these must fill before clear in ElevatedButton onPressed event for pass to information form
            // _boxPaymentResult.put("paymentAmount", _controllerAmount.text);
            // _boxPaymentResult.put("customerMobile", _controllerMobile.text);
            // _boxPaymentResult.put("customerEmail", _controllerEmail.text);

            //allfields need to show in information form
            ////////////////////////////////////////////////////////////////////////////////////////////////////////

            msg = '';
            refrence = '';
            message = '';

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ResultPage();
                },
              ),
            );
          } else {
            // The payment operation was not successful

            msg = " اشکال در عملیات پرداخت ";
            message = " اشکال در عملیات پرداخت ";
            print(message);
            refrence = refID;
            refrence ??= authorityPay;

            //
            // Fluttertoast.showToast(
            //     msg: message,
            //     toastLength: Toast.LENGTH_SHORT,
            //     gravity: ToastGravity.CENTER,
            //     backgroundColor: Colors.red,
            //     textColor: Colors.white,
            //     fontSize: 16.0);
            //
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(SnackBar(content: Text(message)));


            ////////////////////////////////////////////////////////////////////////////////////////////////////////
            // these fill here
            _boxPaymentResult.put("paymentMessage", msg);
            _boxPaymentResult.put(
              "paymentRefence",
              authorityPay.replaceAll(RegExp(r'^0+(?=.)'), '')
            );
            _boxPaymentResult.put("paymentStatus", statusPay);

            //these must fill before clear in ElevatedButton onPressed event for pass to information form
            // _boxPaymentResult.put("paymentAmount", _controllerAmount.text);
            // _boxPaymentResult.put("customerMobile", _controllerMobile.text);
            // _boxPaymentResult.put("customerEmail", _controllerEmail.text);

            //allfields need to show in information form
            ////////////////////////////////////////////////////////////////////////////////////////////////////////


            msg = '';
            refrence = '';
            message = '';

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ResultPage();
                },
              ),
            );


          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Form(
        key: _formKey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(height: 35),
              Text(
                "Welcome Back",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "Let's go to pay with ZarinPal",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _controllerMobile,
                focusNode: _focusNodeMobile,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Mobile",
                  suffixIcon: IconButton(
                    onPressed: () {
                      _controllerMobile.clear();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  prefixIcon: const Icon(Icons.mobile_screen_share_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter mobile number.";
                  }
                  // else if (_boxAccounts.containsKey(value)) {
                  //   return "Mobile is already registered.";
                  // }

                  return null;
                },
                onEditingComplete: () => _focusNodeEmail.requestFocus(),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _controllerEmail,
                focusNode: _focusNodeEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  suffixIcon: IconButton(
                    onPressed: () {
                      _controllerEmail.clear();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter email.";
                  } else if (!(value.contains('@') && value.contains('.'))) {
                    return "Invalid email";
                  }
                  return null;
                },
                onEditingComplete: () => _focusNodeAmount.requestFocus(),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _controllerAmount,
                focusNode: _focusNodeAmount,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  labelText: "Amount",
                  suffixIcon: IconButton(
                    onPressed: () {
                      _controllerAmount.clear();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  prefixIcon: const Icon(Icons.money_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                validator: (String? value) {
                  if (value == null) {
                    return null;
                  }
                  final n = num.tryParse(value);
                  if (n == null) {
                    return '"$value" is not a valid Amount';
                  }
                  if (value != null && int.parse(value) < 100) {
                    return 'The amount must be greater than 100 toman.';
                  }
                  return null;
                },

                // onEditingComplete: () => _focusNodeSandBox.requestFocus(),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Sandbox: ',
                        style: TextStyle(fontSize: 17.0),
                      ),
                      Checkbox(
                        checkColor: Colors.greenAccent,
                        activeColor: Colors.red,
                        value: this.valuefirst,
                        onChanged: (bool? value) {
                          setState(() {
                            this.valuefirst = value!;
                            print(this.valuefirst);
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // _boxAccounts.put(
                        //   _controllerMobile.text,
                        //   _controllerConFirmPassword.text,
                        // );

                        _paymentRequest
                          ..setIsSandBox(this.valuefirst)
                          ..setMerchantID(merchandID)
                          ..setAmount(int.parse(
                              _controllerAmount.text)) //integer Amount
                          // ..setMobile(mobileID)
                          ..setMobile(_controllerMobile.text)
                          // ..setEmail(emailID)
                          ..setEmail(_controllerEmail.text)
                          ..isZarinGateEnable
                          ..setCallbackURL(
                              "persiangulf://aryaclub.com") //The callback can be an android scheme or a website URL, you and can pass any data with The callback for both scheme and  URL
                          ..setDescription("Payment Description With Zarinpal");

                        ////////////////////////////////////////////////////////////////////////////////////////////////////////
                        //these must fill before clear in ElevatedButton onPressed event for pass to information form
                        _boxPaymentResult.put(
                            "paymentAmount", _controllerAmount.text);
                        _boxPaymentResult.put(
                            "customerMobile", _controllerMobile.text);
                        _boxPaymentResult.put(
                            "customerEmail", _controllerEmail.text);
                        // these fill in initstate when payment is successful
                        // _boxPaymentResult.put("paymentMessage",msg);
                        // _boxPaymentResult.put("paymentRefence",refrence,);
                        // _boxPaymentResult.put("paymentStatus", statusPay);

                        //allfields need to show in information form
                        ////////////////////////////////////////////////////////////////////////////////////////////////////////


                        //   // Call Start payment
                        ZarinPal().startPayment(_paymentRequest,
                            (int? status, String? paymentGatewayUri) {
                          if (status == 100) {
                            _paymentUrl =
                                paymentGatewayUri; // launch URL in browser
                            msg = '';
                            refrence = '';
                            message = '';

                            launchUrl(Uri.parse(_paymentUrl!),
                                mode: LaunchMode.externalApplication);
                          } else {
                            msg = " خطا در ساخت توکن  کد خطا: ";
                            refrence = status;

                            message = " ${msg}  ${refrence}";
                            print(message);

                            Fluttertoast.showToast(
                                msg: message,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);

                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(message)));
                            msg = '';
                            refrence = '';
                            message = '';
                          }
                        });

                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     width: 200,
                        //     backgroundColor:
                        //     Theme.of(context).colorScheme.secondary,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //     behavior: SnackBarBehavior.floating,
                        //     content: const Text("Registered Successfully"),
                        //   ),
                        // );

                        // _formKey.currentState?.reset();
                        _controllerMobile.clear();
                        _controllerEmail.clear();
                        _controllerAmount.clear();
                        _focusNodeMobile.requestFocus();
                        // FocusScope.of(context).requestFocus(_focusNodeMobile);
                        // Navigator.pop(context);
                      }
                    },
                    child: const Text("PAY AMOUNT"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controllerMobile.dispose();
    _controllerEmail.dispose();
    _focusNodeAmount.dispose();
    super.dispose();
  }
}
