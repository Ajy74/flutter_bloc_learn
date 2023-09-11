abstract class SignInEvent{}

class SigInTextChangedEvent extends SignInEvent{
  final String emailValue;
  final String passwordValue;
  SigInTextChangedEvent(this.emailValue,this.passwordValue);
}

class SignInSubmittedEvent extends SignInEvent{
  final String email;
  final String password;
  SignInSubmittedEvent(this.email,this.password);
}