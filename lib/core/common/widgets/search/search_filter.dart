import 'package:flutter/material.dart';
import 'package:ulearning_app/core/common/widgets/search/course_search_bar.dart';

class SearchFilter extends StatefulWidget {
  const SearchFilter({super.key});

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  final FocusNode _focusNode = FocusNode();

  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isSearching = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CourseSearchBar(focusNode: _focusNode, onSubmitted: () => _focusNode.unfocus()),
        ),

        // animate the spacing shrinking
        AnimatedContainer(duration: const Duration(milliseconds: 300), width: _isSearching ? 0 : 8),

        // filter slides + shrinks
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _isSearching ? 0 : 48,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _isSearching ? 0 : 1,
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF7B1FA2), Color(0xFF512DA8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.tune, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
