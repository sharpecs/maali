import 'package:flutter/material.dart';

import 'package:maali/src/app_builder.dart';
import 'package:maali/src/app_controller.dart';
import 'package:maali/src/app_security.dart';
import 'package:maali/src/views/radbar/rad_list_view.dart';
import 'package:maali/src/widgets/app_drawer_widget.dart';
import 'package:maali/src/widgets/app_topbar_widget.dart';

class LandingView extends StatefulWidget {
  const LandingView({Key? key, required this.controller}) : super(key: key);

  static const viewName = 'home';
  static const viewIndex = 0;

  final AppController controller;

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  final GlobalKey<ScaffoldState> _landingKey = GlobalKey<ScaffoldState>();

  // ignore: unused_field
  late Widget _menuWidget;

  @override
  initState() {
    _menuWidget = RadList(controller: widget.controller);
    super.initState();
  }

  // ignore: unused_element
  void _setMenuWidget(Widget item) {
    _menuWidget = item;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double opacity = 1;
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        key: _landingKey,
        appBar: widget.controller.accessManager.aMode != AppMode.mobile
            ? AppFlexer.isSmallScreen(context)
                ? AppBar(elevation: 0, title: AppStyler.appTitle(context))
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
                        // side menu
                        // AppFlexer.isSmallScreen(context)
                        //     ? const Text('')
                        //     : // side menu
                        //     AppRadbar(
                        //         controller: widget.controller,
                        //         onChanged: _setMenuWidget,
                        //         opacity: opacity,
                        //       ),
                        // end side-menu
                        Expanded(
                            child: Column(children: [
                          SizedBox(height: screenSize.height * 0.01),
                          // radbar-box
                          // ConstrainedBox(
                          //     constraints: BoxConstraints(
                          //         maxWidth: screenSize.width * 0.97),
                          //     // maxHeight: screenSize.height * 0.18),
                          //     child: Container(
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(5),
                          //           color: AppStyler.themeData(context)
                          //               .primaryColorDark,
                          //         ),
                          //         child: Column(children: [
                          //           Container(
                          //               width: double.infinity,
                          //               // height: screenSize.height * 0.15,
                          //               decoration: BoxDecoration(
                          //                   color: AppStyler.themeData(context)
                          //                       .canvasColor),
                          //               child: _menuWidget),
                          //         ]))),
                          // end-radbar-box
                          // first-box
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
            ]))));
  }
}
