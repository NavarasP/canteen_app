// widgets/signup_form.dart

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SignupForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          FormBuilderTextField(
            name: 'email',
            decoration: InputDecoration(labelText: 'Email'),
        //     validator: FormBuilderValidators.compose([
        //   FormBuilderValidators.required(),
        //   FormBuilderValidators.email(),
        // ]),
          ),
          FormBuilderTextField(
            name: 'password',
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            // validator: FormBuilderValidators.compose([
            //   FormBuilderValidators.required(context),
            //   FormBuilderValidators.minLength(context, 6),
            // ]),
          ),
          FormBuilderDropdown(
            name: 'department',
            decoration: InputDecoration(labelText: 'Department'),
            // hint: Text('Select Department'),
            items: ['Department A', 'Department B', 'Department C']
                .map((department) => DropdownMenuItem(
                      value: department,
                      child: Text(department),
                    ))
                .toList(),
            // validator: FormBuilderValidators.compose([
            //   FormBuilderValidators.required(context),
            // ]),
          ),
          FormBuilderTextField(
            name: 'admissionNumber',
            decoration: InputDecoration(labelText: 'Admission Number'),
            // validator: FormBuilderValidators.compose([
            //   FormBuilderValidators.required(context),
            // ]),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.saveAndValidate() ?? false) {
                // Process the form data
                var formData = _formKey.currentState?.value;
                print(formData);
                // Call your authentication service or handle signup logic here
              }
            },
            child: Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
