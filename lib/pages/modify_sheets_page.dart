import 'package:flutter/material.dart';
import 'package:google_sheet_api/api/sheets/user_sheets_api.dart';
import 'package:google_sheet_api/widget/button_widget.dart';
import 'package:google_sheet_api/widget/user_form_widget.dart';

import '../model/user.dart';
import '../widget/naviagte_users_widget.dart';

class ModifySheetsPage extends StatefulWidget {
  const ModifySheetsPage({super.key});

  @override
  State<ModifySheetsPage> createState() => _ModifySheetsPageState();
}

class _ModifySheetsPageState extends State<ModifySheetsPage> {
  @override
  List<User> users = [];
  int index = 0;
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }

  Future getUsers() async {
    final users = await UserSheetApi.getAll();

    setState(() {
      this.users = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(16),
          children: [
            UserFormWidget(
                user: users.isEmpty ? null : users[index],
                onSavedUser: (user) async {
                  // await UserSheetApi.update(user.id!, user.toJson());
                  UserSheetApi.updateCell(
                      id: 4, key: 'email', value: 'dean@flutter.com');
                }),
            const SizedBox(
              height: 16,
            ),
            if (users.isNotEmpty) buildUserControls(),
          ],
        ),
      ),
    );
  }

  Widget buildUserControls() => Column(
        children: [
          ButtonWidget(text: 'Delete', onClicked: deleteUser),
          SizedBox(
            height: 16,
          ),
          NavigateUsersWidget(
              text: "${index + 1}/${users.length} Users",
              onCLickedNext: () {
                final nextIndex = index >= users.length - 1 ? 0 : index + 1;
                setState(() {
                  index = nextIndex;
                });
              },
              onClickedPrevious: () {
                final previousIndex = index <= 0 ? users.length - 1 : index - 1;
                setState(() {
                  index = previousIndex;
                });
              }),
        ],
      );


      Future deleteUser() async {
        final user = users[index];
        await UserSheetApi.deleteById(user.id!); 
        //just for updating ui
        final newIndex = index > 0 ? index - 1 : 0;
        await getUsers();
      }
}
