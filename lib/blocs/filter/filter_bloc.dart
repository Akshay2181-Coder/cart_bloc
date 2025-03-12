import 'dart:convert';
import 'dart:developer';

import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_project/blocs/filter/filter_event.dart';
import 'package:interview_project/core/data.dart';
import 'package:interview_project/models/diamond.dart';
import 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterInitial()) {
    on<ApplyFilters>(_onApplyFilters);
  }

  Future<void> _onApplyFilters(
    ApplyFilters event,
    Emitter<FilterState> emit,
  ) async {
    try {
      emit(FilterLoading());
      // TODO: Implement your actual filtering logic here
      // This is just dummy data for demonstration
      await Future.delayed(Duration(seconds: 1));


      List<Diamond> diamonds = [];
      for (int i = 0; i < diamondsModelList.length; i++) {
        var row = diamondsModelList[i];
        double carat = double.parse(row.carat.toString());
        String color = row.color.toString() ?? '';
        String clarity = row.clarity.toString() ?? '';

        String lab = row.lab.toString() ?? '';

        String shape = row.shape.toString() ?? '';

        String id = row.lotId.toString() ?? '';
        String size = row.size.toString() ?? '';
        String cut = row.cut.toString() ?? '';
        String fluorescence = row.fluorescence.toString() ?? '';
        String polish = row.polish.toString() ?? '';
        String symmetry = row.symmetry.toString() ?? '';

        int qty = int.parse(row.qty.toString() ?? '0');
        double price = double.parse(row.finalAmount.toString() ?? '0.0');
        double discount = double.parse(row.discount.toString() ?? '0.0');
        double perCaratRate = double.parse(row.perCaratRate.toString() ?? '0.0');

        bool meetsCaratRange = (event.caratFrom == null || carat >= event.caratFrom!) && (event.caratTo == null || carat <= event.caratTo!);
        bool meetsLab = event.lab == null || lab.toUpperCase() == event.lab!.toUpperCase();
        bool meetsShape = event.shape == null || shape.toUpperCase() == event.shape!.toUpperCase();
        bool meetsColor = event.color == null || color.toUpperCase() == event.color!.toUpperCase();
        bool meetsClarity = event.clarity == null || clarity.toUpperCase() == event.clarity!.toUpperCase();
        if (meetsCaratRange && meetsLab && meetsShape && meetsColor && meetsClarity) {
          diamonds.add(Diamond(
            carat: carat,
            size: size,
            cut: cut,
            discount: discount,
            finalAmount: price,
            fluorescence: fluorescence,
            perCaratRate: perCaratRate,
            polish: polish,
            symmetry: symmetry,
            color: color,
            clarity: clarity,
            lab: lab,
            shape: shape,
            lotId: id,
            qty: qty,
          ));
        }
      }

      emit(FilterSuccess(diamonds));
    } catch (e) {
      emit(FilterError(e.toString()));
    }
  }
}

