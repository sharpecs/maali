import 'package:flutter/material.dart';

import 'package:maali/src/app_builder.dart';
import 'package:maali/src/app_controller.dart';
import 'package:maali/src/app_model.dart';

import 'package:maali/src/widgets/sample_dialog_widget.dart';

/// Displays a list of SampleItems.
///
class RadList extends StatefulWidget {
  const RadList({Key? key, required this.controller}) : super(key: key);

  static const viewName = 'sample_list';
  static const viewIndex = 1;

  final AppController controller;

  @override
  State<RadList> createState() => _MenuListState();
}

class _MenuListState extends State<RadList> {
  final List<SampleItem> items = const [
    SampleItem(1),
    SampleItem(2),
    SampleItem(3)
  ];

  // This list holds the data for the list view
  List<SampleItem> _foundSamples = [];

  @override
  initState() {
    // at the beginning, all users are shown
    _foundSamples = items;

    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<SampleItem> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = items;
    } else {
      // results = widget.controller.transactions.reversed
      //     .where((reading) => reading.systolic == 146)
      //     // reading["systolic"].toLowerCase().contains(enteredKeyword.toLowerCase()))
      //     .toList();
    }

    // Refresh the UI
    setState(() {
      _foundSamples = results;
    });
  }

  void _handleSampleDialog(SampleItem s) {
    widget.controller.saveApplication();
    _runFilter('');
  }

  void _manageSampleAction(BuildContext c, SampleItem s) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return DialogSampleWidget(
            mContext: c, item: s, onChanged: _handleSampleDialog);
      },
    );
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
              child: Row(children: [
                Expanded(
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Wrap(children: [
                          ConstrainedBox(
                              // for spacing.
                              constraints: BoxConstraints(
                                  maxWidth: screenSize.width * 0.75),
                              child: Row(children: [
                                SizedBox(height: screenSize.height * 0.01),
                              ])),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth: screenSize.width * 0.75),
                            child: Row(children: <Widget>[
                              Flexible(
                                  child: TextField(
                                      onChanged: (value) => _runFilter(value),
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          labelText: 'Search Samples',
                                          suffixIcon: Icon(Icons.search)))),
                            ]),
                          ),
                          ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth: screenSize.width * 0.75,
                                  maxHeight: screenSize.height * 0.73),
                              child: _foundSamples.isNotEmpty
                                  ? ListView.builder(
                                      restorationId: 'sampleItemListView',
                                      itemCount: items.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final item = items[index];

                                        return Card(
                                            key: ValueKey(
                                                _foundSamples[index].id),
                                            color: AppStyler.themeData(context)
                                                .backgroundColor,
                                            elevation: 4,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 1),
                                            child: ListTile(
                                                title: Text(
                                                    'SampleItem ${item.id}'),
                                                leading: const CircleAvatar(
                                                  // Display the Flutter Logo image asset.
                                                  foregroundImage: AssetImage(
                                                      'assets/images/flutter_logo.png'),
                                                ),
                                                onTap: () {
                                                  // Navigate to the details page. If the user leaves and returns to
                                                  // the app after it has been killed while running in the
                                                  // background, the navigation stack is restored.
                                                  _manageSampleAction(context,
                                                      _foundSamples[index]);
                                                }));
                                      })
                                  : const Text(
                                      'No Results Found',
                                      style: TextStyle(fontSize: 24),
                                    )),
                          SizedBox(height: screenSize.height * 0.01),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth: screenSize.width * 0.75),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    style: AppStyler.appButton(context),
                                    onPressed: () {
                                      _manageSampleAction(
                                          context, const SampleItem(1));
                                    },
                                    child: const Icon(Icons.add),
                                  )
                                ]),
                          ),
                        ])))
              ]))
        ]));
  }
}
