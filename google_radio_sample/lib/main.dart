import 'package:flutter/material.dart';

/// Flutter code sample for [Radio].

void main() => runApp(const RadioExampleApp());

class RadioExampleApp extends StatelessWidget {
  const RadioExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Radio Sample')),
        body: const Center(child: RadioExample()),
      ),
    );
  }
}

class RadioExample extends StatefulWidget {
  const RadioExample({super.key});

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  @override
  Widget build(BuildContext context) {
    List<List<String>> radioGroups = _getRadioGroupDefinitionsFromUser();
    return Column(
      children: [
        ..._getListTiles(radioGroups),

        TextButton(
          onPressed: () {
            print('Submit button pressed.');

            for (int i = 0; i < radioGroups.length; i++) {
              print(
                'Selected value for radioGroup $i: ${radioGroupSelectedValueMapping[i]}',
              );
            }
          },
          child: Text('Submit'),
        ),
      ],
    );
  }

  Map<int, String> radioGroupSelectedValueMapping = {};
  List<Widget> _getListTiles(List<List<String>> radioGroups) {
    List<Widget> radioGroupList = [];

    for (int i = 0; i < radioGroups.length; i++) {
      List<String> radioGroup = radioGroups[i];
      List<Widget> radioListTileList = [];
      for (String radio in radioGroup) {
        radioListTileList.add(
          ListTile(
            title: Text(radio),
            leading: Radio<String>(
              value: radio,
              groupValue: radioGroupSelectedValueMapping[i],
              onChanged: (String? value) {
                setState(() {
                  radioGroupSelectedValueMapping[i] = value!;
                  print('Selected value for radioGroup $i: $value');
                });
              },
            ),
          ),
        );
      }
      radioGroupList.add(Divider());
      radioGroupList.add(Column(children: radioListTileList));
    }

    return radioGroupList;
  }

  List<List<String>> _getRadioGroupDefinitionsFromUser() {
    List<String> fruits = ['Apple', 'Banana', 'Orange'];
    List<String> colors = ['Red', 'Green', 'Blue', 'Yellow'];
    return [fruits, colors];
  }
}
