import 'package:fivec_notes/main.dart';
import 'package:flutter/material.dart';

/// The class to handle naming a new file that is being created
///
/// A wrapper around [SimpleDialog] to facilitate creating new files
class CreateFile extends StatefulWidget {

  

 
  /// The name of the parent course or directory
  final String parentName;

  /// The function in the parent course or directory to handle file creation
  final Function(String) createFunc;

  /// The constructor for the [CreateFile] class
  ///
  /// This constructor will be called from the row to create a new file
  const CreateFile({
    Key? key,
    required this.parentName,
    required this.createFunc
  }) : super (key: key);

  @override
  State<CreateFile> createState() => CreateFileState();
}

/// Primary state of the [CreateFile] class
///
/// This handles the creation of the widget and its contents as well as rebuilding them
class CreateFileState extends State<CreateFile> {

  TextEditingController _controller = TextEditingController();

  @override
  initState() {
    _controller = TextEditingController(text: "");
    super.initState();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Exit out of new file creation
  ///
  /// Closes the modal and returns to previous screen
  void cancelNewFile() {
    Navigator.pop(context);
  }

  /// Ensures the file name is valid
  ///
  /// Uses regex to validate the name of the file being created
  bool validateName(String name) {
    // Create regex to validate file name
     RegExp regex = RegExp(
      r'^[a-zA-Z0-9_\-\.]+$',
      caseSensitive: false,
    );

    // Check if the file name matches the regular expression
    return regex.hasMatch(name);
  }

  /// Creates the new file
  ///
  /// validates name and passes it to parent row
  void createFile() {
    if (validateName(_controller.text)) {
      widget.createFunc(_controller.text);
      Navigator.pop(context);
    } else {
      return;
    }
  }


  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text("Create new file"),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 20, bottom: 30, right: 30),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: "File Name:",
                  border: OutlineInputBorder()
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10,),
        Row(
          children: <Widget>[
            const Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      color: Theme.of(context).appColors.backgroundDefault,
                    )
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).appColors.backgroundRow,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                    ),
                    onPressed: () {
                      createFile();
                    }, 
                    child: const Text("Create File"),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      color: Theme.of(context).appColors.textHover,
                    )
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).appColors.backgroundRow,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                    ),
                    onPressed: () {
                      cancelNewFile();
                    }, 
                    child: const Text("Cancel"),
                    
                  ),
                ],
              )
              
            ),
            const Padding(padding: EdgeInsets.only(right: 30))
          ],
        )
      ],
    );
  }
}