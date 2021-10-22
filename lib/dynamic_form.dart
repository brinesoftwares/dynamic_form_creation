import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DynamicForm extends StatefulWidget {
  const DynamicForm({Key? key}) : super(key: key);

  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  final GlobalKey<FormState> _key = GlobalKey();
  List<TextEditingController> dateController = [];
  List<GlobalKey<FlutterSummernoteState>> htmlKeys = [];
  bool _validate = false;
  List<bool> showPass = [];
  List<String> imageUndo = [];
  List<File?> selectedfile = [];

  List apiWidget = [
    {
      "field": "image",
      "title": "profile_photo",
      "hint": "Upload your Photo",
      "value": "",
      "format": "png",
      "path": "",
      "any_size": true,
      "ratio_x": 1.0,
      "ratio_y": 1.2,
      "validate": {
        "required": true,
      }
    },
    {
      "field": "file",
      "title": "pdf_file",
      "hint": "Upload your PDF",
      "value": "",
      "path": "",
      "format": [
        "pdf",
      ],
      "validate": {
        "required": false,
      }
    },
    {
      "field": "file",
      "title": "doc_file",
      "hint": "Upload your Document",
      "value": "",
      "path": "",
      "format": [
        "pdf",
      ],
      "validate": {
        "required": true,
      }
    },
    {
      "field": "image",
      "title": "id_proof_photo",
      "hint": "Upload your ID proof",
      "value":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBlFpQ-KBTwAmI4yMfNUk0VRRa4HQcj34NJg&usqp=CAU",
      "format": "jpg",
      "any_size": false,
      "ratio_x": 1.6,
      "ratio_y": 1.0,
      "validate": {
        "required": true,
      }
    },
    {
      "field": "htmleditor",
      "title": "brief",
      "value": "",
      "validate": {
        "required": false,
      }
    },
    {
      "field": "htmleditor",
      "title": "about_you",
      "value": "im dinesh",
      "validate": {
        "required": true,
      }
    },
    {
      "field": "input",
      "title": "name",
      "value": "dinesh",
      "hint": "Full Name",
      "validate": {
        "required": true,
        "regexp": "",
        "regexp_msg": "",
        "length": 0,
        "length_msg": "Name must be 5 char",
      }
    },
    {
      "field": "pass",
      "title": "password",
      "value": "12345678c",
      "hint": "Password",
      "validate": {
        "required": true,
        "regexp": r'(^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$)',
        "regexp_msg": "Minimum 8 characters, atleast one letter and one number",
        "min_length": 8,
        "max_length": 10,
        "length_msg": "Password must be 8-10 char",
      }
    },
    {
      "field": "confirm_pass",
      "title": "confirm_password",
      "hint": "confirm Password",
      "value": "12345678c",
      "validate": {
        "required": true,
        "regexp": r'(^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$)',
        "regexp_msg": "Minimum 8 characters, atleast one letter and one number",
        "min_length": 8,
        "max_length": 10,
        "length_msg": "Password must be 8-10 char",
      }
    },
    {
      "field": "mobile",
      "title": "mobile",
      "hint": "Mobile Number",
      "value": "1234567890",
      "validate": {
        "required": true,
        "regexp": r'(^[0-9]*$)',
        "regexp_msg": "Mobile Number must be digits",
        "length": 10,
        "length_msg": "Mobile number must be 10 digits",
      }
    },
    {
      "field": "email",
      "title": "email",
      "value": "dinesh@gmail.com",
      "hint": "Email ID",
      "validate": {
        "required": true,
        "regexp":
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
        "regexp_msg": "Invalid Email",
      }
    },
    {
      "field": "number",
      "title": "Age",
      "value": "01",
      "hint": "Your age",
      "validate": {
        "required": true,
        "regexp": r'^(\d?[1-9]|[1-9]0)$',
        "regexp_msg": "Age must be 1-99",
      }
    },
    {
      "field": "select",
      "title": "gender",
      "hint": "Select Gender",
      "value": "Value2",
      "validate": {
        "required": true,
      },
      "select_values": [
        {"key": "Key1", "value": "Value1"},
        {"key": "Key2", "value": "Value2"},
        {"key": "Key3", "value": "Value3"},
      ]
    },
    {
      "field": "radio",
      "title": "gender",
      "value": 2,
      "validate": {
        "required": true,
      },
      "radio_values": [
        {"title": "Male", "value": 1},
        {"title": "Female", "value": 2},
        {"title": "Other", "value": 3},
      ]
    },
    {
      "field": "multiselect",
      "title": "preferred cities",
      "value": [
        "chennai,",
        "salem'",
      ],
      "validate": {
        "required": true,
      },
      "select_values": [
        {"title": "chennai", "value": "chennai,"},
        {"title": "salem", "value": "salem'"},
        {"title": "erode", "value": "erode"},
        {"title": "covai", "value": "covai"},
      ]
    },
    {
      "field": "switch",
      "title": " is required",
      "value": true,
      "validate": {
        "required": true,
      },
    },
    {
      "field": "datepicker",
      "title": "start_date",
      "hint": "Start Date",
      "date_format": "yyyy-MM-dd",
      "fromDate": "2020-11-21",
      "toDate": "2022-11-21",
      "value": "2021-10-05",
      "validate": {
        "required": true,
        "regexp": "",
        "regexp_msg": "",
        "length": 0,
        "length_msg": "",
      }
    },
    {
      "field": "datepicker",
      "title": "end_date",
      "hint": "End Date",
      "date_format": "yyyy-MM-dd",
      "fromDate": "2020-11-21",
      "toDate": "2022-11-21",
      "value": "2021-10-15",
      "validate": {
        "required": true,
        "regexp": "",
        "regexp_msg": "",
        "length": 0,
        "length_msg": "",
      }
    },
  ];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < apiWidget.length; i++) {
      showPass.add(false);
      // imageFile.add(null);
      selectedfile.add(null);
      imageUndo.add("");
      dateController.add(TextEditingController());
      htmlKeys.add(GlobalKey());
      if (apiWidget[i]["field"] == "datepicker") {
        dateController[i].text = apiWidget[i]["value"];
      }
    }
  }

  List<Widget> buildWidget() {
    List<Widget> formWidgets = [];
    for (var i = 0; i < apiWidget.length; i++) {
      switch (apiWidget[i]["field"]) {
        case "file":
          formWidgets.add(Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(40),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: selectedfile[i] == null
                        ? const Text("Choose File")
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(selectedfile[i]!.path.split("/").last),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedfile[i] = null;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.clear,
                                    size: 16,
                                  ))
                            ],
                          ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        selectedfile[i] = File(result.paths.first!);
                        setState(() {});
                      } else {}
                    },
                    icon: const Icon(Icons.folder_open),
                    label: const Text("CHOOSE FILE"),
                    style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                  ),
                ],
              )));
          break;

        case "image":
          formWidgets.add(
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.photo),
                          title: const Text('Gallery'),
                          onTap: () {
                            Navigator.pop(context);
                            _pickImage(i, fromCamera: false);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.music_note),
                          title: const Text('Camera'),
                          onTap: () {
                            Navigator.pop(context);
                            _pickImage(i, fromCamera: true);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Stack(
                children: [
                  Container(
                    child: apiWidget[i]["value"] != ""
                        ? Image.network(apiWidget[i]["value"])
                        : selectedfile[i] != null
                            ? Image.file(selectedfile[i]!)
                            : Image.asset("assets/images/no_img.png"),
                  ),
                  Positioned(
                    right: 1,
                    child: Row(
                      children: [
                        imageUndo[i] != ""
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    apiWidget[i]["value"] = imageUndo[i];
                                    imageUndo[i] = "";
                                    selectedfile[i] = null;
                                  });
                                },
                                icon: const CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: 14,
                                    child: Icon(
                                      Icons.undo,
                                      color: Colors.white,
                                      size: 18,
                                    )))
                            : const SizedBox(),
                        (selectedfile[i] != null || apiWidget[i]["value"] != "")
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    imageUndo[i] = apiWidget[i]["value"] == ""
                                        ? imageUndo[i]
                                        : apiWidget[i]["value"];
                                    selectedfile[i] = null;
                                    apiWidget[i]["value"] = "";
                                  });
                                },
                                icon: const CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: 14,
                                    child: Icon(
                                      Icons.clear_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    )))
                            : const SizedBox(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
          break;

        case "input":
          formWidgets.add(TextFormField(
            initialValue: apiWidget[i]["value"],
            decoration: InputDecoration(hintText: apiWidget[i]["hint"]),
            validator: (value) {
              RegExp regExp = RegExp(apiWidget[i]["validate"]["regexp"]);
              if (value!.isEmpty && (apiWidget[i]["validate"]["required"])) {
                return apiWidget[i]["title"].toString().toUpperCase() +
                    " is Required";
              }
              if (value.length != apiWidget[i]["validate"]["length"] &&
                  (apiWidget[i]["validate"]["length"] != 0)) {
                return apiWidget[i]["validate"]["length_msg"];
              }
              if (!regExp.hasMatch(value)) {
                return apiWidget[i]["validate"]["regexp_msg"];
              }
              return null;
            },
            onSaved: (val) {
              apiWidget[i]["value"] = val;
            },
          ));
          break;
        case "mobile":
          formWidgets.add(TextFormField(
            initialValue: apiWidget[i]["value"],
            keyboardType: TextInputType.phone,
            inputFormatters: [
              LengthLimitingTextInputFormatter(
                  apiWidget[i]["validate"]["length"]),
            ],
            decoration: InputDecoration(hintText: apiWidget[i]["hint"]),
            validator: (value) {
              RegExp regExp = RegExp(apiWidget[i]["validate"]["regexp"]);
              if ((apiWidget[i]["validate"]["required"])) {
                if (value!.isEmpty) {
                  return apiWidget[i]["title"].toString().toUpperCase() +
                      " is Required";
                }
                if (value.length != apiWidget[i]["validate"]["length"] &&
                    (apiWidget[i]["validate"]["length"] != 0)) {
                  return apiWidget[i]["validate"]["length_msg"];
                }
                if (!regExp.hasMatch(value)) {
                  return apiWidget[i]["validate"]["regexp_msg"];
                }
                return null;
              }
              return null;
            },
            onSaved: (val) {
              apiWidget[i]["value"] = val;
            },
          ));
          break;

        case "pass":
          formWidgets.add(TextFormField(
            initialValue: apiWidget[i]["value"],
            inputFormatters: [
              LengthLimitingTextInputFormatter(
                  apiWidget[i]["validate"]["max_length"]),
            ],
            decoration: InputDecoration(
                hintText: apiWidget[i]["hint"],
                suffix: InkWell(
                    onTap: () {
                      setState(() {
                        showPass[i] = !showPass[i];
                      });
                    },
                    child: const Icon(Icons.remove_red_eye))),
            obscureText: (showPass[i]),
            validator: (value) {
              RegExp regExp = RegExp(apiWidget[i]["validate"]["regexp"]);
              if ((apiWidget[i]["validate"]["required"])) {
                if (value!.isEmpty) {
                  return apiWidget[i]["title"].toString().toUpperCase() +
                      " is Required";
                }
                if (value.length < apiWidget[i]["validate"]["min_length"]) {
                  return apiWidget[i]["validate"]["length_msg"];
                }
                if (!regExp.hasMatch(value)) {
                  return apiWidget[i]["validate"]["regexp_msg"];
                }
                return null;
              }
              return null;
            },
            onSaved: (val) {
              apiWidget[i]["value"] = val;
            },
            onChanged: (val) {
              apiWidget[i]["value"] = val;
            },
          ));
          break;
        case "confirm_pass":
          formWidgets.add(TextFormField(
            initialValue: apiWidget[i]["value"],
            inputFormatters: [
              LengthLimitingTextInputFormatter(
                  apiWidget[i]["validate"]["max_length"]),
            ],
            decoration: InputDecoration(
                hintText: apiWidget[i]["hint"],
                suffix: InkWell(
                    onTap: () {
                      setState(() {
                        showPass[i] = !showPass[i];
                      });
                    },
                    child: const Icon(Icons.remove_red_eye))),
            obscureText: (showPass[i]),
            validator: (value) {
              RegExp regExp = RegExp(apiWidget[i]["validate"]["regexp"]);
              if ((apiWidget[i]["validate"]["required"])) {
                if (value!.isEmpty) {
                  return apiWidget[i]["title"].toString().toUpperCase() +
                      " is Required";
                }
                if (value.length < apiWidget[i]["validate"]["min_length"]) {
                  return apiWidget[i]["validate"]["length_msg"];
                }
                if (!regExp.hasMatch(value)) {
                  return apiWidget[i]["validate"]["regexp_msg"];
                }
                if (value != apiWidget[i - 1]["value"]) {
                  return "Password not matching";
                }
                return null;
              }
              return null;
            },
            onSaved: (val) {
              apiWidget[i]["value"] = val;
            },
          ));
          break;

        case "email":
          formWidgets.add(TextFormField(
            initialValue: apiWidget[i]["value"],
            keyboardType: TextInputType.emailAddress,
            inputFormatters: [
              LengthLimitingTextInputFormatter(
                  apiWidget[i]["validate"]["max_length"]),
            ],
            decoration: InputDecoration(
              hintText: apiWidget[i]["hint"],
            ),
            validator: (value) {
              RegExp regExp = RegExp(apiWidget[i]["validate"]["regexp"]);
              if ((apiWidget[i]["validate"]["required"])) {
                if (value!.isEmpty) {
                  return apiWidget[i]["title"].toString().toUpperCase() +
                      " is Required";
                }

                if (!regExp.hasMatch(value)) {
                  return apiWidget[i]["validate"]["regexp_msg"];
                }
                return null;
              }
              return null;
            },
            onSaved: (val) {
              apiWidget[i]["value"] = val;
            },
          ));
          break;

        case "number":
          formWidgets.add(TextFormField(
            initialValue: apiWidget[i]["value"],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: apiWidget[i]["hint"],
            ),
            validator: (value) {
              RegExp regExp = RegExp(apiWidget[i]["validate"]["regexp"]);
              if ((apiWidget[i]["validate"]["required"])) {
                if (value!.isEmpty) {
                  return apiWidget[i]["title"].toString().toUpperCase() +
                      " is Required";
                }

                if (!regExp.hasMatch(value)) {
                  return apiWidget[i]["validate"]["regexp_msg"];
                }
                return null;
              }
              return null;
            },
            onSaved: (val) {
              apiWidget[i]["value"] = val;
            },
          ));
          break;

        case "select":
          formWidgets.add(
            DropdownButtonFormField<dynamic>(
              validator: (value) {
                if (value == null || !(apiWidget[i]["validate"]["required"])) {
                  return apiWidget[i]["title"].toString().toUpperCase() +
                      " is Required";
                }
              },
              onSaved: (val) {
                apiWidget[i]["value"] = val;
              },
              value: apiWidget[i]["value"],
              onChanged: (data) {},
              items: apiWidget[i]["select_values"]
                  .map<DropdownMenuItem<dynamic>>((value) {
                return DropdownMenuItem<dynamic>(
                  value: value["value"],
                  child: Text(value["key"]),
                );
              }).toList(),
            ),
          );
          break;

        case "multiselect":
          formWidgets.add(
            ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: apiWidget[i]["select_values"].length,
                itemBuilder: (BuildContext context, int index) {
                  return CheckboxListTile(
                    value: apiWidget[i]["value"].contains(
                        apiWidget[i]["select_values"][index]["value"]),
                    onChanged: (selected) {
                      if (selected == true) {
                        setState(() {
                          apiWidget[i]["value"].add(
                              apiWidget[i]["select_values"][index]["value"]);
                        });
                      } else {
                        setState(() {
                          apiWidget[i]["value"].remove(
                              apiWidget[i]["select_values"][index]["value"]);
                        });
                      }
                    },
                    title: Text(apiWidget[i]["select_values"][index]["title"]),
                  );
                }),
          );
          break;

        case "radio":
          formWidgets.add(Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (var j = 0; j < apiWidget[i]["radio_values"].length; j++)
                ListTile(
                  title: Text(apiWidget[i]["radio_values"][j]["title"]),
                  leading: Radio<int>(
                    value: apiWidget[i]["radio_values"][j]["value"],
                    groupValue: apiWidget[i]["value"],
                    onChanged: (value) {
                      setState(() {
                        apiWidget[i]["value"] = value;
                      });
                    },
                    activeColor: Colors.green,
                  ),
                  onTap: () {
                    setState(() {
                      apiWidget[i]["value"] =
                          apiWidget[i]["radio_values"][j]["value"];
                    });
                  },
                ),
            ],
          ));
          break;

        case "switch":
          formWidgets.add(ListTile(
            title: Text(apiWidget[i]["title"]),
            trailing: Switch(
              onChanged: (value) {
                setState(() {
                  apiWidget[i]["value"] = value;
                });
              },
              value: apiWidget[i]["value"],
              activeColor: Colors.blue,
              activeTrackColor: Colors.yellow,
              inactiveThumbColor: Colors.redAccent,
              inactiveTrackColor: Colors.orange,
            ),
          ));

          break;

        case "htmleditor":
          formWidgets.add(FlutterSummernote(
              value: apiWidget[i]["value"],
              height: 200,
              key: htmlKeys[i],
              hasAttachment: false,
              returnContent: (val) {
                apiWidget[i]["value"] = val;
              },
              showBottomToolbar: false,
              customToolbar: """[
                ['style', ['bold', 'italic', 'underline', 'clear']],
                ['font', ['strikethrough', 'superscript', 'subscript']]
                ['fontsize', ['fontsize']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']]
                ]"""));
          break;

        case "datepicker":
          formWidgets.add(Container(
              padding: const EdgeInsets.all(5),
              child: Center(
                  child: TextFormField(
                controller: dateController[i],
                validator: (value) {
                  if (value!.isEmpty ||
                      !(apiWidget[i]["validate"]["required"])) {
                    return apiWidget[i]["title"].toString().toUpperCase() +
                        " is Required";
                  }

                  return null;
                },
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.calendar_today),
                    hintText: apiWidget[i]["hint"]),
                readOnly: true,
                onSaved: (val) {
                  apiWidget[i]["value"] = val;
                },
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: apiWidget[i]["value"] == ""
                        ? DateTime.now()
                        : DateFormat(apiWidget[i]["date_format"])
                            .parse(apiWidget[i]["value"]),
                    firstDate: DateFormat(apiWidget[i]["date_format"])
                        .parse(apiWidget[i]["fromDate"]),
                    lastDate: DateFormat(apiWidget[i]["date_format"])
                        .parse(apiWidget[i]["toDate"]),
                  );

                  if (pickedDate != null) {
                    String? formattedDate =
                        DateFormat(apiWidget[i]["date_format"])
                            .format(pickedDate);
                    setState(() {
                      dateController[i].text = formattedDate;
                      apiWidget[i]["value"] = formattedDate;
                    });
                  } else {}
                },
              ))));
          break;
      }
    }
    return formWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Form Validation'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(15.0),
            child: Form(
              key: _key,
              autovalidate: _validate,
              child: formUI(),
            ),
          ),
        ),
      ),
    );
  }

  Widget formUI() {
    return Column(
      children: <Widget>[
        ...buildWidget(),
        const SizedBox(height: 15.0),
        ElevatedButton(
          onPressed: _validation,
          child: const Text('Send'),
        )
      ],
    );
  }

  Future _pickImage(int index, {@required bool? fromCamera}) async {
    XFile? image = await ImagePicker().pickImage(
        source: fromCamera! ? ImageSource.camera : ImageSource.gallery);
    if (image != null) {
      _cropImage(image.path, index);
    }
  }

  Future _cropImage(path, int index) async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: path,
        compressFormat: apiWidget[index]["format"] == "png"
            ? ImageCompressFormat.png
            : ImageCompressFormat.jpg,
        aspectRatio: apiWidget[index]["any_size"]
            ? null
            : CropAspectRatio(
                ratioX: apiWidget[index]["ratio_x"],
                ratioY: apiWidget[index]["ratio_y"]));
    if (croppedFile != null) {
      setState(() {
        selectedfile[index] = croppedFile;
        imageUndo[index] = apiWidget[index]["value"] == ""
            ? imageUndo[index]
            : apiWidget[index]["value"];
        apiWidget[index]["value"] = "";
      });
    }
  }

  _validation() async {
    for (var i = 0; i < apiWidget.length; i++) {
      if (htmlKeys[i].currentWidget != null) {
        htmlKeys[i].currentState!.getText();
      }
    }
    Future.delayed(const Duration(milliseconds: 50), () {
      if (_key.currentState!.validate()) {
        _key.currentState!.save();
        Map temp = {};
        for (var i = 0; i < apiWidget.length; i++) {
          if ((apiWidget[i]["validate"]["required"] &&
              apiWidget[i]["value"] == "" &&
              selectedfile[i] == null)) {
            print(apiWidget[i]["title"]);
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("${apiWidget[i]['title']} is required"),
                    actions: [
                      TextButton(
                        child: const Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
            break;
          } else {
            temp[apiWidget[i]["title"]] =
                selectedfile[i]?.path ?? apiWidget[i]["value"];
            print(i);
          }

          if (i == apiWidget.length - 1) {
            print(temp);
          }
        }
      } else {
        setState(() {
          _validate = true;
        });
      }
    });
  }
}
