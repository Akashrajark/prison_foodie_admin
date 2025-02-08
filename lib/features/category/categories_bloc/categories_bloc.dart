import 'package:bloc/bloc.dart';
import 'package:logger/web.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../util/file_upload.dart';
import '../../../values/strings.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitialState()) {
    on<CategoriesEvent>((event, emit) async {
      try {
        emit(CategoriesLoadingState());
        SupabaseQueryBuilder table =
            Supabase.instance.client.from('categories');

        if (event is GetAllCategoriesEvent) {
          PostgrestFilterBuilder<List<Map<String, dynamic>>> query =
              table.select('*');

          if (event.params['query'] != null) {
            query = query.ilike('name', '%${event.params['query']}%');
          }

          List<Map<String, dynamic>> categories =
              await query.order('name', ascending: true);

          emit(CategoriesGetSuccessState(categories: categories));
        } else if (event is AddCategorieEvent) {
          event.categorieDetails['image_url'] = await uploadFile(
            'categories/image',
            event.categorieDetails['image'],
            event.categorieDetails['image_name'],
          );
          event.categorieDetails.remove('image');
          event.categorieDetails.remove('image_name');

          await table.insert(event.categorieDetails);

          emit(CategoriesSuccessState());
        } else if (event is EditCategorieEvent) {
          if (event.categorieDetails['image'] != null) {
            event.categorieDetails['image_url'] = await uploadFile(
              'categories/image',
              event.categorieDetails['image'],
              event.categorieDetails['image_name'],
            );
            event.categorieDetails.remove('image');
            event.categorieDetails.remove('image_name');
          }
          await table
              .update(event.categorieDetails)
              .eq('id', event.categorieId);

          emit(CategoriesSuccessState());
        } else if (event is DeleteCategorieEvent) {
          await table.delete().eq('id', event.categorieId);
          emit(CategoriesSuccessState());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(CategoriesFailureState());
      }
    });
  }
}
