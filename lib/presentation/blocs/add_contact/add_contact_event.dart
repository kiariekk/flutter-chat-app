part of 'add_contact_bloc.dart';

@immutable
abstract class AddContactEvent {}

class AddContactAddEvent extends AddContactEvent {
  final AddContactParams params;

  AddContactAddEvent(this.params);
}
