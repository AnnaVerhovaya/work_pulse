import 'package:auto_route/auto_route.dart';
import 'package:flutter_application_workpulse/features/calendar/calendar_screen.dart';
import 'package:flutter_application_workpulse/features/day/day_screen.dart';
import 'package:flutter_application_workpulse/features/home/home_screen.dart';
import 'package:flutter_application_workpulse/features/settings/settings_screen.dart';
part 'router.gr.dart';
@AutoRouterConfig()
class AppRouter extends _$AppRouter {

 @override
 List<AutoRoute> get routes => [
   AutoRoute(
          page: HomeRoute.page,
          path: '/',
          children: [
            AutoRoute(
              page: HomeRoute.page,
              path: 'search',
            ),
            AutoRoute(
              page: DayRoute.page,
              path: 'favorites',
            ),
            AutoRoute(
              page: CalendarRoute.page,
              path: 'poems',
            ),
            AutoRoute(
              page: SettingsRoute.page,
              path: 'settings',
            ),
          ],
        ),
 ];
}