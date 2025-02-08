part of 'food_items_bloc.dart';

@immutable
sealed class FoodItemsState {}

final class FoodItemsInitialState extends FoodItemsState {}

final class FoodItemsLoadingState extends FoodItemsState {}

final class FoodItemsSuccessState extends FoodItemsState {}

final class FoodItemsGetSuccessState extends FoodItemsState {
  final List<Map<String, dynamic>> foodItems;

  FoodItemsGetSuccessState({required this.foodItems});
}

final class FoodItemsFailureState extends FoodItemsState {
  final String message;

  FoodItemsFailureState({this.message = apiErrorMessage});
}
