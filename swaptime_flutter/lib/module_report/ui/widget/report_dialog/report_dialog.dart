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
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(S.of(context).reportDialog,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: S.of(context).reportReason,
                labelText: S.of(context).reason,
              ),
              maxLines: 4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
                  child: Text(
                    S.of(context).report,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    onConfirm();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
