import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'package:flutter/material.dart';

/// Right now only image is getting changed in this

class UploadPdf extends StatefulWidget {
  const UploadPdf({Key? key}) : super(key: key);

  @override
  State<UploadPdf> createState() => _UploadPdfState();
}

class _UploadPdfState extends State<UploadPdf> {
  String? pdfPath;

  File? pdfFile;

  String? imagePath;

  String? fileType;

  int variable = 0;

  FilePickerResult? selectedFile;

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
                    TextButton(
                        onPressed: () async {
                          await uploadPdf();
                        },
                        child: const Text("Upload Pdf")),

                    TextButton(
                        onPressed: () async {
                          // await uploadImage();
                          // await pickFile(context);
                        },
                        child: const Text("Upload Image")
                    ),

                    ElevatedButton(
                      onPressed: () async {
                        await selectFile();
                      },
                      child: Text("Documents")
                    ),

                    /// Todo: Related to image
                    // Image.file(
                    //   File(imagePath.toString()),
                    //   width: 100,
                    //   height: 100,
                    //   fit: BoxFit.fill,
                    // ),

                    // ElevatedButton(
                    //   onPressed: () {
                    //     // setState(() {
                    //     //
                    //     // });
                    //   },
                    //   child: Image.file(
                    //     // File(pdfFile.toString()),
                    //     File(imagePath.toString()),
                    //     width: 300,
                    //     height: 300,
                    //     fit: BoxFit.fill,
                    //   ),
                    // )

                    /// Todo: using ? operator
                    // (imagePath == null)
                    // ?
                    // Text("Nothing")
                    // :
                    // Container(
                    //   height: 1800,
                    //   child: SfPdfViewer.file(
                    //     // File('storage/emulated/0/Download/gis_succinctly.pdf'),
                    //     // File(imagePath.toString()),
                    //     File(imagePath!),
                    //   ),
                    // ),

                    /// Todo: using if statements
                    // if(imagePath == null) Text("Nothing"),
                    // if(imagePath != null)
                    //   Container(
                    //     height: 1800,
                    //     child: SfPdfViewer.file(
                    //       // File('storage/emulated/0/Download/gis_succinctly.pdf'),
                    //       // File(imagePath.toString()),
                    //       File(imagePath!),
                    //     ),
                    //   ),

                    /// Todo: Using if else, else if staements
                    /// First Section => If we are using if after if then we should separate widgets by comma[,]
                    // if(imagePath == null)
                    //   Container(
                    //     child: Text("Nothing"),
                    //   ), // Here we used comma to separate other conditional statement
                    // if(variable == 1)
                    //   Container(
                    //     child: Text("Aisi"),
                    //   )

                    /// Second Section => If we are using if else , else if then should not  separate widgets by comma[,]
                    // if(imagePath == null)
                    //   Container(
                    //     child: Text("Nothing"),
                    //   ) // Here comma is not used to separate other condition statement
                    // else if(imagePath != null)
                    //   Container(
                    //     height: MediaQuery.of(context).size.height,
                    //     child: Expanded(
                    //       child: SfPdfViewer.file(
                    //         // File('storage/emulated/0/Download/gis_succinctly.pdf'),
                    //         // File(imagePath.toString()),
                    //         File(imagePath!),
                    //       ),
                    //     ),
                    //   )
                    // else
                    //   Container(
                    //     child: Text("An error has occured")
                    //   )

