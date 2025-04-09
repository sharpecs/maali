import 'package:flutter/material.dart';
import 'package:maali/src/app_builder.dart';
import 'package:maali/src/app_controller.dart';
import 'package:maali/src/views/radbar/rad_blank_view.dart';
import 'package:maali/src/views/radbar/rad_list_view.dart';

class AppRadbar extends StatefulWidget {
  const AppRadbar({
    required this.controller,
    required this.opacity,
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final AppController controller;
  final double opacity;
  final ValueChanged<Widget> onChanged;

  @override
  State<AppRadbar> createState() => _AppRadBarState();
}

class _AppRadBarState extends State<AppRadbar> {
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
    true,
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
    return Drawer(
      child: Container(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => {null},
                child: const Text(
                  ' ',
                  // style: TextStyle(color: Colors.black, fontSize: 22),
                ),
              ),
              MenuBar(
                style: const MenuStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.transparent),
                    elevation: MaterialStatePropertyAll<double>(0),
                    shape: MaterialStatePropertyAll<ContinuousRectangleBorder>(
                        ContinuousRectangleBorder())),
                children: [
                  InkWell(
                    onHover: (value) {
                      setState(() {
                        value ? _isHovering[0] = true : _isHovering[0] = false;
                      });
                    },
                    onTap: () => {
                      _isSelected.replaceRange(0, _isSelected.length,
                          _isSelected.map((element) => false)),
                      widget.onChanged(RadBlank(controller: widget.controller)),
                      _isSelected[0] = true
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Landing Page',
                          style: TextStyle(
                              fontSize: 22,
                              color: _isSelected[0]
                                  ? AppStyler.themeData(context).hoverColor
                                  : _isHovering[0]
                                      ? AppStyler.themeData(context).hoverColor
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer),
                        ),
                        const SizedBox(height: 5),
                        Visibility(
                          maintainAnimation: true,
                          maintainState: true,
                          maintainSize: true,
                          visible: _isHovering[0],
                          child: Container(
                            height: 2,
                            width: 20,
                            color: AppStyler.themeData(context).hoverColor,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  // color: Colors.blueGrey.shade400,
                  thickness: 2,
                ),
              ),
              MenuBar(
                style: const MenuStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.transparent),
                    elevation: MaterialStatePropertyAll<double>(0),
                    shape: MaterialStatePropertyAll<ContinuousRectangleBorder>(
                        ContinuousRectangleBorder())),
                children: [
                  InkWell(
                    onHover: (value) {
                      setState(() {
                        value ? _isHovering[1] = true : _isHovering[1] = false;
                      });
                    },
                    onTap: () => {
                      _isSelected.replaceRange(0, _isSelected.length,
                          _isSelected.map((element) => false)),
                      widget.onChanged(RadList(controller: widget.controller)),
                      _isSelected[1] = true
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Samples',
                          style: TextStyle(
                              fontSize: 22,
                              color: _isSelected[1]
                                  ? AppStyler.themeData(context).hoverColor
                                  : _isHovering[1]
                                      ? AppStyler.themeData(context).hoverColor
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer),
                        ),
                        const SizedBox(height: 5),
                        Visibility(
                          maintainAnimation: true,
                          maintainState: true,
                          maintainSize: true,
                          visible: _isHovering[1],
                          child: Container(
                            height: 2,
                            width: 20,
                            color: AppStyler.themeData(context).hoverColor,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  // color: Colors.blueGrey.shade400,
                  thickness: 2,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    ' ',
                    style: TextStyle(
                      color: Colors.blueGrey.shade300,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
