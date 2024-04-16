import 'package:fivec_notes/main.dart';
import 'package:fivec_notes/models/course.dart';
import 'package:fivec_notes/models/directory.dart';
import 'package:fivec_notes/models/file.dart';
import 'package:fivec_notes/widgets/directory/add_directory.dart';
import 'package:fivec_notes/widgets/file/create_file.dart';
import 'package:fivec_notes/widgets/filetree/directory_row.dart';
import 'package:fivec_notes/widgets/filetree/file_row.dart';
import 'package:flutter/material.dart';

/// The [StatefulWidget] representing the [CourseRow] top level object that composes the [FileTree]
///
/// An expandable/collapsable widget representing a given [Course] that the student is enrolled in. 
/// This is the top level collapsable element in the filetree
class CourseRow extends StatefulWidget {
  
  /// The [Course] object that the [CourseRow] is representing
  final Course course;


  /// The list of [Directory] objects that exist under the course
  List<Directory> directories = [Directory(uuid: "1234", name: "Some Folder", parent: ".", user: "1234", course: "123")];

  ///
  List<File> files = [];

  /// The default constructor for the [CourseRow]
  ///
  /// The constructor that will be used to pass in a [course] to the [CourseRow]
  CourseRow({
    Key? key,
    required this.course
  }) : super(key: key);

  @override
  State<CourseRow> createState() => CourseRowState();
}

/// The primary state of the [CourseRow] [StatefulWidget]
/// 
/// This state encodes the contents of the [CourseRow] and will update as necessary
class CourseRowState extends State<CourseRow> {

  
  /// whether the dropdown is expanded or not
  bool isExpanded = false;

  /// whether the row is hovered or not
  bool isHovered = false;

  /// The method to delete the directory
  deleteDirectory(Directory directory) {
    setState(() {
      widget.directories.remove(directory);
    });
  }

  /// Creates a file within the course
  ///
  /// Adds a file to the course at the top level (meaning this file resides in no folder)
  void createSubfile(String fileName) {
    setState(() {
      widget.files.add(File(uuid: "ignr", name: fileName, author: "ngrgn", createdAt: DateTime(2024), lastEdited: DateTime(2024), course: widget.course.uuid));
    });
  }

  void deleteSubFile(File file) {
    setState(() {
      widget.files.remove(file);
    });
  }

  /// This function will load the courses and files for a given course
  /// 
  /// To enable lazy loading on old courses. When an old course is expanded, it will call this function to retrieve the 
  /// courses and their contents using the [FileService]
  void loadCourse(Course course) {

  }

  /// The function to create a directory within the Course
  ///
  /// This function takes the name sent by the [AddDirectory] widget and creates a new [Directory]
  /// from it that lives within the [Course]
  void createDirectory(String directoryName) {
    setState(() {
      widget.directories.add(Directory(uuid: "xdd", name: directoryName, parent: ".", user: "-", course: widget.course.uuid));
      isExpanded = true;  
    });
    
  }

  /// The [build] method contains the widgets and content that makeup the [CourseRow]
  ///
  /// This method will be called everytime the state is updated to rebuild the State and widget
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: Theme.of(context).appColors.backgroundRow,
          child: InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            onHover: (hovered) {
              setState(() {
                isHovered = hovered;
              });
            },
            hoverColor: Theme.of(context).appColors.backgroundDarkerComponent,
            child: Padding(
              padding: isHovered ? const EdgeInsets.only(left: 20, top: 3, bottom: 3, right: 10) : const EdgeInsets.only(left: 20, top: 5, bottom: 5, right: 10),
              child: Row(
          
                children: [
                  
                  Text(
                    widget.course.name,
                    style: TextStyle(color: Theme.of(context).appColors.textDefault),
                    ),
                  const Spacer(),
                  if (isHovered) ...[
                    IconButton(
                      padding: const EdgeInsets.all(2),
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        showDialog(
                          context: context, 
                          builder: (BuildContext context) {
                            return AddDirectory(parent: widget.course, createDirectory: createDirectory);
                          }
                        );
                      },
                      tooltip: "Create Folder",
                      icon: Icon(
                        Icons.create_new_folder_outlined,
                        color: Theme.of(context).appColors.textDefault,
                      ),
                    ),
                    IconButton(
                      padding: const EdgeInsets.all(2),
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        showDialog(
                          context: context, 
                          builder: (BuildContext context) {
                            return CreateFile(parentName: widget.course.name, createFunc: createSubfile);
                          }
                        );
                      },
                      tooltip: "Create file",
                      icon: Icon(
                        Icons.add,
                        color: Theme.of(context).appColors.textDefault,
                      ),
                    ),
                  ],
                    
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isExpanded) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.directories.length,
                itemBuilder: (BuildContext context, int index) {
                  return DirectoryRow(directory: widget.directories[index], deleteFunction: deleteDirectory,);
                }
              )
              
            ],
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.files.length,
              itemBuilder: (BuildContext context, int index) {
                return FileRow(file: widget.files[index], deleteFunc: deleteSubFile);
              }
            )
          ],
        )
        ]
        
      ],
      );
   
  }
}