import 'package:bloc_learn/phone_auth/Cubit/auth_cubit.dart';
import 'package:bloc_learn/phone_auth/Cubit/auth_state.dart';
import 'package:bloc_learn/phone_auth/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyPhoneNumberScreen extends StatefulWidget {
  const VerifyPhoneNumberScreen({super.key});

  @override
  State<VerifyPhoneNumberScreen> createState() =>
      _VerifyPhoneNumberScreenState();
}

class _VerifyPhoneNumberScreenState extends State<VerifyPhoneNumberScreen> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Phone Number"),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: otpController,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "6-Digit OTP",
                      counterText: ""),
                ),
                SizedBox(
                  height: 15,
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if(state is AuthLoggedInState){
                      Navigator.popUntil(context,(route) => route.isFirst,);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                    }
                    else if(state is AuthErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error),
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 2),
                        )
                      );
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
                          BlocProvider.of<AuthCubit>(context).verifyOTP(otpController.text);
                        },
                        color: Colors.blue,
                        child: Text("Verify"),
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
