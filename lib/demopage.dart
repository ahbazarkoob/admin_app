import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final MultiSelectController _controller = MultiSelectController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: MultiSelectDropDown(
              showClearIcon: true,
              controller: _controller,
              onOptionSelected: (options) {
                debugPrint(options.toString());
              },
              searchEnabled: true,
              options: const <ValueItem>[
                ValueItem(label: 'Option 1', value: '1'),
                ValueItem(label: 'Option 2', value: '2'),
                ValueItem(label: 'Option 3', value: '3'),
                ValueItem(label: 'Option 4', value: '4'),
                ValueItem(label: 'Option 5', value: '5'),
                ValueItem(label: 'Option 6', value: '6'),
              ],
              maxItems: 4,
              selectionType: SelectionType.multi,
              chipConfig: const ChipConfig(
                  wrapType: WrapType.wrap, backgroundColor: Colors.red),
              dropdownHeight: 300,
              optionTextStyle: const TextStyle(fontSize: 16),
              selectedOptionIcon: const Icon(
                Icons.check_circle,
                color: Colors.pink,
              ),
              selectedOptionTextColor: Colors.blue,
            ),
          ),
        ));
  }
}
