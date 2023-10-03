// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import '../middleware/auth_middleware.dart';
import '../modules/Auth/bindings/auth_binding.dart';
import '../modules/Auth/views/login_view.dart';

import '../modules/MainScrean/bindings/main_screan_binding.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/MainScrean/views/main_screan_view.dart';
import '../modules/ServicesScreen/bindings/services_screen_binding.dart';
import '../modules/ServicesScreen/views/beneficiares_screen_view.dart';
import '../modules/ServicesScreen/views/search_query_view.dart';
import '../modules/UserGuide/bindings/user_guide_binding.dart';
import '../modules/UserGuide/views/user_guide_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/servicesPublic/bindings/services_public_binding.dart';
import '../modules/servicesPublic/views/beneficiares_services_booking_view.dart';
import '../modules/servicesPublic/views/services_public_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAIN_SCREAN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    // GetPage(
    //   name: _Paths.SEARCH_TRIP,
    //   page: () => SearchTripView(),
    //   binding: SearchTripBinding(),
    // ),
    // GetPage(
    //   name: _Paths.BOOKING_TRIP,
    //   page: () => BookingTripView(),
    //   binding: BookingTripBinding(),
    // ),

    GetPage(
      name: _Paths.MAIN_SCREAN,
      page: () => const MainScreanView(),
      binding: MainScreanBinding(),
    ),
    // GetPage(
    //   name: _Paths.REQUERMENT_ME,
    //   page: () => const RequermentMeView(),
    //   binding: RequermentMeBinding(),
    // ),
    // GetPage(
    //   name: _Paths.ACCOUT_USER,
    //   page: () => const AccoutUserView(),
    //   binding: AccoutUserBinding(),
    // ),
    GetPage(
      name: _Paths.USER_GUIDE,
      page: () => UserGuideView(),
      binding: UserGuideBinding(),
    ),
    GetPage(
      name: _Paths.SERVICES_SCREEN,
      page: () => const SearchQueryView(),
      binding: ServicesScreenBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const LoginView(),
      binding: AuthBinding(),
      // middlewares: [AuthMiddleware()]
    ),
    GetPage(
      name: _Paths.SERVICES_PUBLIC,
      page: () => const ServicesPublicView(),
      binding: ServicesPublicBinding(),
    ),
    GetPage(
        name: _Paths.SERVICES_SCREEN_BENEFITES,
        page: () => BeneficiaresScreenView(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: _Paths.SERVICES_Public_BENEFITES,
        page: () => BeneficiaresServicesBookingView(),
        middlewares: [AuthMiddleware()]),
    GetPage(
      name: _Paths.Chat_Screen,
      page: () => ChatView(),
      binding: ChatBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
