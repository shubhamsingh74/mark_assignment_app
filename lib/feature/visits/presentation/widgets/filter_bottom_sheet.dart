import 'package:flutter/material.dart';
import '../../domain/entities/visit.dart';

class FilterBottomSheet extends StatefulWidget {
  final Function(VisitType? type, VisitStatus? status) onApplyFilter;

  const FilterBottomSheet({
    super.key,
    required this.onApplyFilter,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  VisitType? selectedType;
  VisitStatus? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filter Visits',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'VISIT TYPE',
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('All', null, selectedType == null),
                    const SizedBox(width: 8),
                    _buildFilterChip('Loan', VisitType.loan, selectedType == VisitType.loan),
                    const SizedBox(width: 8),
                    _buildFilterChip('DC', VisitType.dc, selectedType == VisitType.dc),
                    const SizedBox(width: 8),
                    _buildFilterChip('Gold Storage', VisitType.goldStorage, selectedType == VisitType.goldStorage),
                    const SizedBox(width: 8),
                    _buildFilterChip('Release', VisitType.release, selectedType == VisitType.release),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'VISIT STATUS',
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('All', null, selectedStatus == null),
                    const SizedBox(width: 8),
                    _buildFilterChip('Not Started', VisitStatus.notStarted, selectedStatus == VisitStatus.notStarted),
                    const SizedBox(width: 8),
                    _buildFilterChip('In Progress', VisitStatus.inProgress, selectedStatus == VisitStatus.inProgress),
                    const SizedBox(width: 8),
                    _buildFilterChip('Completed', VisitStatus.completed, selectedStatus == VisitStatus.completed),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: BorderSide(color: Colors.grey[300]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onApplyFilter(selectedType, selectedStatus);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text(
                        'Apply Filter',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, dynamic value, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (value is VisitType) {
            selectedType = isSelected ? null : value;
          } else if (value is VisitStatus) {
            selectedStatus = isSelected ? null : value;
          } else {
            selectedType = null;
            selectedStatus = null;
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
} 