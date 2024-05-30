
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_rv/domain/model/news_model.dart';
import 'package:news_app_rv/infrastructure/home/home_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeService homeService;

  HomeBloc(this.homeService) : super(HomeInitial()) {
    on<GetNewCategoryWise>((event, emit) async {
      emit(HomeLoading());

      final getNews =
          await homeService.getNewsFromHome(category: event.catergory);

      if (getNews.$1 == null) {
        emit(HomeSuccess(newList: getNews.$2!));
      } else {
        emit(HomeFailure(showError: getNews.$1 ?? 'server down B01'));
      }
    });
  }
}
