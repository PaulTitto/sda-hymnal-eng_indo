import 'package:flutter/material.dart';
import 'package:sda_hymnal/data/sda_hymnal.dart';

import '../screen/detail_screen.dart';
import '../screen/home_screen.dart';

class HymnRoutePath {
  final String? id;
  HymnRoutePath.home() : id = null;

  HymnRoutePath.details(this.id);

  bool get isHomePage => id == null;
  bool get isDetailsPage => id != null;
}

class HymnRouteInformationParser extends RouteInformationParser<HymnRoutePath> {
  @override
  Future<HymnRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '');
    if (uri.pathSegments.isEmpty) {
      return HymnRoutePath.home();
    }
    if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'hymn') {
      return HymnRoutePath.details(uri.pathSegments[1]);
    }
    return HymnRoutePath.home();
  }

  @override
  RouteInformation? restoreRouteInformation(HymnRoutePath path) {
    if (path.isHomePage) {
      return const RouteInformation(location: '/');
    }
    if (path.isDetailsPage) {
      return RouteInformation(location: '/hymn/${path.id}');
    }
    return null;
  }
}

class HymnRouterDelegate extends RouterDelegate<HymnRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<HymnRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  String? _selectedHymnId;

  final Future<List<SdaHymnal>> _hymnsFuture = loadHymns();

  HymnRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  HymnRoutePath get currentConfiguration {
    if (_selectedHymnId != null) {
      return HymnRoutePath.details(_selectedHymnId);
    }
    return HymnRoutePath.home();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SdaHymnal>>(
      future: _hymnsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError) {
          return Scaffold(
              body: Center(child: Text('Error loading hymns: ${snapshot.error}')));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Scaffold(body: Center(child: Text('No hymns found.')));
        }

        final hymns = snapshot.data!;
        final selectedHymn = _selectedHymnId == null
            ? null
            : SdaHymnal.findById(hymns, _selectedHymnId!);

        return Navigator(
          key: navigatorKey,
          pages: [
            MaterialPage(
              key: const ValueKey("HomeScreen"),
              child: HomeScreen(
                hymns: hymns,
                onTapped: (String hymnId) {
                  _selectedHymnId = hymnId;
                  notifyListeners();
                },
              ),
            ),
            if (selectedHymn != null)
              MaterialPage(
                key: ValueKey(selectedHymn.index),
                child: HymnDetailScreen(hymn: selectedHymn),
              ),
          ],
          onPopPage: (route, result) {
            if (!route.didPop(result)) {
              return false;
            }
            _selectedHymnId = null;
            notifyListeners();
            return true;
          },
        );
      },
    );
  }

  @override
  Future<void> setNewRoutePath(HymnRoutePath path) async {
    _selectedHymnId = path.id;
  }
}