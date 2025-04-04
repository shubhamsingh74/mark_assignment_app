import 'package:flutter/material.dart';
import '../../domain/entities/visit.dart';
import 'package:intl/intl.dart';

class VisitCard extends StatelessWidget {
  final Visit visit;
  final VoidCallback? onTap;

  const VisitCard({
    super.key,
    required this.visit,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    visit.id,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  _buildStatusChip(),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                DateFormat('dd MMM, yyyy | hh:mm a').format(visit.dateTime),
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(
                    Icons.person_outline,
                    size: 20,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      visit.customerName,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip() {
    Color color;
    String statusText;
    
    switch (visit.status) {
      case VisitStatus.notStarted:
        color = Colors.grey;
        statusText = 'Not Started';
        break;
      case VisitStatus.inProgress:
        color = Colors.orange;
        statusText = 'In Progress';
        break;
      case VisitStatus.completed:
        color = Colors.green;
        statusText = 'Completed';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
} 