import 'package:flutter/material.dart';

import 'package:maali/src/app_builder.dart';
import 'package:maali/src/app_controller.dart';

/// Displays a list of SampleItems.
///
class RadBlank extends StatefulWidget {
  const RadBlank({Key? key, required this.controller}) : super(key: key);

  final AppController controller;

  @override
  State<RadBlank> createState() => _MenuBlankState();
}

class _MenuBlankState extends State<RadBlank> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Center(
        // Center is a layout widget. It takes a single child and
        // positions it in the middle of the parent.
        // controller: _scrollController,
        // physics: const ClampingScrollPhysics(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Container(
              // body-container with fixed height.
              color: null,
              child: SizedBox(
                  height: screenSize.height * 0.80,
                  width: screenSize.width,
                  child: Row(children: [
                    // side menu
                    // AppRadbar(controller: widget.controller),
                    // end side-menu
                    Expanded(
                        child: Column(children: [
                      SizedBox(height: screenSize.height * 0.01),
                      // first-box
                      ConstrainedBox(
                          constraints:
                              BoxConstraints(maxWidth: screenSize.width * 0.75),
                          // maxHeight: screenSize.height * 0.18),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppStyler.themeData(context)
                                    .primaryColorDark,
                              ),
                              child: Column(children: [
                                Row(children: [
                                  const Text(' ',
                                      style: TextStyle(height: 1.5)),
                                  Text('LANDING PAGE',
                                      style: AppStyler.headerStyle(context))
                                ]),
                                Container(
                                    width: double.infinity,
                                    height: screenSize.height * 0.15,
                                    decoration: BoxDecoration(
                                        color: AppStyler.themeData(context)
                                            .canvasColor),
                                    child: const Text('TEXT')),
                              ])))
                      // end-first-box
                    ]))
                  ])))
        ]));
  }
}
