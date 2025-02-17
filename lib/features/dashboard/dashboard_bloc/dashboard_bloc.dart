import 'package:bloc/bloc.dart';
import 'package:logger/web.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../values/strings.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitialState()) {
    on<DashboardEvent>((event, emit) async {
      try {
        emit(DashboardLoadingState());
        SupabaseClient supabaseClient = Supabase.instance.client;

        if (event is GetAllDashboardEvent) {
          Map<String, dynamic> dashboard = {};
          final data = await supabaseClient.rpc("get_counts");
          dashboard = data[0];

          dashboard['orders'] = await supabaseClient
              .from('orders')
              .select(
                  '*,users:users(user_name),delivery:delivery_partners(name)')
              .order('created_at')
              .limit(10);

          emit(DashboardGetSuccessState(dashboard: dashboard));
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(DashboardFailureState());
      }
    });
  }
}
