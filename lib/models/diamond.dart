class Diamond {
  final int qty;
  final String lotId;
  final String size;
  final double carat;
  final String lab;
  final String shape;
  final String color;
  final String clarity;
  final String cut;
  final String polish;
  final String symmetry;
  final String fluorescence;
  final double discount;
  final double perCaratRate;
  final double finalAmount;

  Diamond({
    required this.qty,
    required this.lotId,
    required this.size,
    required this.carat,
    required this.lab,
    required this.shape,
    required this.color,
    required this.clarity,
    required this.cut,
    required this.polish,
    required this.symmetry,
    required this.fluorescence,
    required this.discount,
    required this.perCaratRate,
    required this.finalAmount,
  });

  factory Diamond.fromJson(Map<String, dynamic> json) {
    return Diamond(
      qty: json['Qty'],
      lotId: json['Lot ID'],
      size: json['Size'],
      carat: json['Carat'].toDouble(),
      lab: json['Lab'],
      shape: json['Shape'],
      color: json['Color'],
      clarity: json['Clarity'],
      cut: json['Cut'],
      polish: json['Polish'],
      symmetry: json['Symmetry'],
      fluorescence: json['Fluorescence'],
      discount: json['Discount'].toDouble(),
      perCaratRate: json['Per Carat Rate'].toDouble(),
      finalAmount: json['Final Amount'].toDouble(),
    );
  }
}