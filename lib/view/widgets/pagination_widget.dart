import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaginationWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final bool isAtStart;
  final bool isAtEnd;

  const PaginationWidget({
    super.key,
    required this.currentPage,
    required this.totalPages,
    this.onPrevious,
    this.onNext,
    required this.isAtStart,
    required this.isAtEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            alignment: Alignment(-5, 0),
            icon: SvgPicture.asset(
              "assets/icons/arrow-left.svg",
              color: isAtStart ? Colors.grey[400] : Colors.black,
            ),
            onPressed: onPrevious,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            decoration: BoxDecoration(
              color: Color(0xFFF9FAFB),
              border: Border.symmetric(
                vertical: BorderSide(color: Color(0xFFCBCACA)),
              ),
            ),
            child: Text(
              '${currentPage + 1}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF455468),
              ),
            ),
          ),
          IconButton(
            alignment: Alignment(6, 0),
            icon: SvgPicture.asset(
              "assets/icons/arrow-right.svg",
              color: isAtEnd ? Colors.grey[400] : Colors.black,
            ),
            onPressed: onNext,
          ),
        ],
      ),
    );
  }
}
