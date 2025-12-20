import 'package:chat_app/common/utils/custom_snack_bar.dart';
import 'package:chat_app/common/utils/validators.dart';
import 'package:chat_app/common/widgets/custom_text_form_field.dart';
import 'package:chat_app/features/chat/presentation/bloc/room_bloc/room_bloc.dart';
import 'package:chat_app/features/chat/presentation/screen/chat_room_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateRoomDialogue extends StatefulWidget {
  const CreateRoomDialogue({super.key});

  @override
  State<CreateRoomDialogue> createState() => _CreateRoomDialogueState();
}

class _CreateRoomDialogueState extends State<CreateRoomDialogue> {
  final _userNameController = TextEditingController();
  final _roomNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _userNameController.dispose();
    _roomNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoomBloc, RoomState>(
      listener: (context, state) {
        if (state.status == RoomStatus.roomCreateSuccess) {
          CustomSnackbar.show(context, state.message, SnackbarType.success);
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatRoomScreen()),
          );
        } else if (state.status == RoomStatus.error) {
          CustomSnackbar.show(context, state.message, SnackbarType.error);
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return state.status == RoomStatus.loading
            ? AlertDialog(
                content: SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(child: CircularProgressIndicator()),
                ),
              )
            : AlertDialog(
                backgroundColor: Colors.white,
                title: const Text('Create Room'),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 20,
                    children: <Widget>[
                      CustomTextFormField(
                        controller: _userNameController,
                        label: Text('Name'),
                        hintText: 'Enter your name',
                        validator: (value) =>
                            Validators.validateUsername(value),
                      ),
                      CustomTextFormField(
                        controller: _roomNameController,
                        label: Text('Room Name'),
                        hintText: 'Enter room name',
                        validator: (value) =>
                            Validators.validateRoomName(value),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Create'),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<RoomBloc>().add(
                          CreateRoomEvent(
                            roomName: _roomNameController.text.trim(),
                            username: _userNameController.text.trim(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              );
      },
    );
  }
}
