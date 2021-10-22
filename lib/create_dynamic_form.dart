import 'package:flutter/material.dart';
import 'package:flutter_starter/view_dynamic_form.dart';
import 'package:get/get.dart';

class CreateDynamicForm extends StatefulWidget {
  const CreateDynamicForm({Key? key}) : super(key: key);

  @override
  _CreateDynamicFormState createState() => _CreateDynamicFormState();
}

class _CreateDynamicFormState extends State<CreateDynamicForm> {
  final GlobalKey<FormState> _key = GlobalKey();
  bool _validate = false;
  bool _validationRequired = false;
  Map data = {
    "field": "input",
    "title": "",
    "value": "",
    "hint": "",
    "validate": {
      "required": false,
      "regexp": "",
      "regexp_msg": "",
      "length": 0,
      "length_msg": "",
    }
  };

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
              autovalidateMode: _validate
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              // autovalidate: _validate,
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
        TextFormField(
          decoration: const InputDecoration(hintText: 'Field Name'),
          validator: validateRequired,
          onSaved: (val) {
            data["title"] = val;
          },
        ),
        TextFormField(
            decoration: const InputDecoration(hintText: 'Initial Value'),
            // validator: validateRequired,
            onSaved: (val) {
              data["value"] = val;
            }),
        TextFormField(
            decoration: const InputDecoration(hintText: 'Hint'),
            keyboardType: TextInputType.emailAddress,
            validator: validateRequired,
            onSaved: (val) {
              data["hint"] = val;
            }),
        const SizedBox(height: 15.0),
        ListTile(
          title: const Text("Validation"),
          trailing: Switch(
            onChanged: (value) {
              setState(() {
                _validationRequired = value;
                data["validate"]["required"] = value;
              });
            },
            value: _validationRequired,
            activeColor: Colors.blue,
          ),
        ),
        _validationRequired
            ? Column(
                children: [
                  TextFormField(
                      decoration: const InputDecoration(hintText: 'Min Length'),
                      keyboardType: TextInputType.number,
                      validator: validateNumber,
                      onSaved: (val) {
                        data["validate"]["length"] = int.parse(val!) ;
                      }),
                  TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Length error Message'),
                      validator: validateRequired,
                      onSaved: (val) {
                        data["validate"]["length_msg"] = val;
                      }),
                  TextFormField(
                      decoration: const InputDecoration(hintText: 'Regex'),
                      // validator: validateRequired,
                      onSaved: (val) {
                        data["validate"]["regexp"] = val! ;
                      }),
                  TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Regex error Message'),
                      // validator: validateRequired,
                      onSaved: (val) {
                        data["validate"]["regexp_msg"] = val;
                      }),
                ],
              )
            : const SizedBox(),
        RaisedButton(
          onPressed: _validation,
          child: const Text('Preview'),
        )
      ],
    );
  }

  String? validateRequired(value) {
    if (value.length == 0) {
      return "Required";
    }
    return null;
  }

 
  String? validateNumber(value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value.length == 0) {
      return "Required";
    } else if (!regExp.hasMatch(value)) {
      return "This field must be digits";
    }
    return null;
  }


  _validation() {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      print(data);
      Get.to(ViewDynamicForm(apiWidget: [data]));

    } else {
      setState(() {
        _validate = true;
      });
    }
  }
}
