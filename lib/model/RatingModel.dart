class RatingModel {
  double? rate;
  int? count;
  RatingModel({this.rate, this.count});
  factory RatingModel.fromJson(Map<String, dynamic> obj) {
    return RatingModel(rate: obj['rate'], count: obj['count']);
  }
}
