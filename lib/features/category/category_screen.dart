import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:prison_foodie_admin/common_widget/custom_button.dart';
import 'package:prison_foodie_admin/features/category/add_edit_category.dart';
import 'package:prison_foodie_admin/features/category/custom_category_card.dart';

import '../../common_widget/custom_alert_dialog.dart';
import '../../util/check_login.dart';
import 'categories_bloc/categories_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoriesBloc _categoriesBloc = CategoriesBloc();

  Map<String, dynamic> params = {
    'query': null,
  };

  List<Map> _categories = [];

  @override
  void initState() {
    checkLogin(context);
    getCategories();
    super.initState();
  }

  void getCategories() {
    _categoriesBloc.add(GetAllCategoriesEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      inverse: true,
                      label: 'Add Category',
                      iconData: Icons.add,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => BlocProvider.value(
                            value: _categoriesBloc,
                            child: const AddEditCategory(),
                          ),
                        );
                      },
                    )
                  ],
                ),
                if (state is CategoriesLoadingState)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                if (state is CategoriesGetSuccessState && _categories.isEmpty)
                  const Center(
                    child: Text("No Catgory Found"),
                  ),
                Wrap(
                  children: List.generate(
                    _categories.length,
                    (index) => CustomCategoryCard(
                      coverImageUrl: _categories[index]['image_url'],
                      name: _categories[index]['name'],
                      onEdit: () {
                        showDialog(
                          context: context,
                          builder: (context) => BlocProvider.value(
                            value: _categoriesBloc,
                            child: AddEditCategory(
                              categorieDetails: _categories[index],
                            ),
                          ),
                        );
                      },
                      onDelete: () {
                        showDialog(
                          context: context,
                          builder: (context) => CustomAlertDialog(
                            title: 'Delete Categorie?',
                            description:
                                'Deletion will fail if there are records under this categorie',
                            primaryButton: 'Delete',
                            onPrimaryPressed: () {
                              _categoriesBloc.add(
                                DeleteCategorieEvent(
                                  categorieId: _categories[index]['id'],
                                ),
                              );
                              Navigator.pop(context);
                            },
                            secondaryButton: 'Cancel',
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
