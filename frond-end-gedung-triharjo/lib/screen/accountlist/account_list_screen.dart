import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/model/list_user_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/account_detail/account_detail_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/accountlist/account_list_view_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/error/error_widget.dart';
import 'package:provider/provider.dart';

class AccountListScreen extends StatefulWidget {
  const AccountListScreen({super.key});

  @override
  State<AccountListScreen> createState() => _AccountListScreenState();
}

class _AccountListScreenState extends State<AccountListScreen> {
  late Future<void> userDataViewModel;
  @override
  void initState() {
    super.initState();
    final userViewModel =
        Provider.of<AccountListViewModel>(context, listen: false);
    userDataViewModel = userViewModel.getAllListUser();
    filteredUserData = userViewModel.allUserData;
  }

  String formatLine(String input) {
    List<String> words = input.split(' ');

    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }

    return words.join(' ');
  }

  TextEditingController searchController = TextEditingController();
  List<ListUserModel?> allUserData = [];
  List<ListUserModel?> filteredUserData = [];

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List Account',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF3E70F2),
        centerTitle: true,
      ),
      body: Consumer<AccountListViewModel>(builder: (
        context,
        provider,
        _,
      ) {
        void filterUserList(String query) {
          final filteredList = provider.allUserData.where((user) {
            return user!.email.toLowerCase().contains(query.toLowerCase());
          }).toList();

          setState(() {
            filteredUserData = filteredList;
          });
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        isSearching = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari Berdasarkan Email...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(15, 1, 1, 1),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          isSearching = true;
                        });
                        filterUserList(searchController.text);
                      },
                    ),
                  ),
                ),
              ),
              FutureBuilder(
                future: userDataViewModel,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return ErrorWidgetScreen(onRefreshPressed: () {
                      provider.getAllListUser();
                    });
                  } else {
                    return ListView.builder(
                      itemCount: isSearching
                          ? filteredUserData.length
                          : provider.allUserData.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var data = isSearching
                            ? filteredUserData[index]
                            : provider.allUserData[index];
                        return InkWell(
                          onTap: () {
                            searchController.clear();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AccountDetailScreen(
                                  nama: data!.nama,
                                  email: data.email,
                                  noKTP: data.noKTP,
                                  gender: data.gender,
                                  noTelp: data.noTelp,
                                  warga: "${data.wargaTriharjo}",
                                  alamat:
                                      "${data.dukuh}, ${data.kelurahan}, ${data.kecamatan}, ${data.dukuh}, RT ${data.rt} / RW ${data.rw}, Indonesia",
                                  typeUser: data.typeUser,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            margin: isSearching
                                ? index + 1 != filteredUserData.length
                                    ? const EdgeInsets.fromLTRB(16, 16, 16, 0)
                                    : const EdgeInsets.all(16)
                                : index + 1 != provider.allUserData.length
                                    ? const EdgeInsets.fromLTRB(16, 16, 16, 0)
                                    : const EdgeInsets.all(16),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 5.0,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              border: const Border(
                                top: BorderSide(
                                  color: Color(0xFF3E70F2),
                                  width: 10.0,
                                ),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    data!.gender == 'l'
                                        ? const Icon(
                                            Icons.person,
                                            color: Color(0xFF3E70F2),
                                            size: 40,
                                          )
                                        : const Icon(
                                            Icons.person_2,
                                            color: Colors.pink,
                                            size: 40,
                                          ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          formatLine(data.nama),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          data.email,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  formatLine(data.typeUser),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
