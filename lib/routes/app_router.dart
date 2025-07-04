import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poketest/model/user_model.dart';
import 'package:poketest/view/detail_page.dart';
import 'package:poketest/view/list_page.dart';
part 'app_router.gr.dart';

@AdaptiveAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: ListPage,
      initial: true,
    ),
    AutoRoute(
      path: '/detail/:user', //user parameter
      page: DetailPage,
    ),
  ],
)
class AppRouter extends _$AppRouter {}