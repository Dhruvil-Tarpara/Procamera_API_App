import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    String image = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image details"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height * 0.4,
              width: size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.white.withOpacity(0.3),
                  Colors.white.withOpacity(0.6)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              "he image description feature is part of the Analyze Image API. "
              "You can call this API using REST. Include Description in the features query parameter. "
              "Then, when you get the full JSON response, parse the string for the contents of the description section.Computer Vision can analyze an image and generate a human-readable phrase that describes its contents. ",
              style: TextStyle(fontSize: 14),
            ),
          ),
          Center(
            child: OutlinedButton(
              onPressed: () async {
                final imageId = await ImageDownloader.downloadImage(image);
                if (imageId == null) {
                  print("Not got");
                  return null;
                }
                // Below is a method of obtaining saved image information.
                var fileName = await ImageDownloader.findName(imageId);
                var path = await ImageDownloader.findPath(imageId);
                var size = await ImageDownloader.findByteSize(imageId);
                var mimeType = await ImageDownloader.findMimeType(imageId);
                print(path);
                Navigator.pop(context);
                ('Image downloaded.');
                try {
                  // Saved with this method.
                } on PlatformException catch (error) {
                  print(error);
                } catch (e) {
                  print(e);
                }
                setState(() {});
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                side: MaterialStateProperty.all(
                    const BorderSide(color: Colors.black, width: 2)),
              ),
              child: const Text(
                "Download",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
