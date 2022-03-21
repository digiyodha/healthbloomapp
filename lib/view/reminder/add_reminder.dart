import 'package:flutter/material.dart';

import '../../components/custom_contained_button.dart';
import '../../components/textbuilder.dart';
import '../../utils/colors.dart';
import '../../utils/text_field/custom_text_field.dart';

class AddReminder extends StatelessWidget {
  const AddReminder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: TextBuilder(
          text: "Add Reminder",
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
        centerTitle: true,
      ),
      backgroundColor: kWhite,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              width: double.infinity,
              child: Image.asset(
                "assets/images/medical_report.jpg",
                fit: BoxFit.cover,
                color: Colors.black45,
                colorBlendMode: BlendMode.hardLight,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            top: 180,
            child: Container(
              padding: EdgeInsets.only(top: 40, left: 24, right: 24),
              decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    CustomTextField(
                      maxLines: 1,
                      label: "Family Member",
                      textCapitalization: TextCapitalization.sentences,
                      textInputType: TextInputType.name,
                      onChanged: (val) {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16,),
                    CustomTextField(
                      maxLines: 1,
                      label: "Date & Time",
                      textCapitalization: TextCapitalization.sentences,
                      textInputType: TextInputType.name,
                      onChanged: (val) {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16,),
                    CustomTextField(
                      maxLines: 1,
                      label: "Type",
                      textCapitalization: TextCapitalization.sentences,
                      textInputType: TextInputType.name,
                      onChanged: (val) {},
                      onTap: () {},
                    ),
                    SizedBox(height: 16,),
                    CustomTextField(
                      maxLines: 4,
                      label: "Description",
                      textCapitalization: TextCapitalization.sentences,
                      textInputType: TextInputType.name,
                      onChanged: (val) {},
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
            color: kWhite),
        padding: EdgeInsets.symmetric(horizontal: 24),
        height: 80,
        child: Align(
          alignment: Alignment.center,
          child: CustomContainedButton(
            height: 58,
            textSize: 16,
            disabledColor: kGreyLite,
            text: "Add",
            onPressed: () async {

            },
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
