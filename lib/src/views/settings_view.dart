import 'package:flutter/material.dart';

import 'package:maali/src/app_builder.dart';
import 'package:maali/src/app_controller.dart';
import 'package:maali/src/app_security.dart';
import 'package:maali/src/widgets/app_drawer_widget.dart';
import 'package:maali/src/widgets/app_topbar_widget.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatefulWidget {
  const SettingsView({Key? key, required this.controller}) : super(key: key);

  static const viewName = 'settings';
  static const viewIndex = 2;

  final AppController controller;

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final GlobalKey<ScaffoldState> _settingsKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double opacity = 1;
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        key: _settingsKey,
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
                    title: AppStyler.appTitle(context),
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
        body: SingleChildScrollView(
            child: Center(

                /// Center is a layout widget. It takes a single child and positions
                /// it in the middle of the parent.
                /// controller: _scrollController,
                /// physics: const ClampingScrollPhysics(),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
              Container(
                  // body-container with fixed height.
                  color: null,
                  child: SizedBox(
                      height: screenSize.height * 0.88,
                      width: screenSize.width,
                      child: Row(children: [
                        Expanded(
                            child: Column(children: [
                          SizedBox(height: screenSize.height * 0.01),
                          ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth: screenSize.width * 0.97),
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
                                      Text('SETTINGS',
                                          style: AppStyler.headerStyle(context))
                                    ]),
                                    Container(
                                      width: double.infinity,
                                      height: screenSize.height * 0.151,
                                      decoration: BoxDecoration(
                                          color: AppStyler.themeData(context)
                                              .canvasColor),
                                      child: Center(
                                          child: DropdownButton<ThemeMode>(
                                        // Read the selected themeMode from the controller
                                        value: widget.controller.themeMode,
                                        // Call the updateThemeMode method any time the user selects a theme.
                                        onChanged:
                                            widget.controller.updateThemeMode,
                                        items: const [
                                          DropdownMenuItem(
                                            value: ThemeMode.system,
                                            child: Text('System Theme'),
                                          ),
                                          DropdownMenuItem(
                                            value: ThemeMode.light,
                                            child: Text('Light Theme'),
                                          ),
                                          DropdownMenuItem(
                                            value: ThemeMode.dark,
                                            child: Text('Dark Theme'),
                                          )
                                        ],
                                      )),
                                    ),
                                  ])))
                        ]))
                      ])))
            ]))));
  }
}
