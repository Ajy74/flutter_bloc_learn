import 'package:bloc_learn/phone_auth/Cubit/auth_cubit.dart';
import 'package:bloc_learn/phone_auth/Cubit/auth_state.dart';
import 'package:bloc_learn/phone_auth/verify_number_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneSignInScreen extends StatefulWidget {
  const PhoneSignInScreen({super.key});

  @override
  State<PhoneSignInScreen> createState() => _PhoneSignInScreenState();
}

class _PhoneSignInScreenState extends State<PhoneSignInScreen> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Auth"),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: phoneController,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Phone Number",
                      counterText: ""),
                ),
                SizedBox(
                  height: 15,
                ),
                
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if(state is AuthCodeSendState){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> VerifyPhoneNumberScreen()));
                    }
                  },
                  builder: (context, state) {

                    if(state is AuthLoadingState){
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CupertinoButton(
                        onPressed: () {
                          String phoneNumber = "+91" + phoneController.text.toString();
                          BlocProvider.of<AuthCubit>(context).sendOTP(phoneNumber);
                        },
                        color: Colors.blue,
                        child: Text("Sign in"),
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
