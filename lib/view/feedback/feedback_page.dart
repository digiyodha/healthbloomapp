import 'package:flutter/material.dart';

import 'package:health_bloom/components/custom_button_icon.dart';
import 'package:health_bloom/components/feedback_option_card.dart';
import 'package:health_bloom/components/textbuilder.dart';
import 'package:health_bloom/controller/feedback_controller.dart';
import 'package:health_bloom/model/request/add_feedback_request.dart';
import 'package:health_bloom/model/response/add_feedback_response.dart';
import 'package:health_bloom/model/response/get_feedback_options_response.dart';
import 'package:health_bloom/model/response/search_medicne_response.dart';
import 'package:health_bloom/services/api/repository/auth_repository.dart';
import 'package:health_bloom/utils/colors.dart';
import 'package:health_bloom/utils/loading.dart';
import 'package:health_bloom/utils/text_field/custom_text_field.dart';
import 'package:health_bloom/view/homepage/home_page.dart';
import 'package:provider/provider.dart';

import '../../utils/drawer/custom_drawer.dart';


class FeedbackPage extends StatefulWidget {
  final SearchMedicineResponseDatum medicne;
  const FeedbackPage({Key key, this.medicne}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  bool _loading = false;
  List<GetFeedbackOptionsResponseDatum> feedbackOption = [];
  TextEditingController _description = TextEditingController();
  Future<GetFeedbackOptionsResponse> getFeedbackOptions() async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    GetFeedbackOptionsResponse _response =
        await adminAPI.getFeedbackOptionsAPI();
    _response.data.forEach((element) {
      feedbackOption.add(element);
    });
    return _response;
  }

  Future<AddFeedbackResponse> addFeedback(AddFeedbackRequest request) async {
    final adminAPI = Provider.of<NetworkRepository>(context, listen: false);
    AddFeedbackResponse _response = await adminAPI.addFeedbackAPI(request);
    return _response;
  }

