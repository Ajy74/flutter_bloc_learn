import 'package:bloc_learn/sign_in/bloc/sign_in_event.dart';
import 'package:bloc_learn/sign_in/bloc/sign_in_state.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigInBloc extends Bloc<SignInEvent,SignInState>{
  SigInBloc() : super(SignInInitialState()){
    on<SigInTextChangedEvent>((event, emit) {
        if(EmailValidator.validate(event.emailValue) == false){
          emit( SignInErrorState("Please enter a valid email address!") );
        }
        else if(event.passwordValue.length < 8){
           emit( SignInErrorState("Please enter a valid 8 characters password!") );
        }
        else{
          emit( SignInValidState() );
        }
    });

    on<SignInSubmittedEvent>((event, emit) {
      emit( SignInLoadingState() );
    });
  }
}