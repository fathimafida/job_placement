import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class DescriptionSheetField extends StatefulWidget {
  DescriptionSheetField({
    super.key,
    required TextEditingController descriptionController,
    required this.onSaved,
  }) : _descriptionController = descriptionController;

  final TextEditingController _descriptionController;
  final Function(String?) onSaved;

  @override
  State<DescriptionSheetField> createState() => _DescriptionSheetFieldState();
}

class _DescriptionSheetFieldState extends State<DescriptionSheetField> {
  final QuillController _controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WoltModalSheet.show(
            context: context,
            pageListBuilder: (ctx) {
              return [
                WoltModalSheetPage(
                  stickyActionBar: FilledButton(
                    onPressed: () {
                      final jsonData =
                          jsonEncode(_controller.document.toDelta().toJson());
                      widget.onSaved(jsonData);
                      log(jsonData);
                      Navigator.of(context).pop();
                    },
                    child: const Text("Save"),
                  ),
                  forceMaxHeight: true,
                  topBarTitle: const Text("Description"),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        QuillToolbar.simple(
                          configurations: QuillSimpleToolbarConfigurations(
                            controller: _controller,
                            sharedConfigurations:
                                const QuillSharedConfigurations(
                              locale: Locale('de'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: QuillEditor.basic(
                            configurations: QuillEditorConfigurations(
                              controller: _controller,
                              readOnly: false,
                              sharedConfigurations:
                                  const QuillSharedConfigurations(
                                locale: Locale('de'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ];
            });
      },
      child: TextFormField(
          maxLength: 1000,
          enabled: false,
          onTap: () {},
          controller: widget._descriptionController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'description',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          }),
    );
  }
}
