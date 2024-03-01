import 'package:flutter/material.dart';
import 'package:google_sheet_api/model/user.dart';
import 'package:gsheets/gsheets.dart';

class UserSheetApi {
  //this is the spreedsheet id which i want to access

  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "gsheets-378109",
  "private_key_id": "f7d293384fb49ad8ebacf5011fad56a136b19192",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCsDiYapzcSnTfO\naOVp+GchlLRMUb7i0X/tErY/RkqKQsaoBW6wYTAMmBY8/niRfxu3UNhUHg7VVkF4\n0e+CYT61MtT1Aj04HUXej5iYKHRk1pTzqjlrxv0qmvPPUoC33L20bcHOZUX/whNv\nRjYd3Dohy3fL3bKQyDZdXpuVWsBfYn9uU5V9nhDFAFBdOHgP8VEP0e7gmm4jFSs2\nIOLI4OXu3LVcC2U6iytuyiVLXsj3bLL9cmNZeNhtbnCtMSieQbJiwOZ1zPdD9tzM\nE63gEsxzNMuLgF/A3EPKOQdDjH4/1iwCLIQeJ82pkTybP0LZoYT5KGXVdP804Kgo\niUlR5Nm5AgMBAAECggEAChX3Pls8g3sTXSZxglWFKCcJLasiEzZAN0PASrPCZVn2\nPr24yB6eXDKjJRautyq6E3QqBj5P1MouYth9n4k3TZRp/uXPdGVk5d/JjGvcrNeW\nWjVJkeuThiaYsbfOo1iNh1DiykhOAujbzktRm00AXGBKyLjZgZq28yC7YpU0DzNE\nfECAxZzsgHrTrK94djeUN5E25gXV11jHUkFFkbFcyVZUgKgO58qdIi3y1tOfSWZ6\nrk7T13O//vAdvu5wa3YFZJW6/R3RgLSXVqr3asGxYWQTc2b4WVPAAj/2m0VwSEYp\nKXzF4lCoO1HdOzRwpI0xwoRSUDOLg2lb6HnSnzkPvQKBgQDlip3KPTGY7AjRqEhR\nXs0iE7V0l5oX1cVZsX+mo5eaVZv0qOnNcNofLzsft7b2WIEZqmeUtgnppt16wmlK\nws9F8pEMjR3JkqvS87+DrAEEfVAkeSWz/VfrSFlHY7ivxJSibCwpPTIs5COeUxFN\n0N8Ea4omQ3yXqoG2JPFod+Vv9QKBgQC/4zYM8oNIjw/XGVltOwrduo/17f5uLdFy\nuchg+zGB7V+dsy1ZoE8lwBx9SYZ2tg8HAVh2Ogq7Wmy7RiS3sqtkBLHA9r2hcC7l\n+jnwFOjfujkocpDL1E1/kqbNPGYaXbTjnk1LkC1IabryQXid25udpHxTOfQGhV1x\nACEkgEJ8NQKBgQDAKcCZO4uW+xsS8e/A9z2CJr/FINmm1JbH1PoJtnDHip3qP7Kk\nA7MHYlH75qAsMcG6i9b1P0SjL8fA6pqdNOOzKjPWLxld1AU2sEqHX+rmKEZ8klNH\nEHOXDFV5l3lY5JiONULvL0UfIcrT07Tr0U2y9JiOGfdnPR4kL19OVvlkNQKBgQCv\ndX14/U/aSyZ60y0YWkKnWO5GPGbILJE2THbTZx1v5rPlqW8wYwu8QxxJ269eYT8A\nctSG1q/1fMuruonchz186WX4QiZHtiLMG7BavWPrH4cgWxHXr7tliZ2IUVAzj7fV\n4mxfSeh+LF/LIN6/yY1T6pHcMEPYqp40s5+alsU0eQKBgEM8wC2KBwPeh1NjANQt\nrDjXCAWOtbab1pRJg3EgFoeG6CExeo2q98FMOudqmivBDyqth2by2lRqiH+gbLg3\nmoSq9rmqNNXPRPraOKiPC4NviCjt8mhqAf9DV1AGpy50sofqw4mDG2gHMKKmjOVj\npGJCUuMxKxA01oEsNAVCfsMH\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-378109.iam.gserviceaccount.com",
  "client_id": "105642197642747604853",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-378109.iam.gserviceaccount.com"
}
''';
  static final _spreadsheetId = '1M5wm5nPPmWE7ZNk2846Ak1VcACAM9QVERsqrxUetzuw';

  //to access excel sheet first we need to initialized GSheet. and provide credencials
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;

// initaial method
  static Future init() async {
    try {
      //this is spreadsheet instance
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      // this is worksheet instance
      _userSheet = await _getWorkSheet(spreadsheet, title: 'Users');
      //UserField apna model class hai, usme ik method hai getField name ka jo 
      //ki list of string return karta hai, yanhan pe ye method userfield class 
      // variable pe set value return kar ke neeche firstrow variable pe rakh dega
      final firstRow = UserFields.getFields();
      //isme hum firstRow variable me jo list of strings hain unko worksheet ke first row me rakh rahe hain
      //i mean column names
      _userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('init error:  $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      //if worksheet with 'Users' name not available then it will create a sheet with named 'Users'
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return await spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<User?> getById(int id) async {
    if (_userSheet == null) return null;
    final json = await _userSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : User.fromJson(json);
  }

  static Future<List<User>> getAll() async {
    if (_userSheet == null) return <User>[];
    final users = await _userSheet!.values.map.allRows();
    return users == null ? <User>[] : users.map(User.fromJson).toList();
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    _userSheet!.values.map.appendRows(rowList);
  }

  static Future<int> getRowCount() async {
    if (_userSheet == null) return 0;
    final lastRow = await _userSheet!.values.lastRow();
    // I removed ?? 0 from the last of the below line
    return lastRow == null ? 0 : int.parse(lastRow.first);
  }

  static Future<bool> update(
    int id,
    Map<String, dynamic> user,
  ) async {
    if (_userSheet == null) return false;
    return _userSheet!.values.map.insertRowByKey(id, user);
  }

  static Future<bool> updateCell({
    required int id,
    required String key,
    required dynamic value,
  }) async {
    if(_userSheet == null) return false;
    return _userSheet!.values.insertValueByKeys(value, columnKey: key, rowKey: id);
  }

  static Future<bool> deleteById(int id) async{
    if(_userSheet == null) return false;
    final index = await _userSheet!.values.rowIndexOf(id);
    if(index == -1) return false;
    return _userSheet!.deleteRow(index);
  }
}
