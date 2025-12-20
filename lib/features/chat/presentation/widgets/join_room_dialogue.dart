import 'package:chat_app/common/utils/custom_snack_bar.dart';
import 'package:chat_app/common/utils/text_formatter_util.dart';
import 'package:chat_app/common/utils/validators.dart';
import 'package:chat_app/common/widgets/custom_text_form_field.dart';
import 'package:chat_app/features/chat/presentation/bloc/room_bloc/room_bloc.dart';
import 'package:chat_app/features/chat/presentation/screen/chat_room_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JoinRoomDialogue extends StatefulWidget {
  const JoinRoomDialogue({super.key});

  @override
  State<JoinRoomDialogue> createState() => _JoinRoomDialogueState();
}

class _JoinRoomDialogueState extends State<JoinRoomDialogue> {
  final _userNameController = TextEditingController();
  final _roomIDController = TextEditingController();
  final _roomPINController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _userNameController.dispose();
    _roomIDController.dispose();
    _roomPINController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoomBloc, RoomState>(
      listener: (context, state) {
        if (state.status == RoomStatus.roomJoinedSuccess) {
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
                title: const Text('Join Room'),
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
                        controller: _roomIDController,
                        label: Text('Room ID'),
                        hintText: 'Enter the room id',

                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[A-Za-z0-9]'),
                          ),
                          UpperCaseTextFormatter(),
                        ],
                        validator: (value) => Validators.validateRoomID(value),
                      ),
                      CustomTextFormField(
                        controller: _roomPINController,
                        label: Text('Room PIN'),
                        hintText: 'Enter the room PIN',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],

                        validator: (value) => Validators.validateRoomPIN(value),
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
                    child: const Text('Join'),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<RoomBloc>().add(
                          JoinRoomEvent(
                            roomId: _roomIDController.text.trim(),
                            userName: _userNameController.text.trim(),
                            pin: _roomPINController.text.trim(),
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
