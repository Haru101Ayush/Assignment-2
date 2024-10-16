import 'dart:io';
import 'package:excel/excel.dart';

void main() {
  var file = 'C:/Users/TE-66/Desktop/dart ass/cli/Bookreal.xlsx';
  var bytes = File(file).readAsBytesSync();
  int count = 0;
  var excel = Excel.decodeBytes(bytes);

  var backUpDataSheet = excel['BackUP Data '];
  var currentDataSheet = excel['Current Data '];

  Map<String, String> currentDataMap = {};

  for (var row in currentDataSheet.rows) {
    var userName = row[1]?.value.toString();
    var passwordHash = row[2]?.value.toString();
    if (userName != null && passwordHash != null) {
      currentDataMap[userName] = passwordHash;
    }
  }

  List<String> nonMatchingUserNames = [];

  for (var row in backUpDataSheet.rows) {
    var userNameBackUp = row[1]?.value.toString();
    var passwordHashBackUp = row[2]?.value.toString();

    if (currentDataMap.containsKey(userNameBackUp)) {
      var passwordHashCurrent = currentDataMap[userNameBackUp];

      if (passwordHashBackUp != passwordHashCurrent) {
        nonMatchingUserNames.add(userNameBackUp!);
      }
    }
  }

  print('UserNames with non matching PasswordHash:');
  for (var userName in nonMatchingUserNames) {
    count++;
    print(userName);
  }
  print(" The total diff are : $count");
}
