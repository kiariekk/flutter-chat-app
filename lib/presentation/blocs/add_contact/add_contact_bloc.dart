import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/entities/add_contact_params.dart';
import 'package:flutter_chat_app/core/exceptions/add_contact_exception.dart';
import 'package:flutter_chat_app/core/services/database_service.dart';
import 'package:meta/meta.dart';

part 'add_contact_event.dart';
part 'add_contact_state.dart';

class AddContactBloc extends Bloc<AddContactEvent, AddContactState> {
  final DatabaseService databaseService;

  AddContactBloc(this.databaseService) : super(AddContactInitial());

  @override
  Stream<AddContactState> mapEventToState(
    AddContactEvent event,
  ) async* {
    if (event is AddContactAddEvent) {
      yield AddContactLoading();
      try {
        await databaseService.addChat(event.params);
        yield AddContactFinished();
      } on AddContactException catch (error) {
        yield AddContactError(error.message);
      } on Exception {
        yield AddContactError('Could not add contact. Please try again later.');
      }
    }
  }
}
