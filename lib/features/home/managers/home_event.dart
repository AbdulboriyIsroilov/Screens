import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchCategoriesEvent extends HomeEvent {}

class FetchProductsEvent extends HomeEvent {
  final String? title;
  final int? categoryId;
  final int? sizeId;
  final int? minPrice, maxPrice;
  final String? orderBy;

  const FetchProductsEvent({this.title,this.categoryId, this.sizeId, this.minPrice, this.maxPrice,this.orderBy});

  @override
  List<Object?> get props => [title,categoryId, sizeId, minPrice, maxPrice,orderBy];
}
