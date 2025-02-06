import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../common_widget/custom_alert_dialog.dart';
import '../../common_widget/custom_image_picker_button.dart';
import '../../common_widget/custom_text_formfield.dart';
import '../../util/value_validator.dart';

class AddEditCategory extends StatefulWidget {
  final Map? collageDetails;
  final int? universitieId;

  const AddEditCategory({
    super.key,
    this.collageDetails,
    this.universitieId,
  });

  @override
  State<AddEditCategory> createState() => _AddEditCategoryState();
}

class _AddEditCategoryState extends State<AddEditCategory> {
  final TextEditingController _nameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  PlatformFile? coverImage;

  Map<String, dynamic> universitieParams = {
    'query': null,
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: 'Add New Catogery',
      // isLoading: state is UniversitiesLoadingState ||
      //     collageState is CollagesLoadingState,
      content: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Flexible(
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                'Cover Image',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: const Color(0xFF2D2D2D),
                    ),
              ),
              const SizedBox(height: 5),
              CustomImagePickerButton(
                selectedImage: widget.collageDetails?["cover_page"],
                borderRadius: 8,
                height: 100,
                width: 360,
                onPick: (value) {
                  coverImage = value;
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Name',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: const Color(0xFF2D2D2D),
                    ),
              ),
              const SizedBox(height: 5),
              CustomTextFormField(
                labelText: 'Enter Name',
                controller: _nameController,
                validator: alphabeticWithSpaceValidator,
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      primaryButton: 'Save',
      onPrimaryPressed: () {
        // if (_formKey.currentState!.validate() &&
        //     ((coverImage != null) || widget.collageDetails != null) &&
        //     ((_selectedUniversitie != null))) {
        //   Map<String, dynamic> details = {
        //     'university_id': _selectedUniversitie,
        //     'name': _nameController.text.trim(),
        //     'state': _stateController.text.trim(),
        //     'district': _districtController.text.trim(),
        //     'place': _placeController.text.trim(),
        //     'pincode': _pincodeController.text.trim(),
        //     'description': _descriptionController.text.trim(),
        //   };

        //   if (coverImage != null) {
        //     details['cover_image_file'] = coverImage!.bytes;
        //     details['cover_image_name'] = coverImage!.name;
        //   }

        //   if (widget.collageDetails != null) {
        //     BlocProvider.of<CollagesBloc>(context).add(
        //       EditCollageEvent(
        //         collageId: widget.collageDetails!['id'],
        //         collageDetails: details,
        //       ),
        //     );
        //   } else {
        //     BlocProvider.of<CollagesBloc>(context).add(
        //       AddCollageEvent(
        //         collageDetails: details,
        //       ),
        //     );
        //   }
        // }
      },
    );
  }
}
