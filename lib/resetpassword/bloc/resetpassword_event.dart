abstract class ResetpasswordEvent {}

class PasswordChangedEvent extends ResetpasswordEvent {
  String newpassword = '';

  PasswordChangedEvent(this.newpassword);
}

class ConfirmpasswordChangedEvent extends ResetpasswordEvent {
  String newpassword = '';
  String confirmpassword = '';

  ConfirmpasswordChangedEvent(this.newpassword, this.confirmpassword);
}

class ResetpasswordSubmittedEvent extends ResetpasswordEvent {}
