import 'package:bloc/bloc.dart';
import 'package:logger/web.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../values/strings.dart';

part 'delivery_partners_event.dart';
part 'delivery_partners_state.dart';

class DeliveryPartnersBloc
    extends Bloc<DeliveryPartnersEvent, DeliveryPartnersState> {
  DeliveryPartnersBloc() : super(DeliveryPartnersInitialState()) {
    on<DeliveryPartnersEvent>((event, emit) async {
      try {
        emit(DeliveryPartnersLoadingState());
        SupabaseQueryBuilder table =
            Supabase.instance.client.from('delivery_partners');

        if (event is GetAllDeliveryPartnersEvent) {
          PostgrestFilterBuilder<List<Map<String, dynamic>>> query =
              table.select('*').eq('status', event.params['status']);

          if (event.params['query'] != null) {
            query = query.ilike('name', '%${event.params['query']}%');
          }

          List<Map<String, dynamic>> deliveryPartners =
              await query.order('name', ascending: true);

          emit(DeliveryPartnersGetSuccessState(
              deliveryPartners: deliveryPartners));
        } else if (event is AddDeliveryPartnerEvent) {
          await table.insert(event.deliveryPartnerDetails);

          emit(DeliveryPartnersSuccessState());
        } else if (event is EditDeliveryPartnerEvent) {
          await table
              .update(event.deliveryPartnerDetails)
              .eq('id', event.deliveryPartnerId);

          emit(DeliveryPartnersSuccessState());
        } else if (event is DeleteDeliveryPartnerEvent) {
          await table.delete().eq('id', event.deliveryPartnerId);
          emit(DeliveryPartnersSuccessState());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(DeliveryPartnersFailureState());
      }
    });
  }
}
