part of 'delivery_partners_bloc.dart';

@immutable
sealed class DeliveryPartnersState {}

final class DeliveryPartnersInitialState extends DeliveryPartnersState {}

final class DeliveryPartnersLoadingState extends DeliveryPartnersState {}

final class DeliveryPartnersSuccessState extends DeliveryPartnersState {}

final class DeliveryPartnersGetSuccessState extends DeliveryPartnersState {
  final List<Map<String, dynamic>> deliveryPartners;

  DeliveryPartnersGetSuccessState({required this.deliveryPartners});
}

final class DeliveryPartnersFailureState extends DeliveryPartnersState {
  final String message;

  DeliveryPartnersFailureState({this.message = apiErrorMessage});
}
