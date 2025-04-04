import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/visits_bloc.dart';
import '../widgets/visit_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> recentSearches = [
    'TCGL00010010',
    'Murugan Pushparaj',
    'Rejitha',
    'TCGL00010010',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.isNotEmpty) {
      context.read<VisitsBloc>().add(SearchVisits(query));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchHeader(),
            _buildRecentSearches(),
            _buildSearchResults(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 16),
              const Text(
                'Search Visit',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search by Visit ID or Customer\'s name',
              hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey[400],
                size: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[400]!),
              ),
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            onChanged: _performSearch,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSearches() {
    if (_searchController.text.isNotEmpty) return const SizedBox();
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'RECENT SEARCHES',
            style: TextStyle(
              color: Colors.black45,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: recentSearches.map((search) => _buildSearchChip(search)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchChip(String label) {
    return ActionChip(
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.black87,
        ),
      ),
      backgroundColor: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      onPressed: () {
        setState(() {
          _searchController.text = label;
        });
        _performSearch(label);
      },
    );
  }

  Widget _buildSearchResults() {
    return Expanded(
      child: BlocConsumer<VisitsBloc, VisitsState>(
        listener: (context, state) {
          if (state is VisitsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is VisitsLoading) {
            return const Center(child: CircularProgressIndicator());
          } 
          
          if (state is VisitsLoaded && _searchController.text.isNotEmpty) {
            if (state.visits.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 48, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'No results found',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.visits.length,
              itemBuilder: (context, index) {
                return VisitCard(
                  visit: state.visits[index],
                  onTap: () {
                    // TODO: Navigate to visit details
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Visit ${state.visits[index].id} details coming soon'),
                      ),
                    );
                  },
                );
              },
            );
          }
          
          return const SizedBox();
        },
      ),
    );
  }
} 