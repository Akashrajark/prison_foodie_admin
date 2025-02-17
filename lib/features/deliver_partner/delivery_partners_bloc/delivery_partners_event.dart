part of 'delivery_partners_bloc.dart';

@immutable
sealed class DeliveryPartnersEvent {}

class GetAllDeliveryPartnersEvent extends DeliveryPartnersEvent {
  final Map<String, dynamic> params;

  GetAllDeliveryPartnersEvent({required this.params});
}

class AddDeliveryPartnerEvent extends DeliveryPartnersEvent {
  final Map<String, dynamic> deliveryPartnerDetails;

  AddDeliveryPartnerEvent({required this.deliveryPartnerDetails});
}

class EditDeliveryPartnerEvent extends DeliveryPartnersEvent {
  final Map<String, dynamic> deliveryPartnerDetails;
  final int deliveryPartnerId;

  EditDeliveryPartnerEvent({
    required this.deliveryPartnerDetails,
    required this.deliveryPartnerId,
  });
}

class DeleteDeliveryPartnerEvent extends DeliveryPartnersEvent {
  final int deliveryPartnerId;

  DeleteDeliveryPartnerEvent({required this.deliveryPartnerId});
}
