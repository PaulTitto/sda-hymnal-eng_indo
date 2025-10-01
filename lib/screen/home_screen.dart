import 'package:flutter/material.dart';
import 'package:sda_hymnal/data/sda_hymnal.dart';

class HomeScreen extends StatefulWidget {
  final List<SdaHymnal> hymns;
  final ValueChanged<String> onTapped;

  const HomeScreen({
    super.key,
    required this.hymns,
    required this.onTapped,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;
  final TextEditingController _searchQueryController = TextEditingController();
  List<SdaHymnal> _filteredHymns = [];

  @override
  void initState() {
    super.initState();
    _filteredHymns = widget.hymns;
    _searchQueryController.addListener(_updateFilteredHymns);
  }

  @override
  void dispose() {
    _searchQueryController.removeListener(_updateFilteredHymns);
    _searchQueryController.dispose();
    super.dispose();
  }

  void _updateFilteredHymns() {
    final query = _searchQueryController.text;
    final List<SdaHymnal> filteredList;
    if (query.isEmpty) {
      filteredList = widget.hymns;
    } else {
      filteredList = widget.hymns
          .where((hymn) =>
          hymn.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    setState(() {
      _filteredHymns = filteredList;
    });
  }

  void _toggleSearch() {
    setState(() {
      if (_isSearching) {
        _isSearching = false;
        _searchQueryController.clear();
      } else {
        _isSearching = true;
      }
    });
  }

  AppBar _buildAppBar() {
    if (_isSearching) {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _toggleSearch,
        ),
        title: TextField(
          controller: _searchQueryController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search by title...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.black54),
          ),
          style: const TextStyle(color: Colors.black, fontSize: 18.0),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              if (_searchQueryController.text.isNotEmpty) {
                _searchQueryController.clear();
              } else {
                _toggleSearch();
              }
            },
          ),
        ],
      );
    } else {
      return AppBar(
        title: const Text('SDA Hymnal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _toggleSearch,
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView.builder(
        itemCount: _filteredHymns.length,
        itemBuilder: (context, index) {
          final hymn = _filteredHymns[index];
          return ListTile(
            leading: Text(
              hymn.number.toString(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            title: Text(hymn.title),
            onTap: () => widget.onTapped(hymn.index),
          );
        },
      ),
    );
  }
}