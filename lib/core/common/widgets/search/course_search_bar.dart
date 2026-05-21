import 'package:flutter/material.dart';

class CourseSearchBar extends StatefulWidget {
  const CourseSearchBar({super.key, required this.focusNode, required this.onSubmitted});

  final FocusNode focusNode;
  final VoidCallback onSubmitted;

  @override
  State<CourseSearchBar> createState() => _CourseSearchBarState();
}

class _CourseSearchBarState extends State<CourseSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFocused = widget.focusNode.hasFocus;

    return SearchBar(
      controller: _controller,
      focusNode: widget.focusNode,
      hintText: 'Search courses...',
      leading: IconButton(
        icon: Icon(isFocused ? Icons.chevron_left : Icons.search),
        onPressed: () {
          widget.focusNode.unfocus();
        },
      ),

      trailing: [
        if (_controller.text.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              _controller.clear();
              setState(() {});
            },
          ),
      ],

      onChanged: (_) => setState(() {}),

      onSubmitted: (_) => widget.onSubmitted(),
    );
  }
}
