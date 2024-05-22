class HomeState {
  final bool isLoading;
  HomeState({
    required this.isLoading,
  });

  HomeState copyWith({
    bool? isLoading,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
