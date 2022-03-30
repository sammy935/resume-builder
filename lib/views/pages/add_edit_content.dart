import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:resume_builder/data_provider/user_data_provider.dart';
import 'package:resume_builder/model/resume_model.dart';
import 'package:resume_builder/utils/static_data.dart';
import 'package:resume_builder/widgets/appbar.dart';
import 'package:resume_builder/widgets/multi_select_dialog.dart';
import 'package:uuid/uuid.dart';

import '../../utils/base_methods.dart';

class AddEditContent extends StatefulWidget {
  final String title;
  final Resume? updateResume;
  const AddEditContent({Key? key, required this.title, this.updateResume})
      : super(key: key);

  @override
  State<AddEditContent> createState() => _AddEditContentState();
}

class _AddEditContentState extends State<AddEditContent> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController summaryController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController languageController = TextEditingController();
  DateTime? birth;
  List<String>? selectedSkills, selectedLanguages;

  FocusNode emailF = FocusNode();
  FocusNode firstNameF = FocusNode();
  FocusNode lastNameF = FocusNode();
  FocusNode phoneF = FocusNode();
  FocusNode birthF = FocusNode();
  FocusNode summaryF = FocusNode();
  FocusNode skillF = FocusNode();
  FocusNode languagesF = FocusNode();
  late String title;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final UserDataProvider _userDataProvider = UserDataProvider();

  @override
  void initState() {
    title = widget.title == "Add" ? "Add new resume" : "Edit resume";
    if (widget.title == "Edit" && widget.updateResume != null) {
      emailController.text = widget.updateResume!.emailAddress!;
      firstNameController.text = widget.updateResume!.firstName!;
      lastNameController.text = widget.updateResume!.lastName!;
      phoneController.text = widget.updateResume!.phoneNumber!;
      birth = widget.updateResume!.dateOfBirth!;
      summaryController.text = widget.updateResume?.profileSummary ?? '';
      selectedSkills = widget.updateResume?.skills ?? [];
      skillsController.text = selectedSkills?.join(' ,') ?? '';
      selectedLanguages = widget.updateResume?.languages ?? [];
      languageController.text = selectedLanguages?.join(' ,') ?? '';
      birth = widget.updateResume?.dateOfBirth;
      birthController.text = birth?.toString().split(' ').first ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unFocusAll,
      child: Scaffold(
        appBar: CustomAppBar(
          title: title,
          showBack: widget.title == 'Edit',
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * .05,
                ),
                buildTextFormField(
                    controller: emailController,
                    label: 'Enter email',
                    fieldValidator: (v) => validateEmail(
                          email: emailController.text.trim(),
                        ),
                    inputTypeAction: TextInputAction.next,
                    focus: emailF,
                    capitalization: TextCapitalization.none,
                    inputType: TextInputType.emailAddress,
                    onSubmitted: () {
                      firstNameF.requestFocus();
                    }),
                buildSizedBox,

                /// firstname and lastname
                Row(
                  children: [
                    Expanded(
                      child: buildTextFormField(
                        controller: firstNameController,
                        label: 'Enter first name',
                        focus: firstNameF,
                        inputTypeAction: TextInputAction.next,
                        fieldValidator: (v) => validateEmpty(
                          element: 'Name',
                          name: firstNameController.text.trim(),
                        ),
                        onSubmitted: () => lastNameF.requestFocus(),
                      ),
                    ),
                    Expanded(
                      child: buildTextFormField(
                        controller: lastNameController,
                        label: 'Enter last name',
                        focus: lastNameF,
                        inputTypeAction: TextInputAction.next,
                        fieldValidator: (v) => validateEmpty(
                          element: 'Name',
                          name: lastNameController.text.trim(),
                        ),
                        onSubmitted: () => phoneF.requestFocus(),
                      ),
                    ),
                  ],
                ),
                buildSizedBox,

                ///phone
                buildTextFormField(
                  maxLength: 10,
                  controller: phoneController,
                  label: 'Enter phone number',
                  fieldValidator: (v) => validateEmpty(
                    element: 'Phone number',
                    name: phoneController.text.trim(),
                  ),
                  inputTypeAction: TextInputAction.done,
                  focus: phoneF,
                  inputType: TextInputType.number,
                  onSubmitted: () {
                    phoneF.unfocus();
                  },
                  formatter: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                buildSizedBox,

                ///birth
                buildTextFormField(
                    controller: birthController,
                    label: 'Enter birth day',
                    focus: FocusNode(),
                    onSubmitted: () {},
                    readOnly: true,
                    onTap: showDialogDatePicker,
                    fieldValidator: (v) {
                      String? error =
                          validateEmpty(name: v, element: 'Birth date');
                      return error == null && birth != null ? null : error;
                    }),

                buildSizedBox,

                ///summary
                buildTextFormField(
                  controller: summaryController,
                  label: 'Enter description',
                  fieldValidator: (v) => validateEmpty(
                    element: 'Description',
                    name: summaryController.text.trim(),
                  ),
                  inputTypeAction: TextInputAction.newline,
                  focus: summaryF,
                  inputType: TextInputType.multiline,
                  onSubmitted: () {
                    // firstNameF.requestFocus();
                  },
                  maxLines: 10,
                ),

                buildSizedBox,

                ///skills
                buildTextFormField(
                  controller: skillsController,
                  label: 'Tap to select skills',
                  focus: FocusNode(),
                  onSubmitted: () {},
                  readOnly: true,
                  onTap: () async {
                    unFocusAll;
                    selectedSkills = await showMultiSelectDialog(
                      context: context,
                      elements: skills,
                      selectedElements: selectedSkills,
                    );
                    skillsController.clear();
                    skillsController.text = selectedSkills?.join(' ,') ?? '';
                    setState(() {});
                  },
                ),

                buildSizedBox,

                ///languages
                buildTextFormField(
                  controller: languageController,
                  label: 'Tap to select languages',
                  focus: FocusNode(),
                  onSubmitted: () {},
                  readOnly: true,
                  onTap: () async {
                    unFocusAll;
                    selectedLanguages = await showMultiSelectDialog(
                      context: context,
                      elements: languages,
                      selectedElements: selectedLanguages,
                    );
                    languageController.text =
                        selectedLanguages?.join(' ,') ?? '';
                    setState(() {});
                  },
                ),
                buildSizedBox,
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
          child: ElevatedButton(
            onPressed: () => submitPress(context),
            child: const Text("Add details"),
          ),
        ),
      ),
    );
  }

  Future<void> submitPress(context) async {
    unFocusAll;
    if (_formKey.currentState!.validate()) {
      String uuid = const Uuid().v4();
      Resume newResume = Resume(
        id: uuid,
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        dateOfBirth: birth,
        emailAddress: emailController.text.trim(),
        phoneNumber: phoneController.text.trim(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        skills: selectedSkills,
        profileSummary: summaryController.text.trim(),
        languages: selectedLanguages,
      );

      showLoaderDialog(context);
      try {
        final res = await _userDataProvider.addResume(newResume);

        if (res) {
          Get.back();
          Get.back();
        }
      } catch (e) {
        Get.back();
      }
    }
  }

  SizedBox get buildSizedBox {
    return SizedBox(
      height: Get.height * 0.02,
    );
  }

  Widget buildTextFormField({
    required TextEditingController controller,
    FormFieldValidator<String>? fieldValidator,
    required String label,
    TextCapitalization? capitalization,
    TextInputAction? inputTypeAction,
    TextInputType? inputType,
    int? maxLines,
    int? maxLength,
    bool readOnly = false,
    List<TextInputFormatter>? formatter,
    required VoidCallback onSubmitted,
    VoidCallback? onTap,
    required FocusNode focus,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      child: TextFormField(
        readOnly: readOnly,
        onTap: onTap,
        focusNode: focus,
        validator: fieldValidator,
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal)),
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          counterText: '',
        ),
        textCapitalization: capitalization ?? TextCapitalization.sentences,
        textInputAction: inputTypeAction ?? TextInputAction.done,
        keyboardType: inputType ?? TextInputType.text,
        maxLines: maxLines,
        maxLength: maxLength,
        inputFormatters: formatter ?? [],
        onFieldSubmitted: (s) => onSubmitted,
      ),
    );
  }

  void showDialogDatePicker() async {
    unFocusAll;
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365)),
      firstDate: DateTime(1950),
      lastDate: DateTime.now().subtract(const Duration(days: 365)),
    );
    if (pickedDate != null && birth != pickedDate) {
      setState(() {
        birth = pickedDate;
        birthController.text = birth.toString().split(' ').first;
      });
    }
  }

  Future<List<String>?> showMultiSelectDialog(
      {required BuildContext context,
      required List<String> elements,
      List<String>? selectedElements}) async {
    final res = await showDialog(
        context: context,
        builder: (context) {
          return MultiSelectDialog(
            elements: elements,
            selectedElements: selectedElements,
          );
        });

    return res;
  }

  get unFocusAll {
    emailF.unfocus();
    firstNameF.unfocus();
    lastNameF.unfocus();
    phoneF.unfocus();
    birthF.unfocus();
    summaryF.unfocus();
    skillF.unfocus();
    languagesF.unfocus();
  }
}
