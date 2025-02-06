import 'package:flutter/material.dart';
import 'package:prison_foodie_admin/common_widget/custom_button.dart';
import 'package:prison_foodie_admin/features/category/add_edit_category.dart';
import 'package:prison_foodie_admin/features/category/custom_category_card.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
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
                    builder: (context) => const AddEditCategory(),
                  );
                },
              )
            ],
          ),
          Wrap(
            children: [
              CustomCategoryCard(
                coverImageUrl: 'https://s3.scoopwhoop.com/dan/29/2.jpg',
                name: 'Biriyani',
                onEdit: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (context) => BlocProvider.value(
                  //     value: _collagesBloc,
                  //     child: AddEditCollageDialog(
                  //       collageDetails: _collages[index],
                  //     ),
                  //   ),
                  // );
                },
                onDelete: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (context) => CustomAlertDialog(
                  //     title: 'Delete Collage?',
                  //     description:
                  //         'Deletion will fail if there are records under this collage',
                  //     primaryButton: 'Delete',
                  //     onPrimaryPressed: () {
                  //       _collagesBloc.add(
                  //         DeleteCollageEvent(
                  //           collageId: _collages[index]['id'],
                  //         ),
                  //       );
                  //       Navigator.pop(context);
                  //     },
                  //     secondaryButton: 'Cancel',
                  //   ),
                  // );
                },
                viewList: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => CollageDetailsScreen(
                  //       collageId: _collages[index]['id'],
                  //     ),
                  //   ),
                  // );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
