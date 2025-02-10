import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:prison_foodie_admin/features/food_item/food_items_bloc/food_items_bloc.dart';

import '../../common_widget/custom_alert_dialog.dart';
import '../../common_widget/custom_dropdownmenu.dart';
import '../../common_widget/custom_image_picker_button.dart';
import '../../common_widget/custom_text_formfield.dart';
import '../../util/value_validator.dart';
import '../category/categories_bloc/categories_bloc.dart';

class AddEditFoodItem extends StatefulWidget {
  final Map? foodItemDetails;

  const AddEditFoodItem({
    super.key,
    this.foodItemDetails,
  });

  @override
  State<AddEditFoodItem> createState() => _AddEditFoodItemState();
}

class _AddEditFoodItemState extends State<AddEditFoodItem> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CategoriesBloc _categoriesBloc = CategoriesBloc();

  PlatformFile? coverImage;
  int? categoryID;
  List<Map> _categories = [];

  Map<String, dynamic> universitieParams = {
    'query': null,
  };

  @override
  void initState() {
    getCategories();
    if (widget.foodItemDetails != null) {
      _nameController.text = widget.foodItemDetails!['name'];
      _descriptionController.text = widget.foodItemDetails!['description'];
      _priceController.text = widget.foodItemDetails!['price'];
      _countController.text = widget.foodItemDetails!['count'];
    }
    super.initState();
  }

  void getCategories() {
    _categoriesBloc.add(GetAllCategoriesEvent(params: const {
      'query': null,
    }));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodItemsBloc, FoodItemsState>(
      listener: (context, foodState) {
        if (foodState is FoodItemsSuccessState) Navigator.pop(context);
      },
      builder: (context, foodState) {
        return BlocProvider.value(
          value: _categoriesBloc,
          child: BlocConsumer<CategoriesBloc, CategoriesState>(
            listener: (context, state) {
              if (state is CategoriesFailureState) {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    title: 'Failure',
                    description: state.message,
                    primaryButton: 'Try Again',
                    onPrimaryPressed: () {
                      getCategories();
                      Navigator.pop(context);
                    },
                  ),
                );
              } else if (state is CategoriesGetSuccessState) {
                _categories = state.categories;
                Logger().w(_categories);
                setState(() {});
              } else if (state is CategoriesSuccessState) {
                getCategories();
              }
            },
            builder: (context, state) {
              return CustomAlertDialog(
                title: 'Add New Catogery',
                isLoading: foodState is FoodItemsLoadingState ||
                    state is CategoriesLoadingState,
                content: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Text(
                          'Cover Image',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: const Color(0xFF2D2D2D),
                                  ),
                        ),
                        const SizedBox(height: 5),
                        CustomImagePickerButton(
                          selectedImage: widget.foodItemDetails?["cover_page"],
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
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: const Color(0xFF2D2D2D),
                                  ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextFormField(
                          labelText: 'Enter Name',
                          controller: _nameController,
                          validator: alphabeticWithSpaceValidator,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Price',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: const Color(0xFF2D2D2D),
                                  ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextFormField(
                          labelText: 'Enter Price',
                          controller: _priceController,
                          validator: numericValidator,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Count',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: const Color(0xFF2D2D2D),
                                  ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextFormField(
                          labelText: 'Enter Count',
                          controller: _countController,
                          validator: numericValidator,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Catagory',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: const Color(0xFF2D2D2D),
                                  ),
                        ),
                        const SizedBox(height: 5),
                        CustomDropDownMenu(
                          initialSelection: categoryID,
                          controller: _categoryController,
                          hintText: "Select Category",
                          onSelected: (selected) {
                            categoryID = selected;
                            Logger().w(categoryID);
                          },
                          dropdownMenuEntries: List.generate(
                            _categories.length,
                            (index) => DropdownMenuEntry(
                              value: _categories[index]['id'],
                              label: _categories[index]['name'],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Description',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: const Color(0xFF2D2D2D),
                                  ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextFormField(
                          labelText: 'Enter Description',
                          controller: _descriptionController,
                          validator: notEmptyValidator,
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
                      ((coverImage != null) ||
                          widget.foodItemDetails != null)) {
                    Map<String, dynamic> details = {
                      'name': _nameController.text.trim(),
                      'description': _descriptionController.text.trim(),
                      'price': _priceController.text.trim(),
                      'count': _countController.text.trim(),
                      'category_id': categoryID
                    };

                    if (coverImage != null) {
                      details['image'] = coverImage!.bytes;
                      details['image_name'] = coverImage!.name;
                    }

                    if (widget.foodItemDetails != null) {
                      BlocProvider.of<FoodItemsBloc>(context).add(
                        EditFoodItemEvent(
                          foodItemId: widget.foodItemDetails!['id'],
                          foodItemDetails: details,
                        ),
                      );
                    } else {
                      BlocProvider.of<FoodItemsBloc>(context).add(
                        AddFoodItemEvent(
                          foodItemDetails: details,
                        ),
                      );
                    }
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}
