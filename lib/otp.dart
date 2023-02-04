// ignore_for_file: prefer_const_constructors, unnecessary_import, implementation_imports, unused_local_variable, avoid_print, unnecessary_new, body_might_complete_normally_nullable, empty_catches

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test_send_otp/phone.dart';
import 'package:pinput/pinput.dart';

class MyOtp extends StatefulWidget {
  const MyOtp({Key? key}) : super(key: key);

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 194, 204, 212)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    var code = '';

    return Scaffold(
      extendBodyBehindAppBar: true ,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); 
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black, size: 26,)
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/lock.png'),
                Text('Phone Verification', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 10,
                ),
                Text('We need to register your phone before getting started', style: TextStyle(fontSize: 16,), textAlign: TextAlign.center,),
                SizedBox(
                  height: 20,
                ),
                // Container(
                //   height: 55,
                //   decoration: BoxDecoration(
                //     border: Border.all(width: 1, color: Colors.blue.shade200),
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: Row(
                //     children: [
                //       SizedBox(
                //         width: 10,
                //       ),
                //       SizedBox(
                //         width: 30,
                //         child: TextFormField(
                //           // controller: countryCode,
                //           decoration: InputDecoration(
                //             border: InputBorder.none,
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         width: 10,
                //       ),
                //       Text('|', style: TextStyle(fontSize: 30,color: Colors.blue.shade200),),
                //       Expanded(
                //         child: TextFormField(
                //           // controller: phone, 
                //            decoration: InputDecoration(
                //             border: InputBorder.none,
                //             hintText: 'Phone',
                //           ),
                //         )
                //       ),
                //     ],
                //   ),
                // ),
                Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  // validator: (s) {
                  //   return s == '2222' ? null : 'Pin is incorrect';
                  // },
                  // pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  // onCompleted: (pin) => print(pin),
                  onChanged: (value) {
                    code = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: MyPhone.verify, smsCode: code);
                        // Sign the user in (or link) with the credential
                        await auth.signInWithCredential(credential);
                        Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
                      } catch(e) {
                        print('Wrong OTP');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade500,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      )
                    ),
                    child: Text('Verify phone number'),
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, 'phone', (route) => false);
                      },
                      child: Text('Edit Phone Number ?', style: TextStyle(color: Colors.black),)
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ); 
  }
}