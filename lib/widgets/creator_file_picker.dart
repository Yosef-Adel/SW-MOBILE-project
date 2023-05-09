// import 'package:flutter/material.dart';
// import 'package:form_builder_file_picker/form_builder_file_picker.dart';

// class CreatorFilePicker extends StatelessWidget {
//   const CreatorFilePicker({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               child: FormBuilderFilePicker(
//                 name: "attachments",
//                 previewImages: true,
//                 allowMultiple: false,
//                 withData: true,
//                 decoration: const InputDecoration(border: InputBorder.none),
//                 typeSelectors: [
//                   TypeSelector(
//                     type: FileType.any,
//                     selector: Row(
//                       children: [
//                         const Icon(Icons.attachment),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 8.0),
//                           child: Text("Add Promocodes file"),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//                 onChanged: (files) {
//                   for (var file in files!) {
//                     attachments.add(
//                       base64.encode(file.bytes!),
//                     );
//                   }
//                 },
//               ),
//             ),
//   }
// }
