import 'package:flutter/material.dart';
import 'package:swaptime_flutter/generated/l10n.dart';

class ReportDialog extends StatelessWidget {
  final Function() onConfirm;
  final Function() onCancel;

  ReportDialog({
    @required this.onConfirm,
    @required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Row(
          children: [
            Text(S.of(context).reportDialog),
          ],
        ),
        Row(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: S.of(context).reportReason,
                labelText: S.of(context).reason,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              child: Text(S.of(context).cancel),
              onPressed: () {
                onCancel();
              },
            ),
            RaisedButton(
              color: Colors.red,
              child: Text(S.of(context).report),
              onPressed: () {
                onConfirm();
              },
            ),
          ],
        )
      ],
    );
  }
}
