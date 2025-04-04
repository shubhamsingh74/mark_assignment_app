import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/visits_bloc.dart';
import '../../domain/entities/visit.dart';
import '../widgets/visit_card.dart';
import '../widgets/filter_bottom_sheet.dart';
import 'search_screen.dart';

class VisitsScreen extends StatelessWidget {
  const VisitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawerWidget(context),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildVisitsList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerWidget(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Color(0xFF4051B5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Color(0xFF4051B5), size: 40),
                ),
                SizedBox(height: 10),
                Text(
                  'Manikanada Krishnan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            const Color(0xFF4051B5).withOpacity(0.9),
            BlendMode.srcOver,
          ),
        ),
        color: const Color(0xFF4051B5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer(),
                padding: EdgeInsets.zero,
              ),
              const SizedBox(width: 4),
               const Text("10MARK",style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),)
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'WELCOME BACK',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Manikanada Krishnan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisitsList(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                const Text(
                  'My Visits',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '05',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    final visitsBloc = context.read<VisitsBloc>();
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: visitsBloc,
                          child: const SearchScreen(),
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: false,
                      backgroundColor: Colors.transparent,
                      builder: (context) => FilterBottomSheet(
                        onApplyFilter: (type, status) {
                          context.read<VisitsBloc>().add(
                            FilterVisits(type: type, status: status),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<VisitsBloc, VisitsState>(
              builder: (context, state) {
                if (state is VisitsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is VisitsLoaded) {
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
                } else if (state is VisitsError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
} 