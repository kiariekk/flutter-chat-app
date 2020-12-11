part of 'add_contact_bloc.dart';

@immutable
abstract class AddContactState {}

class AddContactInitial extends AddContactState {}

class AddContactLoading extends AddContactState {}

class AddContactError extends AddContactState {
  final String message;

  AddContactError(this.message);
}

class AddContactFinished extends AddContactState {}
