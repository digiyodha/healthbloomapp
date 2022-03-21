import 'package:flutter/material.dart';
import 'package:health_bloom/view/reminder/add_reminder.dart';
import '../view/bill/add_bill.dart';
import '../view/medicine/add_medicine.dart';
import '../view/prescription/add_prescription.dart';
import '../view/report/add_report.dart';

class CustomAddElementBs extends StatelessWidget {
  final Function onChanged;
  const CustomAddElementBs({Key key,this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: <Widget>[
          ListTile(
            leading: new Icon(Icons.add),
            title: Text('Bill'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddBill()))
                  .whenComplete(() => Navigator.pop(context));
            },
          ),
          ListTile(
            leading: new Icon(Icons.add),
            title: new Text('Report'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddReport()))
                  .whenComplete(() => Navigator.pop(context));
            },
          ),
          ListTile(
            leading: new Icon(Icons.add),
            title: new Text('Prescription'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddPrescription()))
                  .whenComplete(() => Navigator.pop(context));
            },
          ),
          ListTile(
            leading: new Icon(Icons.add),
            title: new Text('Medicine'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddMedicine()))
                  .whenComplete(() {
                onChanged();
              });
            },
          ),
          ListTile(
            leading: new Icon(Icons.add),
            title: new Text('Reminder'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddReminder()))
                  .whenComplete(() => Navigator.pop(context));
            },
          ),
          // ListTile(
          //   leading: new Icon(Icons.add),
          //   title: new Text('Insurance'),
          //   onTap: () {
          //     Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => AddInsurance()))
          //         .whenComplete(() => Navigator.pop(context));
          //   },
          // ),
        ],
      ),
    );
  }
}
