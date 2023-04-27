import '/model/user_model.dart';

abstract class SignupEvent {}

class SignupSumittedEvent extends SignupEvent {
  late UserModel userdata;

  SignupSumittedEvent(this.userdata);
}
