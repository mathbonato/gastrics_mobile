class DayDataAnalytic {
  double consumption = 0.0;
  double consumptionAVG = 0.0;
  double consumptionTot = 0.0;
  double cylinderWeight = 0.0;
  double hoursLeft = 0.0;
  int iteration = 0;
  double weight = 0.0;
  String date = "";
  DateTime? updatedAt;
  double weightAVG = 0.0;
  double percentWeight = 0.0;
  String? exId = "";
  String? name = "";

  DayDataAnalytic(
    this.consumption,
    this.consumptionAVG,
    this.consumptionTot,
    this.cylinderWeight,
    this.hoursLeft,
    this.iteration,
    this.weight,
    this.date,
    this.updatedAt,
    this.weightAVG,
    this.percentWeight
  );

  factory DayDataAnalytic.fromJson(dynamic json) {
    var consumption = (json['consumption'] ?? 0) + .0;
    var consumptionAVG = (json['consumptionAVG'] ?? 0) + .0;
    var consumptionTot = (json['consumptionTot'] ?? 0) + .0;
    var cylinderWeight = (json['cylinderWeight'] ?? 0) + .0;
    var hoursLeft = (json['hoursLeft'] ?? 0) + .0;
    int iteration = json['iteration'] == null ? 0 : json['iteration'] as int;
    var weight = (json['weight'] ?? 0) + .0;
    var weightAVG = (json['weightAVG'] ?? 0) + .0;
    var percentWeight = (json['percentWeight']  ?? 0) + .0;
    var updatedAt = DateTime.parse(json['updatedAt']);

    return DayDataAnalytic(
      consumption,
      consumptionAVG,
      consumptionTot,
      cylinderWeight,
      hoursLeft,
      iteration,
      weight,
      json['date'] as String,
      updatedAt,
      weightAVG,
      percentWeight,
    );
  }
}