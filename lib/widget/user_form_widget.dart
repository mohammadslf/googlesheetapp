import 'package:flutter/material.dart';
import 'package:google_sheet_api/model/user.dart';

class UserFormWidget extends StatefulWidget {
  final User? user;
  final ValueChanged<User> onSavedUser;
  const UserFormWidget({Key? key, this.user, required this.onSavedUser})
      : super(key: key);

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController controllerName;
  late TextEditingController controllerEmail;
  late bool isBeginner;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUser();
  }

  @override
  void didUpdateWidget(covariant UserFormWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    initUser();
  }

  void initUser() {
    final name = widget.user == null ? '' : widget.user!.name;
    final email = widget.user == null ? '' : widget.user!.email;
    final isBeginner = widget.user == null ? true : widget.user!.isBeginner;

    setState(() {
      controllerName = TextEditingController(text: name);
      controllerEmail = TextEditingController(text: email);
      this.isBeginner = isBeginner!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildName(),
            SizedBox(
              height: 16,
            ),
            buildEmail(),
            SizedBox(
              height: 16,
            ),
            buildFlutterBeginner(),
            SizedBox(
              height: 16,
            ),
            buildSubmit(),
            Container(
              height: 50,
              width: 50,
            )
          ],
        ),
      ),
    );
  }

  Widget buildSubmit() => ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(50), shape: StadiumBorder()),
        onPressed: () {
          final form = formKey.currentState!;
          final isValid = form.validate();

          if (isValid) {
            final id = widget.user == null ? null : widget.user!.id;
            final user = User(
                id: id,
                name: controllerName.text,
                email: controllerEmail.text,
                isBeginner: isBeginner);
            widget.onSavedUser(user);
          }
        },
        child: const FittedBox(
          child: Text(
            "Save",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      );

  Widget buildName() => TextFormField(
      controller: controllerName,
      decoration:
          InputDecoration(labelText: "Name", border: OutlineInputBorder()),
      validator: (value) =>
          value != null && value.isEmpty ? "Enter Name" : null);

  Widget buildEmail() => TextFormField(
        controller: controllerEmail,
        decoration:
            InputDecoration(labelText: "Email", border: OutlineInputBorder()),
        validator: (value) =>
            value != null && !value.contains('@') ? "Enter Email" : null,
      );

  Widget buildFlutterBeginner() => SwitchListTile(
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        value: isBeginner,
        onChanged: (value) {
          setState(() {
            isBeginner = value;
          });
        },
        title: const Text('Is Flutter Beginner'),
      );
}
