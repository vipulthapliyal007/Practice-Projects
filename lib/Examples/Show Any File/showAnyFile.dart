import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ShowAnyFile extends StatefulWidget {
  const ShowAnyFile({Key? key}) : super(key: key);

  @override
  State<ShowAnyFile> createState() => _ShowAnyFileState();
}

class _ShowAnyFileState extends State<ShowAnyFile> {

  String? fileType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Pdf"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.topLeft,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await selectFile();
                      },
                      child: const Text("Documents")
                    ),

                    /// Todo: Function to show any file type
                    if(fileType == null) ...[
                      Container(
                        child: const Text("Nothing"),
                      )
                    ] else if(fileType!.contains("jpg")) ...[
                      Container(
                        // height: MediaQuery.of(context).size.height,
                        child: Image.file(
                          // File(pdfFile.toString()),
                          File(fileType.toString()),
                          width: 300,
                          height: 300,
                          fit: BoxFit.fill,
                        )
                      )
                    ] else if(fileType!.contains("pdf")) ...[
                      /// Shwing pdf in container
                      // Container(
                      //   child: Expanded(
                      //     child: SfPdfViewer.file( // To show pdf
                      //       // File('storage/emulated/0/Download/gis_succinctly.pdf'),
                      //       // File(imagePath.toString()),
                      //       File(fileType!),
                      //     ),
                      //   ),
                      // ),

                      /// Showing pdf using container
                      showPdf(),
                    ]
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Todo: Function to select any file
  selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      // type: FileType.any,
    );

    if (result != null) {
      int sizeInBytes = result.files.first.size;

      setState(() {
        File file = File(result.files.single.path ?? " ");

        /// Todo: Testing 1
        if(sizeInBytes > 1048576) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('File size limit exceed'),
              content: const Text('File should be in jpg or pdf format and size limit is 1MB'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else if(
        result.files.first.extension == "jpg" ||
          // result.files.first.extension == "jpeg" ||
          result.files.first.extension == "pdf"
        ) {
          String fileName = file.path.split("/").last;
          String path = file.path;
          fileType = path.toString();

          print("file ${file.toString()}");
          print("fileName ${fileName.toString()}");
          print("path ${path.toString()}");
        } else {
          String fileName = file.path.split("/").last;
          String path = file.path;
          fileType = path.toString();

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Invalid file format'),
              content: const Text('Please upload a JPG or PDG format file'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );

          print("imagePath ${file.toString()}");
          print("file ${file.toString()}");
          print("fileName ${fileName.toString()}");
          print("path ${path.toString()}");

          fileType = null;
        }
      });
    }
  }

  Widget showPdf() {
    print("x");
    return Container(
      child: Expanded(
        child: SfPdfViewer.file( // To show pdf
          // File('storage/emulated/0/Download/gis_succinctly.pdf'),
          // File(imagePath.toString()),
          File(fileType!),
        ),
      ),
    );
  }
}
