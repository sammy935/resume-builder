import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultiSelectDialog extends StatefulWidget {
  const MultiSelectDialog(
      {Key? key, required this.elements, required this.selectedElements})
      : super(key: key);

  final List<String> elements;
  final List<String>? selectedElements;

  @override
  State<MultiSelectDialog> createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  List<String> sElements = <String>[];

  @override
  void initState() {
    sElements = widget.selectedElements ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ListView.builder(
          itemCount: widget.elements.length + 1,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index == widget.elements.length) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back(result: sElements);
                    },
                    child: Text('SUBMIT'),
                  ),
                ],
              );
            } else {
              String item = widget.elements[index];
              return ListTile(
                title: Text(item),
                onTap: () {
                  int index = sElements.indexWhere((e) => e == item);
                  if (index <= -1) {
                    sElements.add(item);
                  } else {
                    sElements.removeAt(index);
                  }
                  setState(() {});
                },
                trailing: sElements.any((element) => element == item)
                    ? const Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : const SizedBox.shrink(),
              );
            }
          }),
    );
  }
}
