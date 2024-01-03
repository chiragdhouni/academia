import 'package:flutter/material.dart';


class ToggleButton extends StatefulWidget {
  final VoidCallback _sendTextMessage;
  final bool _isReplying;
  const ToggleButton({
    super.key,
    required VoidCallback sendTextMessage,
    required bool isReplying,
  })  :  _sendTextMessage = sendTextMessage,
_isReplying = isReplying
         ;

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(15),
      ),
      onPressed: widget._sendTextMessage
      ,
      child: Icon(
            Icons.send
      ),
    );
  }
}
