import 'package:bloc/bloc.dart';
import 'package:logger/web.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../util/file_upload.dart';
import '../../../values/strings.dart';

part 'food_items_event.dart';
part 'food_items_state.dart';

class FoodItemsBloc extends Bloc<FoodItemsEvent, FoodItemsState> {
  FoodItemsBloc() : super(FoodItemsInitialState()) {
    on<FoodItemsEvent>((event, emit) async {
      try {
        emit(FoodItemsLoadingState());
        SupabaseQueryBuilder table =
            Supabase.instance.client.from('food_items');

        if (event is GetAllFoodItemsEvent) {
          PostgrestFilterBuilder<List<Map<String, dynamic>>> query =
              table.select('*,category:categories(*)');

          if (event.params['query'] != null) {
            query = query.ilike('name', '%${event.params['query']}%');
          }

          List<Map<String, dynamic>> foodItems =
              await query.order('name', ascending: true);

          emit(FoodItemsGetSuccessState(foodItems: foodItems));
        } else if (event is AddFoodItemEvent) {
          event.foodItemDetails['image_url'] = await uploadFile(
            'foodItems/image',
            event.foodItemDetails['image'],
            event.foodItemDetails['image_name'],
          );
          event.foodItemDetails.remove('image');
          event.foodItemDetails.remove('image_name');

          await table.insert(event.foodItemDetails);

          emit(FoodItemsSuccessState());
        } else if (event is EditFoodItemEvent) {
          if (event.foodItemDetails['image'] != null) {
            event.foodItemDetails['image_url'] = await uploadFile(
              'foodItems/image',
              event.foodItemDetails['image'],
              event.foodItemDetails['image_name'],
            );
            event.foodItemDetails.remove('image');
            event.foodItemDetails.remove('image_name');
          }
          await table.update(event.foodItemDetails).eq('id', event.foodItemId);

          emit(FoodItemsSuccessState());
        } else if (event is DeleteFoodItemEvent) {
          await table.delete().eq('id', event.foodItemId);
          emit(FoodItemsSuccessState());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(FoodItemsFailureState());
      }
    });
  }
}
