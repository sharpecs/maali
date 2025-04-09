import 'package:flutter/material.dart';
import 'package:maali/src/app_builder.dart';

class AppLowBarWidget extends StatelessWidget {
  const AppLowBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Column smallScreenCol = Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            BarColumn(
              heading: 'ABOUT',
              s1: 'Contact Us',
              s2: 'About Us',
              s3: 'Careers',
            ),
            BarColumn(
              heading: 'HELP',
              s1: 'Payment',
              s2: 'Cancellation',
              s3: 'FAQ',
            ),
            BarColumn(
              heading: 'SOCIAL',
              s1: 'Twitter',
              s2: 'Facebook',
              s3: 'YouTube',
            ),
          ],
        ),
        const Divider(
          color: Colors.blueGrey,
        ),
        const SizedBox(height: 20),
        InfoText(
          type: 'Email',
          text: 'explore@gmail.com',
        ),
        const SizedBox(height: 5),
        InfoText(
          type: 'Address',
          text: '128, Trymore Road, Delft, MN - 56124',
        ),
        const SizedBox(height: 20),
        const Divider(
          color: Colors.blueGrey,
        ),
        const SizedBox(height: 20),
        Text(
          'Copyright © 2020 | EXPLORE',
          style: TextStyle(
            color: Colors.blueGrey.shade300,
            fontSize: 14,
          ),
        ),
      ],
    );

    // ignore: unused_local_variable
    Column largeScreenCol = Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const BarColumn(
              heading: 'ABOUT',
              s1: 'Contact Us',
              s2: 'About Us',
              s3: 'Careers',
            ),
            const BarColumn(
              heading: 'HELP',
              s1: 'Payment',
              s2: 'Cancellation',
              s3: 'FAQ',
            ),
            const BarColumn(
              heading: 'SOCIAL',
              s1: 'Twitter',
              s2: 'Facebook',
              s3: 'YouTube',
            ),
            Container(
              color: Colors.blueGrey,
              width: 2,
              height: 150,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoText(
                  type: 'Email',
                  text: 'explore@gmail.com',
                ),
                const SizedBox(height: 5),
                InfoText(
                  type: 'Address',
                  text: '128, Trymore Road, Delft, MN - 56124',
                )
              ],
            ),
          ],
        ),
        const Divider(
          color: Colors.blueGrey,
        ),
        const SizedBox(height: 20),
        Text(
          'Copyright © 2020 | EXPLORE',
          style: TextStyle(
            color: Colors.blueGrey.shade300,
            fontSize: 14,
          ),
        ),
      ],
    );

    return Container(
        padding: const EdgeInsets.all(30),
        color: Colors.blueGrey[900],
        child: AppFlexer.isSmallScreen(context)
            ? Column(children: [
                const Divider(
                  color: Color.fromARGB(255, 38, 50, 56),
                ),
                const SizedBox(height: 20),
                Text(
                  'Copyright © 2020 | EXPLORE',
                  style: TextStyle(
                    color: Colors.blueGrey.shade300,
                    fontSize: 14,
                  ),
                ),
              ])
            : Expanded(
                flex: 1,
                child: Column(children: [
                  const Divider(
                    color: Color.fromARGB(255, 38, 50, 56),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Copyright © 2020 | EXPLORE',
                    style: TextStyle(
                      color: Colors.blueGrey.shade300,
                      fontSize: 14,
                    ),
                  ),
                ])));
  }
}

class InfoText extends StatelessWidget {
  final String type;
  final String text;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  InfoText({required this.type, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$type: ',
          style: TextStyle(
            color: Colors.blueGrey.shade300,
            fontSize: 16,
          ),
        ),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.blueGrey.shade100,
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }
}

class BarColumn extends StatelessWidget {
  final String heading;
  final String s1;
  final String s2;
  final String s3;

  // ignore: use_key_in_widget_constructors
  const BarColumn({
    required this.heading,
    required this.s1,
    required this.s2,
    required this.s3,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(
              color: Colors.blueGrey[300],
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            s1,
            style: TextStyle(
              color: Colors.blueGrey[100],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            s2,
            style: TextStyle(
              color: Colors.blueGrey[100],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            s3,
            style: TextStyle(
              color: Colors.blueGrey[100],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
