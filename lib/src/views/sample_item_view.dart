import 'package:flutter/material.dart';

import 'package:maali/src/app_builder.dart';
import 'package:maali/src/app_controller.dart';
import 'package:maali/src/app_model.dart';
import 'package:maali/src/app_security.dart';
import 'package:maali/src/widgets/app_drawer_widget.dart';
import 'package:maali/src/widgets/app_topbar_widget.dart';
import 'package:maali/src/widgets/sample_dialog_widget.dart';

/// Displays a list of SampleItems.
///
class SampleItemListView extends StatefulWidget {
  const SampleItemListView({Key? key, required this.controller})
      : super(key: key);

  static const viewName = 'sample_list';
  static const viewIndex = 1;

  final AppController controller;

  @override
  State<SampleItemListView> createState() => _SampleItemListState();
}

class _SampleItemListState extends State<SampleItemListView> {
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
    double opacity = 1;
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: widget.controller.accessManager.aMode != AppMode.mobile
          ? AppFlexer.isSmallScreen(context)
              ? AppBar(
                  backgroundColor:
                      widget.controller.themeMode == ThemeMode.light
                          ? AppStyler.themeData(context)
                              .primaryColorDark
                              .withOpacity(opacity)
                          : widget.controller.themeMode == ThemeMode.dark
                              ? ThemeData.dark().primaryColorDark
                              : ThemeData.light().primaryColorDark,
                  elevation: 0,
                  title: Text(
                    AppLocalizations.of(context)!.appTitle,
                    style: TextStyle(
                      color: Colors.blueGrey.shade100,
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 3,
                    ),
                  ),
                )
              : PreferredSize(
                  preferredSize: Size(screenSize.width, 1000),
                  child: AppTopBarWidget(
                    opacity: 1,
                    controller: widget.controller,
                  ), //_opacity,
                )
          : AppBar(toolbarHeight: 0),
      endDrawer: AppDrawer(controller: widget.controller),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: SingleChildScrollView(
          child: Center(
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
                                    maxWidth: screenSize.width * 0.97),
                                child: Row(children: [
                                  SizedBox(height: screenSize.height * 0.01),
                                ])),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth: screenSize.width * 0.97),
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
                                    maxWidth: screenSize.width * 0.97,
                                    maxHeight: screenSize.height * 0.76),
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
                                              color:
                                                  AppStyler.themeData(context)
                                                      .backgroundColor,
                                              elevation: 4,
                                              margin:
                                                  const EdgeInsets.symmetric(
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
                          ])))
                ]))
          ]))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _manageSampleAction(context, const SampleItem(1));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
