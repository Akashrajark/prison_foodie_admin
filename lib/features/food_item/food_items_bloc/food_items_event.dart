part of 'food_items_bloc.dart';

@immutable
sealed class FoodItemsEvent {}

class GetAllFoodItemsEvent extends FoodItemsEvent {
  final Map<String, dynamic> params;

  GetAllFoodItemsEvent({required this.params});
}

class AddFoodItemEvent extends FoodItemsEvent {
  final Map<String, dynamic> foodItemDetails;

  AddFoodItemEvent({required this.foodItemDetails});
}

class EditFoodItemEvent extends FoodItemsEvent {
  final Map<String, dynamic> foodItemDetails;
  final int foodItemId;

  EditFoodItemEvent({
    required this.foodItemDetails,
    required this.foodItemId,
  });
}

class DeleteFoodItemEvent extends FoodItemsEvent {
  final int foodItemId;

  DeleteFoodItemEvent({required this.foodItemId});
}
