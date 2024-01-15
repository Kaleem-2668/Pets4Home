
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pets_4_home/main_screen/screens/auth/user_type.dart';
import 'package:pinput/pinput.dart';
import 'package:svg_flutter/svg.dart';

import '../../bottom_navigation_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.phoneNumber,required this.verificationId,required this.userName}) : super(key: key);
  final String phoneNumber;
  final String verificationId;
  final String userName;


  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final otpController= TextEditingController();


int countDown = 30;
bool isResendButtonEnabled=false;
startCountDown(){
  Future.delayed(const Duration(seconds: 1),(){
    setState(() {
      countDown--;
      if (countDown<=0){
        isResendButtonEnabled=true;
      }else{
        startCountDown();
      }
    });


  });
}
@override
  void initState() {
    startCountDown();
    super.initState();
  }

  String? verificationId;
  String? otpCode;
  /*Future<void>verifyOtp()async{
    await FirebaseAuth.instance.signInWithCredential(
        PhoneAuthProvider.credential(verificationId: widget.verificationId,
        smsCode: otpCode!));
  }*/
  Future<void> verifyOtp() async {
    try {
      await FirebaseAuth.instance.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: widget.verificationId,
          smsCode: otpCode!,
        ),
      );
      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
        return const BottomBarScreen();
      }));
    } catch (e) {
      Fluttertoast.showToast(msg: 'Incorrect OTP. Please try again.');
      setState(() {
        isResendButtonEnabled = true;

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final defaultPintTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(fontSize: 22, color: Colors.black),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.green.shade200,
        border: Border.all(color: Colors.transparent),
      ),
    );

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'images/gold.svg',
                  width: 70,
                  height: 80,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'OTP verification',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                 Text('Hello, ${widget.userName}'),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: RichText(
                    text:  TextSpan(
                      text: 'Thank you for registering with you. Please\ntype the OTP as shared on your Mobile\n',
                      style: const TextStyle(
                        color: Colors.black,

                      ),
                      children: [

                    TextSpan(
                    text:widget.phoneNumber,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),)
                      ],
                    ),
                  ),
                ),

                // Text(
                //     'Thank you for registering with you. Please\ntype the OTP as shared on your Mobile\n'
                //         '${widget.phoneNumber}'),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Pinput(
                    controller: otpController,
                    length: 6,
                    defaultPinTheme: defaultPintTheme,
                    focusedPinTheme: defaultPintTheme.copyWith(
                      decoration: defaultPintTheme.decoration!.copyWith(
                        border: Border.all(color: Colors.green.shade700),
                      ),
                    ),
                    onCompleted: (value)  {
                      setState(() {
                        otpCode=value;
                      });

                    },
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Text('Wait until $countDown Second',),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('OTP not received'),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () async {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: widget.phoneNumber,
                            verificationCompleted:
                                (PhoneAuthCredential credential) async{
                               await FirebaseAuth.instance.signInWithCredential(credential);

                            },
                            verificationFailed:
                                (FirebaseAuthException e) {
                              Fluttertoast.showToast(msg: 'verification failed: ${e.message}');

                            },
                            codeSent: (verificationId,
                                int? resendToken) {

                              Fluttertoast.showToast(msg: 'Otp sent to your phone');
                              UserType.verify = verificationId;

                            },
                            codeAutoRetrievalTimeout:
                                (String verificationId) {});
                      },
                      child:  Text(

                        'RESEND',
                        style:  isResendButtonEnabled?const TextStyle(fontWeight: FontWeight.bold,

                            color: Colors.green):const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 150,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.green.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 15,horizontal:170),
                  ),
                  onPressed: () async{
                     verifyOtp();
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


}