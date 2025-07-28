import 'package:api_project/controller/digimon_provider.dart';
import 'package:api_project/model/digimon_model.dart';
import 'package:api_project/view/widgets/digimon_card_widget.dart';
import 'package:api_project/view/widgets/digimon_text_field_widget.dart';
import 'package:api_project/view/widgets/pagination_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _itemPerPage = 3;
  int _currentPage = 0;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DigimonProvider>(context, listen: false).getAllDigimon();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DigimonProvider>(context);
    final digimonList = provider.filteredDigimonList;
    final isLoading = provider.isLoading; //controller

    int totalPages = (digimonList.length / _itemPerPage).ceil(); //controller
    //
    List<DigimonModel> currentItems = digimonList
        .skip(_currentPage * _itemPerPage)
        .take(_itemPerPage)
        .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70),
              SvgPicture.asset("assets/icons/DIGIMON.svg"),
              SizedBox(height: 20),

              // Search field
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: DigimonTextField(controller: _searchController),
                  ),
                  IconButton(
                    onPressed: () {
                      final item = _searchController.text.trim();
                      provider.searchByName(item);
                      setState(() {
                        _currentPage = 0; //searchByName
                      });
                    },
                    icon: SvgPicture.asset("assets/icons/content.svg"),
                  ),
                ],
              ),

              // State of Show Data
              if (isLoading)
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: CircularProgressIndicator(),
                )
              else if (currentItems.isEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Center(
                    child: Text(
                      "No Digimon found.",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              else ...[
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: currentItems.length,
                  itemBuilder: (context, index) {
                    final digimon = currentItems[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      child: DigimonCard(digimon: digimon),
                    );
                  },
                ),

                PaginationWidget(
                  currentPage: _currentPage,
                  totalPages: totalPages,
                  isAtStart: _currentPage == 0,
                  isAtEnd: _currentPage == totalPages - 1,
                  onPrevious: () {
                    if (_currentPage > 0) {
                      setState(() {
                        _currentPage--;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("You are already at the first page."),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      );
                    }
                  },
                  onNext: () {
                    if (_currentPage < totalPages - 1) {
                      setState(() {
                        _currentPage++;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("You have reached the last page."),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      );
                    }
                  },
                ),

                SizedBox(height: 25),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