                    /// Todo: Using if else, else if statements with ...[] showing pdf
                    // if (pdfPath == null) ...[
                    //   Text("Nothing"),
                    // ] else
                    if (pdfPath != null) ...[
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: Expanded(
                          child: SfPdfViewer.file(
                            // File('storage/emulated/0/Download/gis_succinctly.pdf'),
                            // File(imagePath.toString()),
                            File(pdfPath!),
                          ),
                        ),
                      ),
                    ],
                    // else ...[
                    //   Container(
                    //     child: Text("An error has occured"),
                    //   )
                    // ],

                    /// Todo: showing image
                    // if (imagePath == null) ...[
                    //   Container(
                    //     child: Text("Please select jpg or pdf file"),
                    //   )
                    // ] else
                    if (imagePath != null) ...[
                      Container(
                          // height: MediaQuery.of(context).size.height,
                          child: Image.file(
                        // File(pdfFile.toString()),
                        File(imagePath.toString()),
                        width: 300,
                        height: 300,
                        fit: BoxFit.fill,
                      ))
                    ],

                    /// Todo: Function to show any file type
                    if(fileType == null) ...[
                      Container(
                        child: Text("Nothing"),
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
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: Expanded(
                          child: SfPdfViewer.file(
                            // File('storage/emulated/0/Download/gis_succinctly.pdf'),
                            // File(imagePath.toString()),
                            File(pdfPath!),
                          ),
                        ),
                      ),
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

  /// Todo: Function For uploading file
  uploadPdf() async {
    // FilePickerResult? result = await FilePicker.platform.pickFiles();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf'],
    );
    if (result != null) {
      setState(() {
        File file = File(result.files.single.path ?? " ");
        // pdfFile = file;
        variable = 1;

        String fileName = file.path.split("/").last;
        String path = file.path;
        pdfPath = path.toString();
        print("file " + file.toString());
        print("fileName " + fileName.toString());
        print("path " + path.toString());
      });

      //
      // return path.toString();
    }
  }

  /// Todo: Function to select any file
  selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
    );


    if (result != null) {

      int sizeInBytes = result.files.first.size;

      setState(() {
        File file = File(result.files.single.path ?? " ");
        // pdfFile = file;
        variable = 1;

        /// Todo: Usefull
        // String fileName = file.path.split("/").last;
        // String path = file.path;
        // imagePath = path.toString();

        /// Todo: Testing
        // if (!(imagePath!.contains(".jpg")) ||
        //     !(imagePath!.contains(".jpeg")) ||
        //     !(imagePath!.contains(".pdf"))) {
        //   imagePath = "";
        // }

        /// Todo: Tesing 1

        if(sizeInBytes > 1048576) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('File size limit exceed'),
              content: Text('File should be in jpg or pdf format and size limit is 1MB'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
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

          print("imagePath " + imagePath!);
          print("file " + file.toString());
          print("fileName " + fileName.toString());
          print("path " + path.toString());
        } else {
          String fileName = file.path.split("/").last;
          String path = file.path;
          fileType = path.toString();

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Invalid file format'),
              content: Text('Please select a JPG or PNG format file'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
          );

          print("imagePath " + fileType!);
          print("file " + file.toString());
          print("fileName " + fileName.toString());
          print("path " + path.toString());

          fileType = null;
        }
      });
    }
  }


  /// Todo: For uploading image
  uploadImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png'],
    );


    if (result != null) {

      int sizeInBytes = result.files.first.size;

      setState(() {
        File file = File(result.files.single.path ?? " ");
        // pdfFile = file;
        variable = 1;

        /// Todo: Usefull
        // String fileName = file.path.split("/").last;
        // String path = file.path;
        // imagePath = path.toString();

        /// Todo: Testing
        // if (!(imagePath!.contains(".jpg")) ||
        //     !(imagePath!.contains(".jpeg")) ||
        //     !(imagePath!.contains(".pdf"))) {
        //   imagePath = "";
        // }

        /// Todo: Tesing 1

        if(sizeInBytes > 1048576) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('File size limit exceed'),
              content: Text('File should be in jpg or pdf format and size limit is 1MB'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
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
          imagePath = path.toString();

          print("imagePath " + imagePath!);
          print("file " + file.toString());
          print("fileName " + fileName.toString());
          print("path " + path.toString());
        } else {
          String fileName = file.path.split("/").last;
          String path = file.path;
          imagePath = path.toString();

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Invalid file format'),
              content: Text('Please select a JPG or PNG format file'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
          );

          print("imagePath " + imagePath!);
          print("file " + file.toString());
          print("fileName " + fileName.toString());
          print("path " + path.toString());

          imagePath = null;
        }
      });
    }
  }

  ///Todo: Vipin sir given this func to test
  // Future<void> pickFile(BuildContext context) async {
  //   selectedFile = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['jpg', 'png'],
  //
  //     // maxBytes: 1024 * 1024, // set the maximum file size to 1 MB'
  //   );
  //
  //   // int sizeInBytes = selectedFile!.files.first.lengthSync();
  //   int sizeInBytes = selectedFile!.files.first.size;
  //   print("sizeInBytes");
  //   print(sizeInBytes.toString());
  //
  //   // 1048576
  //
  //   if (selectedFile != null && selectedFile!.files.first.extension == 'webp') {
  //     print("Here");
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: Text('Invalid file format'),
  //         content: Text('Please select a JPG or PNG format file'),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: Text('OK'),
  //           ),
  //         ],
  //       ),
  //     );
  //     selectedFile = null;
  //   } else if(sizeInBytes > 1048576) {
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: Text('Invalid file format'),
  //         content: Text('File Size is more than 1MB'),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: Text('OK'),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }


}
