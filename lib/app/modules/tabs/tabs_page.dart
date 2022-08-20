import 'package:controlegastos/app/modules/entrada/new_entrada_page.dart';
import 'package:controlegastos/app/modules/home/home_page.dart';
import 'package:flutter/material.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final _ListPageInfo _pages = _ListPageInfo([
    _PageInfo(title: 'Início', icon: const Icon(Icons.home), page: HomePage()),
    _PageInfo(title: 'Extrato', icon: const Icon(Icons.list_alt), page: const NewEntradaPage()),
  ]);

  late String _title;

  @override
  void initState() {
    super.initState();
    _title = _pages.getTitle(0);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: TabBarView(
          children: _pages.widgetsPage,
        ),
        bottomNavigationBar: BottomAppBar(
          child: TabBar(
            onTap: _changeTab,
            indicatorColor: Theme.of(context).colorScheme.primary,
            labelColor: Theme.of(context).colorScheme.secondary,
            unselectedLabelColor: Theme.of(context).colorScheme.primary,
            tabs: _generateTabs(),
          ),
        ),
      ),
    );
  }

  List<Tab> _generateTabs() {
    List<Tab> tabs = [];
    for (_PageInfo _pageInfo in _pages.pages) {
      tabs.add(
        Tab(
          icon: _pageInfo.icon,
          child: Text(_pageInfo.title),
        ),
      );
    }

    return tabs;
  }

  void _changeTab(int selectedTab) {
    setState(() {
      _title = _pages.getTitle(selectedTab);
    });
  }
}

class _ListPageInfo {
  final List<_PageInfo> pages;

  _ListPageInfo(this.pages);

  String getTitle(int index) {
    return pages[index].title;
  }

  List<String> get titles {
    List<String> titles = [];

    for (_PageInfo page in pages) {
      titles.add(page.title);
    }

    return titles;
  }

  List<Widget> get widgetsPage {
    List<Widget> widgets = [];

    for (_PageInfo page in pages) {
      widgets.add(page.page);
    }

    return widgets;
  }
}

class _PageInfo {
  final Icon icon;
  final String title;
  final Widget page;

  _PageInfo({
    required this.icon,
    required this.title,
    required this.page,
  });
}
