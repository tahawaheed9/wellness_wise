import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class UserInformationTable {
  userInformationTable(
      Map<String, dynamic> userData,
      Map<String, dynamic> predictionData,
      ) {
    final date = userData['date-of-birth'];
    final age = _calculateAge(date);

    final dateFormatter = DateFormat('dd-MM-yyyy, HH:mm:ss');
    final issuedDate = dateFormatter.format(predictionData['created-on'].toDate());

    return Column(
      children: <Widget>[
        Table(
          border: TableBorder.all(color: PdfColors.black),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: {
            0: FixedColumnWidth(30.0),
            1: FixedColumnWidth(100.0),
          },
          children: <TableRow>[
            // Name Field...
            TableRow(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Text(
                    'Name: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Text(userData['username']),
                ),
              ],
            ),

            // Gender Field...
            TableRow(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Text(
                    'Gender: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Text(userData['gender']),
                ),
              ],
            ),

            // Age Field...
            TableRow(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Text(
                    'Age: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Text('${age.toString()} years'),
                ),
              ],
            ),

            // Report Date...
            TableRow(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Text(
                    'Report Issued: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Text(issuedDate),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 30.0),
        Center(
          child: Text(
            'Diagnosis'.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationThickness: 2,
            ),
          ),
        ),
        SizedBox(height: 30.0),
      ],
    );
  }

  int _calculateAge(Timestamp date) {
    // Getting the today's date...
    DateTime now = DateTime.now();

    // Calculating the age by converting it into the milliseconds...
    DateTime birthDate =
    DateTime.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch);

    // Subtracting the age from today's date...
    int age = now.year - birthDate.year;

    // Handling leap year and updating the date only on the user's birthdate...
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}