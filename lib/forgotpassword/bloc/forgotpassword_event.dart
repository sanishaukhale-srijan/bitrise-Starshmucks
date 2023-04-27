abstract class ForgotpasswordEvent {}

class ForgotpasswordInputChangedEvent extends ForgotpasswordEvent {
  String inputvalue = '';

  ForgotpasswordInputChangedEvent(
    this.inputvalue,
  );
}

class ForgotpasswordSumittedEvent extends ForgotpasswordEvent {
  String? input;

  ForgotpasswordSumittedEvent(
    this.input,
  );
}
