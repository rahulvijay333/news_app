import 'package:flutter/material.dart';
import 'package:news_app_rv/domain/model/news_model.dart';
import 'package:news_app_rv/presentation/details/screen_details.dart';

class NewsTileWidget extends StatelessWidget {
  const NewsTileWidget({
    super.key,
    required this.size,
    required this.date,
    required this.newsList,
  });

  final Size size;
  final String? date;
  final Article newsList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return ScreenDetails(
                  article: newsList,
                );
              },
            ));
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  height: 180,
                  width: size.width,
                  child: newsList.urlToImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: newsList.urlToImage != null
                              ? Image.network(
                                  newsList.urlToImage,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1,
                                        color: Colors.deepPurple,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/image_placeholder.png',
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                              : Image.asset('assets/image_placeholder.png'),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/image_placeholder.png',
                            fit: BoxFit.cover,
                          )),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  newsList.title ?? 'No Title',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(newsList.source!.name ?? 'source'),
                    Text(date ?? 'date')
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
