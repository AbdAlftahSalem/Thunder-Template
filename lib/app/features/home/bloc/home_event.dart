part of 'home_bloc.dart';

sealed class HomeEvent {}

/// Loads (or reloads) the data of the page.
final class HomeStarted extends HomeEvent {}
