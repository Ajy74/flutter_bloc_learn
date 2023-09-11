abstract class SignInState{}

class SignInInitialState extends SignInState{}

class SignInValidState extends SignInState{}

class SignInErrorState extends SignInState{
  final String errorMsg;
  SignInErrorState(this.errorMsg);
}

class SignInLoadingState extends SignInState{}