  bool isSizeSelected = false;
  List<String> feedbacckIds = [];
  int selectedIndex = 0;
  String selectedExperience;
  String selectedPngImage;
  String selectedJpgImage;
  String errorMsg = '';
  final feedback = FeedbackController();
  @override
  void initState() {
    super.initState();
    selectedPngImage = feedback.feedback.first.pngImage;
    selectedJpgImage = feedback.feedback.first.jpgImage;
    selectedExperience = feedback.feedback.first.text;
    print('feedbackOption ${feedbackOption.toList()}');
    getFeedbackOptions();
    errorMsg = '';
    feedbacckIds.clear();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
        return true;
      },
      child: Scaffold(
        drawer: CustomDrawer(
          selected: 8,
        ),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: kMainColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30.0),
                        TextBuilder(
                          text: 'USER FEEDBACK',
                          color: Color(0xffA1C8FE),
                          fontSize: 13,
                          latterSpacing: 1,
                          fontWeight: FontWeight.w700,
                        ),
                        const SizedBox(height: 10.0),
                        TextBuilder(
                          text: 'How was your overall\nexperience?',
                          color: Colors.white,
                          height: 1.2,
                          textAlign: TextAlign.center,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        const SizedBox(height: 40.0),
                        Image.asset(
                          selectedPngImage,
                          height: 110,
                          width: 110,
                          // colorBlendMode: BlendMode.softLight,
                          // color: Color(0xff7FE4F0),
                        ),
                        const SizedBox(height: 20.0),
                        TextBuilder(
                          text: 'I am ${selectedExperience}!',
                          color: Colors.white,
                          textAlign: TextAlign.center,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        // const SizedBox(height: 10.0),
                        Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.white,
                          size: 90,
                        ),
                        const SizedBox(height: 50.0),
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            itemCount: feedback.feedback.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemBuilder: (BuildContext context, int i) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    print(selectedExperience =
                                        feedback.feedback[i].text);
                                    selectedExperience =
                                        feedback.feedback[i].text;
                                    selectedPngImage =
                                        feedback.feedback[i].pngImage;
                                    selectedJpgImage =
                                        feedback.feedback[i].jpgImage;
                                  });
                                  feedbackOption.isNotEmpty
                                      ? showFeedbackSheet()
                                      : ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Please wait few seconds to load data'),
                                          ),
                                        );
                                },
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Image.asset(
                                          feedback.feedback[i].pngImage,
                                          height: 100,

                                          // color: Colors.white,
                                          width: 100,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextBuilder(
                                        text: feedback.feedback[i].text,
                                        textAlign: TextAlign.center,
                                        color: Colors.white,
                                        fontSize: 16,
                                        height: 1.3,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showFeedbackSheet() {
    errorMsg = '';
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: true,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Stack(
              children: [
                Container(
                  height: 700,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: 575,
                        width: double.infinity,
                        clipBehavior: Clip.antiAlias,
                        padding: EdgeInsets.only(top: 60),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // const SizedBox(height: 60.0),
                              TextBuilder(
                                text: 'Which area that\nneed improvement?',
                                fontSize: 20,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w700,
                              ),
                              const SizedBox(height: 20.0),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: CustomTextField(
                                  maxLines: 2,
                                  controller: _description,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  label: "Description",
                                  textInputType: TextInputType.name,
                                  onChanged: (val) {},
                                  onTap: () {},
                                ),
                              ),
                              SizedBox(height: 24),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  runSpacing: 15,
                                  spacing: 10,
                                  children: List.generate(feedbackOption.length, (index) => FedbackOptionCard(
                                    isSelected:
                                    feedbacckIds.contains(feedbackOption[index].id),
                                    onChanged: (val) {
                                      isSizeSelected = val;
                                      setState(() {
                                        if (isSizeSelected == true) {
                                          print("Add ${feedbackOption[index].id}");
                                          setState(() {
                                            feedbacckIds.add(feedbackOption[index].id);
                                          });
                                        } else {
                                          print("Remove ${feedbackOption[index].id}");
                                          setState(() {
                                            feedbacckIds.remove(feedbackOption[index].id);
                                          });
                                        }
                                      });
                                      print(
                                          "Total ${feedbacckIds.toList().toString()}");
                                    },
                                    title: feedbackOption[index].feedbackName.toString(),
                                    bgColor:
                                    feedbacckIds.contains(feedbackOption[index].id)
                                        ? _colors[index]
                                        : Color(0xffF4F5FA),
                                    textColor:
                                    feedbacckIds.contains(feedbackOption[index].id)
                                        ? Colors.white
                                        : Color(0xffA5A4B3),
                                  )),
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              TextBuilder(
                                text: errorMsg.toString(),
                                color: Colors.red,
                              ),
                              const SizedBox(height: 10.0),
                              CustomButtonIcon(
                                  title: 'Submit',
                                  icon: Icons.mail,
                                  onTop: () async {
                                    if (selectedExperience != null &&
                                        feedbacckIds.isNotEmpty) {
                                      setState(() {
                                        _loading = true;
                                      });

                                      AddFeedbackRequest _request =
                                          AddFeedbackRequest(
                                              experience: selectedExperience,
                                              description: _description.text,
                                              feedbackOptions: feedbacckIds);
                                      print(
                                          'Add Feedback request ${_request.toJson()}');
                                      AddFeedbackResponse _response =
                                          await addFeedback(_request);
                                      print(
                                          'Add Feedback response ${_response.toJson()}');
                                      if (_response.success) {
                                        _description.clear();
                                        feedbacckIds.clear();
                                        setState(() {
                                          errorMsg = '';
                                          _loading = false;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Yor feedback has been recorded"),
                                        ));
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomePage()),
                                          (Route<dynamic> route) => false,
                                        );
                                      }
                                    } else {
                                      setState(() {
                                        errorMsg = '';
                                        _loading = false;
                                      });
                                      errorMsg = 'Please fill all the details';
                                    }
                                  }),
                              const SizedBox(height: 50.0),
                            ],
                          ),
                        ),
                      ),
                      Positioned.fill(
                        top: 0,
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.keyboard_arrow_up_outlined,
                                  color: Colors.white,
                                  size: 80,
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipOval(
                                    child: Image.asset(
                                      selectedPngImage,
                                      width: 70,
                                      height: 70,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                if (_loading)
                  Container(
                      height: 700,
                      width: double.infinity,
                      child: LoadingWidget(color: Colors.blue)),
              ],
            );
          },
        );
      },
    );
  }
}

List<Color> _colors = [
  Color(0xffAD8EFB),
  Color(0xff7FE3F0),
  Color(0xff2288FF),
  Color(0xffFF9A92),
  Color(0xff94AEFD),
  Color(0xff5ED3E2),
  Color(0xffAD8EFB),
  Color(0xff7FE3F0),
  Color(0xff2288FF),
  Color(0xffFF9A92),
  Color(0xff94AEFD),
  Color(0xff5ED3E2),
  Color(0xffAD8EFB),
  Color(0xff7FE3F0),
  Color(0xff2288FF),
  Color(0xffFF9A92),
  Color(0xff94AEFD),
  Color(0xff5ED3E2),
];