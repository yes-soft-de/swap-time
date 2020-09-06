import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'package:swaptime_flutter/theme/theme_data.dart';

@provide
class AddByImageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddByImageScreenState();
}

class _AddByImageScreenState extends State<AddByImageScreen> {
  final Set _tagList = {};
  final TextEditingController _gameName = TextEditingController();
  final TextEditingController _tagName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String filePath = ModalRoute.of(context).settings.arguments;
    print('filePath: ' + filePath);

    return Scaffold(
      body: Flex(
        direction: Axis.vertical,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(filePath), fit: BoxFit.cover),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _gameName,
                          decoration: InputDecoration(
                            hintText: 'GTA V',
                            labelText: 'Game Name',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(
                                0xFF7F7F7F,
                              ),
                            ),
                          ),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _tagName,
                                decoration: InputDecoration(
                                  hintText: 'Tags',
                                  labelText: 'Racing',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(
                                      0xFF7F7F7F,
                                    ),
                                  ),
                                ),
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: SwapThemeData.getPrimary(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90)),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                onPressed: _tagName.text.isEmpty
                                    ? null
                                    : () {
                                        _tagList.add(_tagName.text);
                                        setState(() {});
                                      },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black12,
                        child: _getTagChips().isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Wrap(
                                  children: _getTagChips(),
                                ),
                              )
                            : Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Tag List Here'),
                                  )
                                ],
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'My game is an awesome game',
                            labelText: 'Description',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(
                                0xFF7F7F7F,
                              ),
                            ),
                          ),
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  color: SwapThemeData.getPrimary(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Submit Game!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getTagChips() {
    List<Widget> chips = [];
    _tagList.forEach((element) {
      chips.add(Padding(
        padding: const EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
        child: Chip(
          label: Text(
            element,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black45,
        ),
      ));
    });
    return chips;
  }
}
