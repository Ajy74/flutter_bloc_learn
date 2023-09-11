import 'dart:math';

import 'package:bloc_learn/phone_auth/Cubit/auth_cubit.dart';
import 'package:bloc_learn/phone_auth/Cubit/auth_state.dart';
import 'package:bloc_learn/phone_auth/phone_sigin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            width: double.maxFinite,
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if(state is AuthLoggedOutState){
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const PhoneSignInScreen()));
                }
              },
              builder: (context, state) {
                if(state is AuthLoadingState){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return CupertinoButton(
                  onPressed: () {
                    playAudio();
                    // BlocProvider.of<AuthCubit>(context).logOut();
                  },
                  color: Colors.blue,
                  child: Text("Logout"),
                );
              },
            ),
          )
        ],
      )),
    );
  }

  //audio generating function
  List<double> generateTone(double frequency, double duration, double amplitude, int sampleRate) {
    final samples = <double>[];
    for (var i = 0; i < (sampleRate * duration).round(); i++) {
      final time = i / sampleRate;
      final value = amplitude * sin(2 * pi * frequency * time);
      samples.add(value);
    }
    return samples;
  }

  playAudio() async{
  final toneFrequency = 1000.0; // Frequency in Hz
  final toneDuration = 1.0;     // Duration in seconds
  final toneAmplitude = 0.5;    // Amplitude (volume)

  final sampleRate = 44100;     // Common audio sample rate

  final generatedTone = generateTone(toneFrequency, toneDuration, toneAmplitude, sampleRate);

  // Convert the generated tone to a list of integers
  final toneData = generatedTone.map((value) => (value * 32767.0).toInt()).toList();

  // Initialize the audio player
  final player = AudioPlayer();

  // Load the generated tone into an AudioSource
  final buffer = toneData;
  final data = AudioSource.uri(
    Uri.dataFromBytes(buffer),
    // mimeType: 'audio/wav',
  );

  // Set the audio source for the player
  await player.setAudioSource(data);

  // Play the tone
  player.play();

  // Wait for the tone to finish playing
  await Future.delayed(Duration(seconds: toneDuration.ceil() + 1));

  // Dispose the player
  player.dispose();
  }

}
