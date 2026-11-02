import 'package:flutter/material.dart';
import '../../models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  final Task task;
  final VoidCallback onEdit;

  const TaskItemWidget({
    super.key,
    required this.task,
    required this.onEdit,
  });

  IconData _getLeadingIcon(String iconType) {
    switch (iconType) {
      case 'laptop':
        return Icons.laptop_chromebook_outlined;
      case 'book':
        return Icons.menu_book_rounded;
      case 'presentation':
        return Icons.co_present_outlined;
      case 'document':
        return Icons.article_outlined;
      default:
        return Icons.assignment_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // Leading icon box
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F3F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getLeadingIcon(task.iconType),
              color: const Color(0xFF495057),
              size: 24,
            ),
          ),
          const SizedBox(width: 14),

          // Title and Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF212529),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      size: 14,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        task.description,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Trailing Edit button
          IconButton(
            icon: const Icon(
              Icons.edit_outlined,
              color: Color(0xFF495057),
              size: 22,
            ),
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }
}
