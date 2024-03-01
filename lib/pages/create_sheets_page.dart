import 'package:flutter/material.dart';
import 'package:google_sheet_api/widget/user_form_widget.dart';
import '../api/sheets/user_sheets_api.dart';

class CreateSheetsPage extends StatelessWidget {
  const CreateSheetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyApp.title'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
         child: UserFormWidget(
          onSavedUser: (user) async {
            final id = await UserSheetApi.getRowCount() + 1;
            final newUser = user.copy(id: id);
              await UserSheetApi.insert([newUser.toJson()]);
            },
        ),
      ),
    );
  }
}
