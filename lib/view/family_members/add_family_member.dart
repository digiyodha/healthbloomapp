import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:hexagon/hexagon.dart';
import '../../components/custom_contained_button.dart';
import '../../utils/drawer/custom_drawer.dart';
import '../../utils/text_field/custom_text_field.dart';

class AddFamilyMembers extends StatefulWidget {
  const AddFamilyMembers({Key? key}) : super(key: key);

  @override
  State<AddFamilyMembers> createState() => _AddFamilyMembersState();
}

class _AddFamilyMembersState extends State<AddFamilyMembers> {
  TextEditingController _name = TextEditingController();
  TextEditingController _relation = TextEditingController();
  int _age = 18;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Add Family Members"),
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
              color: kMainColor,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            top: 180,
            child: Container(
              padding: EdgeInsets.only(top: 100,left: 24,right: 24),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30)
                )
              ),
              child: Column(
                children: [
                  CustomTextField(
                    maxLines: 1,
                    controller: _name,
                    label: "Name", textInputType: TextInputType.name, onChanged: (){}, onTap: (){},
                  ),
                  SizedBox(height: 16,),
                  CustomTextField(
                    maxLines: 1,
                    controller: _relation,
                    label: "Relationship", textInputType: TextInputType.name, onChanged: (){}, onTap: (){},
                  ),
                  SizedBox(height: 24,),
                  Row(
                    children: [
                      Text("Current Age",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: kGrey7
                      ),),
                      Spacer(),
                      InkWell(
                        onTap: (){
                          setState(() {
                            _age--;
                          });
                        },
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: kMainColor,
                          child: Icon(Icons.remove,color: kWhite,size: 16,),
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 12)
                      ,child: Text(_age.toString(),style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,color: kGrey7
                        ),),),
                      InkWell(
                        onTap: (){
                          setState(() {
                            _age++;
                          });
                        },
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: kMainColor,
                          child: Icon(Icons.add,color: kWhite,size: 16,),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  CustomContainedButton(
                    height: 58,
                    textSize: 16,
                    disabledColor: kGreyLite,
                    text: "Submit",
                    onPressed: () {

                    },
                    width: double.infinity,
                  ),
                  SizedBox(height: 16,),
                ],
              ),
            ),
          ),
          Positioned(
            top: 130,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 106,
                  width: 106,
                  child: Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: kWhite,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10
                            )
                          ]
                        ),
                        child: Center(
                          child: Icon(Icons.person,color: kGrey4,size: 60,),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: kMainColor,
                          child: Icon(Icons.edit,color: kWhite,size: 16,),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
