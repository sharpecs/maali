import 'package:flutter/material.dart';
import 'package:maali/src/app_builder.dart';

import 'package:maali/src/app_controller.dart';
import 'package:maali/src/app_router.dart';
import 'package:maali/src/views/admin_view.dart';

class AppTopBarWidget extends StatefulWidget {
  const AppTopBarWidget(
      {Key? key, required this.opacity, required this.controller})
      : super(key: key);

  final AppController controller;

  final double opacity;

  @override
  State<AppTopBarWidget> createState() => _AppTopBarWidgetState();
}

class _AppTopBarWidgetState extends State<AppTopBarWidget> {
  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  final List _isSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    _isSelected[widget.controller.routerIndex] = true;

    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: Container(
        color: Theme.of(context)
            .colorScheme
            .primaryContainer
            .withOpacity(widget.opacity),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.appTitle,
                style: TextStyle(
                  color: Colors.blueGrey.shade100,
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: screenSize.width / 8),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[LandingView.viewIndex] = true
                              : _isHovering[LandingView.viewIndex] = false;
                        });
                      },
                      onTap: () => {
                        _isSelected.replaceRange(0, _isSelected.length,
                            _isSelected.map((element) => false)),
                        widget.controller.routerIndex = LandingView.viewIndex,
                        _isSelected[LandingView.viewIndex] = true
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Home',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                color: _isSelected[LandingView.viewIndex]
                                    ? AppStyler.themeData(context).hoverColor
                                    : _isHovering[LandingView.viewIndex]
                                        ? AppStyler.themeData(context)
                                            .hoverColor
                                        : Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer),
                          ),
                          const SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[LandingView.viewIndex],
                            child: Container(
                              height: 2,
                              width: 20,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: screenSize.width / 20),
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[SampleItemListView.viewIndex] = true
                              : _isHovering[SampleItemListView.viewIndex] =
                                  false;
                        });
                      },
                      onTap: () => {
                        _isSelected.replaceRange(0, _isSelected.length,
                            _isSelected.map((element) => false)),
                        widget.controller.routerIndex =
                            SampleItemListView.viewIndex,
                        _isSelected[SampleItemListView.viewIndex] = true
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Samples',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                color: _isSelected[SampleItemListView.viewIndex]
                                    ? AppStyler.themeData(context).hoverColor
                                    : _isHovering[SampleItemListView.viewIndex]
                                        ? AppStyler.themeData(context)
                                            .hoverColor
                                        : Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer),
                          ),
                          const SizedBox(height: 5),
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            maintainSize: true,
                            visible: _isHovering[SampleItemListView.viewIndex],
                            child: Container(
                              height: 2,
                              width: 20,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    if (widget.controller.accessManager.authToSave) ...[
                      SizedBox(width: screenSize.width / 20),
                      InkWell(
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[AdminView.viewIndex] = true
                                : _isHovering[AdminView.viewIndex] = false;
                          });
                        },
                        onTap: () => {
                          _isSelected.replaceRange(0, _isSelected.length,
                              _isSelected.map((element) => false)),
                          widget.controller.routerIndex = AdminView.viewIndex,
                          _isSelected[AdminView.viewIndex] = true
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Admin',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  color: _isSelected[AdminView.viewIndex]
                                      ? AppStyler.themeData(context).hoverColor
                                      : _isHovering[AdminView.viewIndex]
                                          ? AppStyler.themeData(context)
                                              .hoverColor
                                          : Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer),
                            ),
                            const SizedBox(height: 5),
                            Visibility(
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              visible: _isHovering[AdminView.viewIndex],
                              child: Container(
                                height: 2,
                                width: 20,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: screenSize.width / 20),
                      InkWell(
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[SettingsView.viewIndex] = true
                                : _isHovering[SettingsView.viewIndex] = false;
                          });
                        },
                        onTap: () => {
                          _isSelected.replaceRange(0, _isSelected.length,
                              _isSelected.map((element) => false)),
                          widget.controller.routerIndex =
                              SettingsView.viewIndex,
                          _isSelected[SettingsView.viewIndex] = true
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Settings',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  color: _isSelected[SettingsView.viewIndex]
                                      ? AppStyler.themeData(context).hoverColor
                                      : _isHovering[SettingsView.viewIndex]
                                          ? AppStyler.themeData(context)
                                              .hoverColor
                                          : Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer),
                            ),
                            const SizedBox(height: 2),
                            Visibility(
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              visible: _isHovering[SettingsView.viewIndex],
                              child: Container(
                                height: 2,
                                width: 20,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
