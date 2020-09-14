import 'package:flutter/material.dart';

class AddByApiScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddByApiState();
}

class _AddByApiState extends State<AddByApiScreen> {
  final TextEditingController _controller = TextEditingController();
  bool gameSelected = false;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: TextFormField(
                controller: _controller,
              ),
            ),
            IconButton(icon: Icon(Icons.search), onPressed: () {})
          ],
        ),
        RaisedButton(
          onPressed: () {},
          child: Text('Save Item'),
        )
      ],
    );
  }
}
