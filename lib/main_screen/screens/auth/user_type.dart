
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../../../widgets/constant_button.dart';
import 'otp_screen.dart';

class UserType extends StatefulWidget {
  final String userEmail;
  final String userPassword;
  final String confirmPass;

  const UserType(
      {Key? key, required this.userEmail, required this.userPassword, required this.confirmPass})
      : super(key: key);
  static String verify = '';

  @override
  State<UserType> createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  int? userType;

  bool _isChecked1 = false;
  bool _isChecked2 = false;

  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  var phone = '';

  FocusNode focusNode = FocusNode();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    print('User Email////////////////////: ${widget.userEmail}');
    print('User Email/////////////////////: ${widget.userPassword}');
    print('User Email/////////////////////: ${widget.confirmPass}');
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Center(
                  child: Text(
                    'Account detail',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(child: Text('Please fill in your details below.')),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                IntlPhoneField(
                  initialCountryCode: 'PK',
                  controller: phoneNumberController,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    labelText: 'Enter phone number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (PhoneNumber? number) {
                    if (number != null) {
                      phone = number.completeNumber;
                    }
                  },
                  onCountryChanged: (country) {
                    print('Country changed to: ${country.name}');
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'What type of user are you?',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildContainer(1, 'Individual',
                        'https://images.pexels.com/photos/4555468/pexels-photo-4555468.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                    buildContainer(2, 'Rescue/Charity',
                        'https://images.pexels.com/photos/3318215/pexels-photo-3318215.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                    buildContainer(3, 'Breeder',
                        'https://images.pexels.com/photos/16252663/pexels-photo-16252663/free-photo-of-dog-lying-on-the-lawn-among-autumn-leaves.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Checkbox(
                        value: _isChecked1,
                        onChanged: (value) {
                          setState(() {
                            _isChecked1 = value!;
                            _isChecked2 = false;
                          });
                        },
                        fillColor: MaterialStateProperty.all(Colors.white),
                        checkColor: Colors.green,
                        focusColor: Colors.blue,
                        side: const BorderSide(
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const Text('Receive our newsletter')
                  ],
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Checkbox(
                        value: _isChecked2,
                        onChanged: (value) {
                          setState(() {
                            _isChecked2 = value!;
                            _isChecked1 = false;
                          });
                        },
                        fillColor: MaterialStateProperty.all(Colors.white),
                        checkColor: Colors.green,
                        focusColor: Colors.blue,
                        side: const BorderSide(
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const Text(
                        'I wish to receive marketing emails from\nour trusted partner ManyPets Ltd'),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'By creating an account, you accept Pets4Homes\'',
                ),
                const InkWell(
                  child: Text(
                    'terms and conditions.',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ConstantButton(
                  text: 'Create my account',
                  color: Colors.white,
                  voidCallback: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      try {
                        setState(() {
                          _isLoading = true;
                        });
                        await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: phone.toString(),
                            verificationCompleted:
                                (PhoneAuthCredential credential) async {
                              await FirebaseAuth.instance.signInWithCredential(
                                  credential);
                            },
                            verificationFailed:
                                (FirebaseAuthException e) {
                              Fluttertoast.showToast(
                                  msg: 'verification failed: ${e.message}');
                              setState(() {
                                _isLoading = false;
                              });
                            },
                            codeSent: (verificationId,
                                int? resendToken) async {
                              Fluttertoast.showToast(
                                  msg: 'Otp sent to your phone');
                              UserType.verify = verificationId;
                              // await _registerUser();
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (ctx) => OtpScreen(
                              verificationId:verificationId,
                              phoneNumber:phone.toString(),
                              firstName:nameController.text, lastName: lastNameController.text,
                              userType:userType.toString(),
                              userEmail: widget.userEmail.toString(),
                              userPassword: widget.userPassword.toString(),
                              confirmPass: widget.confirmPass.toString(),
                              ),
                              ),
                              );
                              setState(() {
                              _isLoading = false;
                              });
                            },
                            codeAutoRetrievalTimeout:
                                (String verificationId) {});
                      } catch (e) {
                        Fluttertoast.showToast(
                            msg: 'Error during phone number verification: $e');
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    }
                  },
                  buttonColor: Colors.green.shade900,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContainer(int index, String text, String imageUrl) {
    return InkWell(
      onTap: () {
        setState(() {
          userType = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        width: MediaQuery
            .of(context)
            .size
            .width * .3,
        height: MediaQuery
            .of(context)
            .size
            .height * .12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: userType == index ? Colors.green : Colors.grey,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(
              height: 5,
            ),
            ClipOval(
              child: Image.network(
                imageUrl,
                width: 70.0,
                height: 70.0,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );

  }
  // Future<void> _registerUser() async {
  //   try {
  //     String firstName = nameController.text;
  //     String lastName = lastNameController.text;
  //     String userEmail = widget.userEmail;
  //     String userPassword = widget.userPassword;
  //
  //     Map<String, dynamic> body = {
  //       'firstName': firstName,
  //       'lastName': lastName,
  //       'email': userEmail,
  //       'password': userPassword,
  //       'phoneNumber': phone.toString(),
  //       'status': '1',
  //       'token': 'asdfsdfasdfasdf',
  //       'devicetype': '1',
  //     };
  //
  //     final response = await http.post(
  //       Uri.parse('https://wowpetspalace.com/dashboard/authUser/registeruser'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode(body),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       RegisterModel registerResponse = RegisterModel.fromJson(jsonDecode(response.body));
  //
  //       if (registerResponse.message == 'success') {
  //         print('User registration successful');
  //         Fluttertoast.showToast(msg: 'User registration successful');
  //       } else {
  //         print('User registration failed: ${registerResponse.message}');
  //         Fluttertoast.showToast(msg: 'User registration failed: ${registerResponse.message}');
  //         throw Exception('User registration failed');
  //       }
  //     } else {
  //       print('Unexpected response status code: ${response.statusCode}');
  //       Fluttertoast.showToast(msg: 'Unexpected response status code: ${response.statusCode}');
  //       throw Exception('Unexpected response status code');
  //     }
  //   } catch (e) {
  //     print('Error during user registration: $e');
  //     Fluttertoast.showToast(msg: 'Error during user registration: $e');
  //     throw Exception('Error during user registration');
  //   }
  // }




}

