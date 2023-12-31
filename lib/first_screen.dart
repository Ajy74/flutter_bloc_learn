import 'package:bloc_learn/blocs/internet_bloc/internet_bloc.dart';
import 'package:bloc_learn/blocs/internet_bloc/internet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: BlocConsumer<InternetBloc, InternetState>(
          builder: (context, state) {
            if(state is InternetGainedState)
            {
              return const Text("Connected!");
            }
            else if(state is InternetLostState)
            {
              return const Text("Not Connected !");
            }
            else{
              return const Text("Loading..");
            }
          },
          listener: (context, state) {
            if(state is InternetGainedState)
            {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Connected!"),backgroundColor: Colors.green,),
              );
            }
            else if(state is InternetLostState)
            {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Not Connected!"),backgroundColor: Colors.red,),
              );
            }
          },
        ),
      )),
    );
  }
}
