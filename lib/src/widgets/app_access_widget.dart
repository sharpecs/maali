import 'package:flutter/material.dart';

class AppAccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // When login button is pressed, show the Dashboard page.
    // void handleLoginPressed() => context.read<AppModel>().login();

    // Example Form, pressing the login button will show the Dashboard page
    return Center(
      // Use a maxWidth so the form is responsive, but does get not too large on bigger screens
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 450),
        // Very small screens may require vertical scrolling of the form
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(decoration: _getTextDecoration("Enter email...")),
                SizedBox(height: 16),
                TextField(
                    decoration: _getTextDecoration("Enter password..."),
                    obscureText: true),
                SizedBox(height: 16),
                OutlinedButton(
                    onPressed: null,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(16.0),
                      child: Text("Log In"),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

InputDecoration _getTextDecoration(String hint) =>
    InputDecoration(border: OutlineInputBorder(), hintText: hint);
