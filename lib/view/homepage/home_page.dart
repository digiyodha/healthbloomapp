import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:hexagon/hexagon.dart';

import '../../utils/drawer/custom_drawer.dart';
import '../family_members/family_members.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        selected: 0,
      ),
      backgroundColor: kWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              SizedBox(height: 18,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 26,),
                        Row(
                          children: [
                            Icon(Icons.wb_sunny,color: kMainColor,size: 15,),
                            SizedBox(width: 4,),
                            Text("TUES 13 OCT",
                            style: TextStyle(
                              fontSize: 12,
                              letterSpacing: 1.5,
                              color: kMainColor,
                              fontWeight: FontWeight.w800
                            ),),
                          ],
                        ),
                        SizedBox(height: 4,),
                        Text("Hi, Grace",
                          style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w600
                          ),),
                      ],
                    ),
                  ),
                  Container(
                    height: 46,
                    width: 46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage("https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                        fit: BoxFit.cover
                      )
                    ),
                  )
                ],
              ),
              SizedBox(height: 24,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14),
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xffF5F6FA)
                ),
                child: Row(
                  children: [
                    HexagonWidget.pointy(
                      width: 80,
                      height: 80,
                      elevation: 5,
                      cornerRadius: 16,
                      color: kMainColor,
                      padding: 0,
                      child: Center(
                        child: Text("40",
                        style: TextStyle(
                          fontSize: 30,
                          color: kWhite
                        ),),
                      ),
                    ),
                    SizedBox(width: 14,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Health Score",
                            style: TextStyle(
                                color: kBlack,
                                fontSize: 18,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 8,),
                          Text("Check your progress of medicine completion for today",
                            style: TextStyle(
                              color: kGrey6,
                              fontSize: 14
                            ),
                          ),
                          SizedBox(height: 8,),
                          Text("Read more",
                            style: TextStyle(
                                color: kMainColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 24,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Medicines",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),),
                  Icon(Icons.more_horiz,color: kGreyText,size: 28,)
                ],
              ),
              SizedBox(height: 14,),
              GridView(
                padding: EdgeInsets.only(bottom: 34),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16
                ),
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14,vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xff8B80F8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("MEDICINE",style: TextStyle(
                          fontSize: 12,
                          color: kWhite,
                          letterSpacing: 1.5
                        ),),
                        Spacer(),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Image.asset("assets/images/drug1.png"),
                          ),
                        ),
                        Spacer(),
                        Text("9:00 AM",style: TextStyle(
                            fontSize: 22,
                            color: kWhite,
                          fontWeight: FontWeight.w600
                        ),),
                        SizedBox(height: 6,),
                        Text("Dosage - 10 mg",style: TextStyle(
                            fontSize: 14,
                            color: kWhite.withOpacity(0.6),
                            fontWeight: FontWeight.w400
                        ),),
                        Spacer(),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14,vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xffAF8EFF),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("MEDICINE",style: TextStyle(
                            fontSize: 12,
                            color: kWhite,
                            letterSpacing: 1.5
                        ),),
                        Spacer(),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Image.asset("assets/images/drug2.png"),
                          ),
                        ),
                        Spacer(),
                        Text("9:30 AM",style: TextStyle(
                            fontSize: 22,
                            color: kWhite,
                            fontWeight: FontWeight.w600
                        ),),
                        SizedBox(height: 6,),
                        Text("Dosage - 5 mg",style: TextStyle(
                            fontSize: 14,
                            color: kWhite.withOpacity(0.6),
                            fontWeight: FontWeight.w400
                        ),),
                        Spacer(),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14,vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xffFFA38E),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("MEDICINE",style: TextStyle(
                            fontSize: 12,
                            color: kWhite,
                            letterSpacing: 1.5
                        ),),
                        Spacer(),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Image.asset("assets/images/drug2.png"),
                          ),
                        ),
                        Spacer(),
                        Text("11:00 AM",style: TextStyle(
                            fontSize: 22,
                            color: kWhite,
                            fontWeight: FontWeight.w600
                        ),),
                        SizedBox(height: 6,),
                        Text("Dosage - 8 mg",style: TextStyle(
                            fontSize: 14,
                            color: kWhite.withOpacity(0.6),
                            fontWeight: FontWeight.w400
                        ),),
                        Spacer(),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14,vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xff8B80F8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("WATER",style: TextStyle(
                            fontSize: 12,
                            color: kWhite,
                            letterSpacing: 1.5
                        ),),
                        Spacer(),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Image.asset("assets/images/water_glass.png"),
                          ),
                        ),
                        Spacer(),
                        Text("750 ml",style: TextStyle(
                            fontSize: 22,
                            color: kWhite,
                            fontWeight: FontWeight.w600
                        ),),
                        SizedBox(height: 6,),
                        Text("Last updates 3m ago",style: TextStyle(
                            fontSize: 14,
                            color: kWhite.withOpacity(0.6),
                            fontWeight: FontWeight.w400
                        ),),
                        Spacer(),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return FamilyMembers();
                      }));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14,vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xff4C5A81),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("FAMILY MEMBERS",style: TextStyle(
                              fontSize: 12,
                              color: kWhite,
                              letterSpacing: 1.5
                          ),),
                          Spacer(),
                          Align(
                            alignment: Alignment.center,
                            child: Icon(Icons.supervised_user_circle_sharp,color: kWhite,size: 100,),
                          ),
                          Spacer(),
                          Text("9:00 AM",style: TextStyle(
                              fontSize: 22,
                              color: kWhite,
                              fontWeight: FontWeight.w600
                          ),),
                          SizedBox(height: 6,),
                          Text("Dosage - 10 mg",style: TextStyle(
                              fontSize: 14,
                              color: kWhite.withOpacity(0.6),
                              fontWeight: FontWeight.w400
                          ),),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        backgroundColor: kMainColor,
        child: Center(
          child: Icon(Icons.add,color: kWhite,size: 24,),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        elevation: 20,
        height: 60,
        icons: [
          Icons.home,
          Icons.mic_rounded,
          Icons.list,
          Icons.person,
        ],
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.defaultEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        activeColor: kBlack,
        inactiveColor: kGreyLite,
        //other params
      ),
    );
  }
}
