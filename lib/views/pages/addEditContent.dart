import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:resume_builder/model/resume_model.dart';
import 'package:resume_builder/widgets/appbar.dart';

import '../../utils/baseMethods.dart';

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
  DateTime? birth;
  List<String?>? selectedSkills, selectedLanguages;

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
      //todo add languages and skills
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: title,
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
                  fieldValidator: (v) =>
                      validateEmail(email: emailController.text.trim()),
                  inputTypeAction: TextInputAction.next,
                  focus: emailF,
                  inputType: TextInputType.emailAddress,
                  onSubmitted: () {
                    firstNameF.requestFocus();
                  }),
              SizedBox(
                height: Get.height * 0.02,
              ),

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
                          element: 'First Name',
                          name: firstNameController.text.trim()),
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
                          element: 'Last Name',
                          name: lastNameController.text.trim()),
                      onSubmitted: () {},
                    ),
                  ),
                ],
              ),

              ///phone
              buildTextFormField(
                  controller: phoneController,
                  label: 'Enter phone number',
                  fieldValidator: (v) => validateEmpty(
                      element: 'Phone number',
                      name: phoneController.text.trim()),
                  inputTypeAction: TextInputAction.next,
                  focus: phoneF,
                  inputType: TextInputType.number,
                  onSubmitted: () {
                    birthF.requestFocus();
                  },
                  formatter: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ]),

              ///birth

              ///summary
              buildTextFormField(
                  controller: emailController,
                  label: 'Enter email',
                  fieldValidator: (v) => validateEmpty(
                      element: 'Last Name',
                      name: lastNameController.text.trim()),
                  inputTypeAction: TextInputAction.next,
                  focus: emailF,
                  inputType: TextInputType.emailAddress,
                  onSubmitted: () {
                    firstNameF.requestFocus();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField({
    required TextEditingController controller,
    FormFieldValidator<String>? fieldValidator,
    required String label,
    TextCapitalization? capitalization,
    TextInputAction? inputTypeAction,
    TextInputType? inputType,
    int? maxLength,
    List<TextInputFormatter>? formatter,
    required VoidCallback onSubmitted,
    required FocusNode focus,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      child: TextFormField(
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
        maxLength: maxLength,
        inputFormatters: formatter ?? [],
        onFieldSubmitted: (s) => onSubmitted,
      ),
    );
  }
}
