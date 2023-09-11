import 'package:bloc_learn/sign_in/bloc/sign_in_bloc.dart';
import 'package:bloc_learn/sign_in/bloc/sign_in_event.dart';
import 'package:bloc_learn/sign_in/bloc/sign_in_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            BlocBuilder<SigInBloc, SignInState>(
              builder: (context, state) {
                if (state is SignInErrorState) {
                  return Text(
                    state.errorMsg,
                    style: TextStyle(color: Colors.red),
                  );
                } else {
                  return Container();
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailController,
              onChanged: (value) {
                BlocProvider.of<SigInBloc>(context).add( SigInTextChangedEvent(emailController.text, passwordController.text) );
              },
              decoration: InputDecoration(hintText: "Email Adress"),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: passwordController,
              onChanged: (value) {
                BlocProvider.of<SigInBloc>(context).add( SigInTextChangedEvent(emailController.text, passwordController.text) );
              },
              decoration: InputDecoration(hintText: "Password"),
            ),
            const SizedBox(
              height: 22,
            ),
            Container(
              width: double.maxFinite,
              height: 50,
              child: BlocBuilder<SigInBloc, SignInState>(
                builder: (context, state) {

                  if(state is SignInLoadingState){
                    return const Center(child:  CircularProgressIndicator());
                  }

                  return CupertinoButton(
                    onPressed: () {
                       if(state is SignInValidState){
                          BlocProvider.of<SigInBloc>(context).add( SignInSubmittedEvent(emailController.text, passwordController.text) );
                       }
                    },
                    color: (state is SignInValidState )? Colors.blue :Colors.grey,
                    child: Text("Sign in"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
