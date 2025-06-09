import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ojps_flutter/services/job_service.dart';
import 'package:ojps_flutter/constants/colors.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _searchResults = [];
  bool _noResults = false;
  bool _isLoading = false;
  Timer? _debounce;

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (value.isEmpty) {
        setState(() {
          _searchResults = [];
          _noResults = false;
          _isLoading = false;
        });
        return;
      }

      setState(() {
        _isLoading = true;
        _noResults = false;
      });

      try {
        final results = await JobService().searchJobs(value);
        setState(() {
          _searchResults = results;
          _noResults = results.isEmpty;
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _searchResults = [];
          _noResults = true;
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          onChanged: _onSearchChanged,
          decoration: InputDecoration(
            hintText: "Search jobs",
            hintStyle: TextStyle(color: Colorss.greyColor),
            prefixIcon: Icon(Icons.search, color: Colorss.greyColor),
            filled: true,
            fillColor: Colorss.whiteColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colorss.greyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colorss.primaryColor),
            ),
          ),
        ),

        if (_isLoading)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),

        if (_searchResults.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: Colorss.whiteColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [BoxShadow(color: Colorss.primaryTextColor, blurRadius: 4)],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final job = _searchResults[index];
                return ListTile(
                  title: Text(job['title'] ?? '', style: const TextStyle(color: Colorss.primaryTextColor)),
                  subtitle: Text(
                    '${job['category'] ?? ''} | ${job['location'] ?? ''} | ${job['employer']?['company_name'] ?? ''}',
                    style: TextStyle(fontSize: 12, color: Colorss.greyColor),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/job_details',
                      arguments: job,
                    );
                    _controller.clear();
                    setState(() {
                      _searchResults = [];
                    });
                  },
                );
              },
            ),
          ),

        if (_noResults)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text("NO JOB FOUND", style: TextStyle(color: Colorss.closedColor)),
          ),
      ],
    );
  }
}
