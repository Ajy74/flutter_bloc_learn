import 'package:bloc_learn/sign_in/bloc/sign_in_bloc.dart';
import 'package:bloc_learn/sign_in/sign_in_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BeforeSignin extends StatelessWidget {
  const BeforeSignin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.maxFinite,
              height: 45,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => SigInBloc(),
                                  child: SigninScreen(),
                                )));
                  },
                  child: Text("Sign in")),
            ),
          ],
        ),
      ),
    );
  }
}
