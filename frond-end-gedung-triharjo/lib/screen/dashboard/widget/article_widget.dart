import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/screen/article/article_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleWidget extends StatefulWidget {
  const ArticleWidget({super.key});

  @override
  State<ArticleWidget> createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(
            height: 55,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 0),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: TextField(
                // controller: searchController,
                onChanged: (value) {
                  // setState(() {
                  //   isSearching = true;
                  // });
                  // filterAdzanList(value);
                },
                decoration: InputDecoration(
                  hintText: 'Cari Artikel',
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  // contentPadding: const EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Artikel'),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ArticleScreen(),
                      ));
                },
                child: const Text(
                  'See All',
                  style: TextStyle(
                    color: Color(0xFF3E70F2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              _launchURL('https://triharjosid.slemankab.go.id/first');
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(color: Colors.black12),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Website Resmi dari Gedung Triharjo..',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Website Resmi dari Gedung Triharjo berisi informasi keseluruhan pemerintah kelurahan triharjo sleman...',
                          style: TextStyle(),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Image.asset(
                      'assets/image/dashboard/article.png',
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
