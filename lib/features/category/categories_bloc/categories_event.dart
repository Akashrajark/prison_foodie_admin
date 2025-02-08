part of 'categories_bloc.dart';

@immutable
sealed class CategoriesEvent {}

class GetAllCategoriesEvent extends CategoriesEvent {
  final Map<String, dynamic> params;

  GetAllCategoriesEvent({required this.params});
}

class AddCategorieEvent extends CategoriesEvent {
  final Map<String, dynamic> categorieDetails;

  AddCategorieEvent({required this.categorieDetails});
}

class EditCategorieEvent extends CategoriesEvent {
  final Map<String, dynamic> categorieDetails;
  final int categorieId;

  EditCategorieEvent({
    required this.categorieDetails,
    required this.categorieId,
  });
}

class DeleteCategorieEvent extends CategoriesEvent {
  final int categorieId;

  DeleteCategorieEvent({required this.categorieId});
}
