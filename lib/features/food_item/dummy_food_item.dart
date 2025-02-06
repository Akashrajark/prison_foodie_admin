class DummyFoodItem {
  final String itemName;
  final int itemPrice;
  final String itemImageUrl;
  final String category;

  DummyFoodItem({
    required this.itemName,
    required this.itemPrice,
    required this.itemImageUrl,
    required this.category,
  });
}

List<DummyFoodItem> deliveryDetail = [
  DummyFoodItem(
      itemName: 'Chicken Biriyani',
      itemPrice: 120,
      itemImageUrl: '',
      category: 'Biriyani'),
  DummyFoodItem(
      itemName: 'Mutton Biriyani',
      itemPrice: 180,
      itemImageUrl: '',
      category: 'Biriyani'),
  DummyFoodItem(
      itemName: 'Veg Pulao',
      itemPrice: 100,
      itemImageUrl: '',
      category: 'Rice'),
  DummyFoodItem(
      itemName: 'Butter Chicken',
      itemPrice: 250,
      itemImageUrl: '',
      category: 'Curry'),
  DummyFoodItem(
      itemName: 'Paneer Tikka',
      itemPrice: 200,
      itemImageUrl: '',
      category: 'Starter'),
  DummyFoodItem(
      itemName: 'Tandoori Roti',
      itemPrice: 30,
      itemImageUrl: '',
      category: 'Bread'),
  DummyFoodItem(
      itemName: 'Malai Kofta',
      itemPrice: 220,
      itemImageUrl: '',
      category: 'Curry'),
  DummyFoodItem(
      itemName: 'Fish Fry',
      itemPrice: 270,
      itemImageUrl: '',
      category: 'Seafood'),
  DummyFoodItem(
      itemName: 'Prawns Masala',
      itemPrice: 300,
      itemImageUrl: '',
      category: 'Seafood'),
  DummyFoodItem(
      itemName: 'Gulab Jamun',
      itemPrice: 50,
      itemImageUrl: '',
      category: 'Dessert'),
];
