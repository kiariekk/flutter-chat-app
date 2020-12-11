import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/core/entities/add_contact_params.dart';
import 'package:flutter_chat_app/presentation/blocs/add_contact/add_contact_bloc.dart';
import 'package:flutter_chat_app/presentation/themes/app_colors.dart';
import 'package:flutter_chat_app/presentation/widgets/app_text_field.dart';
import 'package:flutter_chat_app/presentation/widgets/primary_button.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key key}) : super(key: key);

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add contact'),
      ),
      body: BlocProvider(
        create: (context) => AddContactBloc(),
        child: BlocBuilder<AddContactBloc, AddContactState>(
          builder: (context, state) {
            if (state is AddContactFinished) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pop();
              });
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AppFormField(
                          label: 'Name',
                          onSaved: (value) => _name = value,
                        ),
                        AppFormField(
                          label: 'Email',
                          onSaved: (value) => _email = value,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  if (state is AddContactError) ...[
                    Text(
                      state.message,
                      style: TextStyle(
                        color: AppColors.errorColor,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                  PrimaryButton(
                    text: 'Add',
                    onPressed: () => _submit(context),
                    isLoading: state is AddContactLoading,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    final form = _formKey.currentState;
    if (!form.validate()) return;
    form.save();
    BlocProvider.of<AddContactBloc>(context, listen: false).add(
      AddContactAddEvent(AddContactParams(
        name: _name,
        email: _email,
      )),
    );
  }
}
