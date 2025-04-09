import 'package:flutter/material.dart';

import 'package:maali/src/app_builder.dart';
import 'package:maali/src/app_model.dart';

class DialogSampleWidget extends StatefulWidget {
  const DialogSampleWidget({
    required this.mContext,
    required this.item,
    required this.onChanged,
    Key? speciesDetailKey,
  }) : super(key: speciesDetailKey);

  final SampleItem item;
  final BuildContext mContext;
  final ValueChanged<SampleItem> onChanged;

  @override
  State<DialogSampleWidget> createState() => _DialogSampleState();
}

class _DialogSampleState extends State<DialogSampleWidget> {
  late final bool isAdd;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(widget.mContext).size;
    return SingleChildScrollView(
        child: AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 12.0),
      insetPadding: const EdgeInsets.all(10),
      content: Container(
          // body-container with fixed height.
          color: null,
          child: SizedBox(
              height: screenSize.height * 0.40,
              width: screenSize.width,
              child: Row(children: [
                Expanded(
                    child: Column(children: [
                  SizedBox(height: screenSize.height * 0.01),
                  // start-first-box
                  ConstrainedBox(
                      constraints:
                          BoxConstraints(maxWidth: screenSize.width * 0.88),
                      // maxHeight: screenSize.height * 0.39),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color:
                                AppStyler.themeData(context).primaryColorDark,
                          ),
                          child: Column(children: [
                            Row(children: [
                              const Text(' '),
                              Text(
                                'SAMPLE ITEM ${widget.item.id.toString()}',
                                style: TextStyle(
                                  color: Colors.blueGrey.shade100,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 3,
                                ),
                              )
                            ]),
                            Container(
                                width: double.infinity,
                                height: screenSize.height * 0.357,
                                decoration: BoxDecoration(
                                    color: AppStyler.themeData(context)
                                        .canvasColor),
                                child: const Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Center(
                                      child: Text('More Information Here')),
                                )),
                          ]))),
                  // end-first-box
                ]))
              ]))),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('SAVE'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('CANCEL'),
        ),
      ],
    ));
  }
}
