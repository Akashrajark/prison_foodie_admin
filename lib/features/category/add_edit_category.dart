import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_widget/custom_alert_dialog.dart';
import '../../common_widget/custom_image_picker_button.dart';
import '../../common_widget/custom_text_formfield.dart';
import '../../util/value_validator.dart';
import 'categories_bloc/categories_bloc.dart';

class AddEditCategory extends StatefulWidget {
  final Map? categorieDetails;

  const AddEditCategory({
    super.key,
    this.categorieDetails,
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
    if (widget.categorieDetails != null) {
      _nameController.text = widget.categorieDetails!['name'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesBloc, CategoriesState>(
      listener: (context, state) {
        if (state is CategoriesSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return CustomAlertDialog(
          title: 'Add New Catogery',
          isLoading: state is CategoriesLoadingState,
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
                    selectedImage: widget.categorieDetails?["image_url"],
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
                    isLoading: state is CategoriesLoadingState,
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
            if (_formKey.currentState!.validate() &&
                ((coverImage != null) || widget.categorieDetails != null)) {
              Map<String, dynamic> details = {
                'name': _nameController.text.trim(),
              };

              if (coverImage != null) {
                details['image'] = coverImage!.bytes;
                details['image_name'] = coverImage!.name;
              }

              if (widget.categorieDetails != null) {
                BlocProvider.of<CategoriesBloc>(context).add(
                  EditCategorieEvent(
                    categorieId: widget.categorieDetails!['id'],
                    categorieDetails: details,
                  ),
                );
              } else {
                BlocProvider.of<CategoriesBloc>(context).add(
                  AddCategorieEvent(
                    categorieDetails: details,
                  ),
                );
              }
            }
          },
        );
      },
    );
  }
}
