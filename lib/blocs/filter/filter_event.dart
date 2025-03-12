abstract class FilterEvent {}

class ApplyFilters extends FilterEvent {
  final double? caratFrom;
  final double? caratTo;
  final String? lab;
  final String? shape;
  final String? color;
  final String? clarity;

  ApplyFilters({
    this.caratFrom,
    this.caratTo,
    this.lab,
    this.shape,
    this.color,
    this.clarity,
  });
} 