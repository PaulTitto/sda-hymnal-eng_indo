sealed class SdaHymnalListResultState {}

class SdaHymnalListNoneState extends SdaHymnalListResultState {}
class SdaHymnalListLoadingState extends SdaHymnalListResultState{}
class SdaHymnalListErrorState extends SdaHymnalListResultState{
  final String error;
  SdaHymnalListErrorState(this.error);
}

class SdaHymnalListLoadedState extends SdaHymnalListResultState{
  final List<dynamic> hymns;
  SdaHymnalListLoadedState(this.hymns);
}