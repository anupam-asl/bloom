class FoodEntity {
  final DateTime dateTime;
  final String foodname;
  final double calorie;
  final double? protein;
  final double? carbohydrate;
  final double? totalFat;
  final double? saturatedFat;
  final double? transFat;
  final double? sodium;
  final double? cholesterol;
  final String? inputMode; // e.g., "photo", "user", "auto-entry"
  final String? expectedGlucoseResponse; // optional

  FoodEntity({
    required this.dateTime,
    required this.foodname,
    required this.calorie,
    this.protein,
    this.carbohydrate,
    this.totalFat,
    this.saturatedFat,
    this.transFat,
    this.sodium,
    this.cholesterol,
    this.inputMode,
    // required this.protein,
    // required this.carbohydrate,
    // required this.totalFat,
    // required this.saturatedFat,
    // required this.transFat,
    // required this.sodium,
    // required this.cholesterol,
    // required this.inputMode,
    this.expectedGlucoseResponse,
  });
}
