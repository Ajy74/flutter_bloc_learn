import 'package:bloc_learn/blocs/internet_bloc/internet_bloc.dart';
import 'package:bloc_learn/phone_auth/Cubit/auth_cubit.dart';
import 'package:bloc_learn/phone_auth/Cubit/auth_state.dart';
import 'package:bloc_learn/phone_auth/home_screen.dart';

import 'package:bloc_learn/phone_auth/phone_sigin_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // // This widget is the root of your application.
  // @override
  // Widget build(BuildContext context) {
  //   return BlocProvider(
  //     create: (context) => InternetBloc(),
  //     child: MaterialApp(
  //       title: 'Learn Bloc',
  //       debugShowCheckedModeBanner: false,
  //       theme: ThemeData(
  //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  //         useMaterial3: true,
  //       ),
  //       home: const PhoneSignInScreen(),
  //     ),
  //   );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        title: 'Learn Bloc',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (oldState, newState) {
            return oldState is AuthInitialState;
          },
          builder: (context, state) {
            if(State is AuthLoggedOutState){
               return const PhoneSignInScreen();
            }
            else if(state is AuthLoggedInState){
              return const HomeScreen();
            }
            else{
               return const PhoneSignInScreen();
            }
          },
        ),
      ),
    );
  }

}
