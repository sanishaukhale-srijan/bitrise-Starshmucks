abstract class SigninEvent {}

class SigninpassChangedEvent extends SigninEvent {
  String passwordvalue = '';

  SigninpassChangedEvent(this.passwordvalue);
}

class SigninemailChangedEvent extends SigninEvent {
  String emailvalue = '';

  SigninemailChangedEvent(this.emailvalue);
}

class SigninSumittedEvent extends SigninEvent {
  String? email;
  String? password;

  SigninSumittedEvent(
    this.email,
    this.password,
  );
}

class SignupRedirect extends SigninEvent {}
