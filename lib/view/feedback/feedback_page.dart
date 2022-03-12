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
import 'package:health_bloom/utils/loading.dart';
import 'package:health_bloom/utils/text_field/custom_text_field.dart';

import 'package:provider/provider.dart';

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
  String selectedImage;
  String errorMsg = '';
  final feedback = FeedbackController();
  @override
  void initState() {
    super.initState();
    selectedImage = feedback.feedback.first.image;
    print('feedbackOption ${feedbackOption.toList()}');
    getFeedbackOptions();
    errorMsg = '';
    feedbacckIds.clear();
  }

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
      ),
      backgroundColor: Color(0xffA283F9),
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
                        text: 'How was your overall\nnexperience?',
                        color: Colors.white,
                        height: 1.2,
                        textAlign: TextAlign.center,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      const SizedBox(height: 40.0),
                      Image.asset(selectedImage,
                          height: 110, width: 110, color: Color(0xff7FE4F0)),

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
                                  selectedImage = feedback.feedback[i].image;
                                });
                                feedbackOption.isNotEmpty
                                    ? showFeedbackSheet()
                                    : ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        content: Text(
                                            'Please wait few seconds to load data'),
                                      ));
                              },
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Image.asset(
                                        feedback.feedback[i].image,
                                        height: 100,
                                        color: Colors.white,
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
    );
  }

  showFeedbackSheet() {
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
                              const SizedBox(height: 60.0),
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
                                  children: [
                                    for (var option in feedbackOption)
                                      FedbackOptionCard(
                                        isSelected:
                                            feedbacckIds.contains(option.id),
                                        onChanged: (val) {
                                          isSizeSelected = val;
                                          setState(() {
                                            if (isSizeSelected == true) {
                                              print("Add ${option.id}");
                                              setState(() {
                                                feedbacckIds.add(option.id);
                                              });
                                            } else {
                                              print("Remove ${option.id}");
                                              setState(() {
                                                feedbacckIds.remove(option.id);
                                              });
                                            }
                                          });
                                          print(
                                              "Total ${feedbacckIds.toList().toString()}");
                                        },
                                        title: option.feedbackName.toString(),
                                        bgColor: feedbacckIds
                                                .contains(option.feedbackName)
                                            ? Color(0xffAF8EFD)
                                            : Colors.black,
                                        textColor: feedbacckIds
                                                .contains(option.feedbackName)
                                            ? Colors.grey
                                            : Colors.white,
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 50.0),
                              TextBuilder(text: errorMsg.toString()),
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
                                          content: Text("Added successfully!"),
                                        ));
                                        // await Future.delayed(Duration(seconds: 1));
                                        Navigator.pop(context);
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
                                      selectedImage,
                                      color: Color(0xff7FE4F0),
                                      width: 70,
                                      height: 70,
                                      // fit: BoxFit.cover,
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
