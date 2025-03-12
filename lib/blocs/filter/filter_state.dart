import 'package:interview_project/models/diamond.dart';

abstract class FilterState {}

class FilterInitial extends FilterState {}

class FilterLoading extends FilterState {}

class FilterSuccess extends FilterState {
  final List<Diamond> diamonds; // You'll need to create a Diamond model

  FilterSuccess(this.diamonds);
}

class FilterError extends FilterState {
  final String message;

  FilterError(this.message);
} 