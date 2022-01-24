import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/poem.dart';
import '../providers/poems.dart';

class NewPoemScreen extends StatefulWidget {
  static const routeName = '/new-poem';

  @override
  _NewPoemScreenState createState() => _NewPoemScreenState();
}

class _NewPoemScreenState extends State<NewPoemScreen> {
  final _titleFocusNode = FocusNode();
  final _thePoemFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedMoment = Poem(
    id: '',
    title: '',
    thePoem: '',
    index: 0,
  );
  var _initValues = {'title': '', 'thePoem': '', 'imageUrl': '', 'index': ''};
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final momentId = ModalRoute.of(context)?.settings.arguments as String;
      if (momentId != null) {
        _editedMoment =
            Provider.of<Poems>(context, listen: false).findById(momentId);
        _initValues = {
          'title': _editedMoment.title!,
          'date': _editedMoment.thePoem.toString(),
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();
    _thePoemFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState?.save();
    if (_editedMoment.id != null) {
      Provider.of<Poems>(context, listen: false)
          .updatePoem(_editedMoment.id, _editedMoment);
    } else {
      Provider.of<Poems>(context, listen: false).addPoem(_editedMoment);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Poem'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues['title'],
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_titleFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedMoment = Poem(
                    index: _editedMoment.index,
                    title: value,
                    thePoem: _editedMoment.thePoem,
                    id: _editedMoment.id,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['thePoem'],
                decoration: InputDecoration(
                  labelText: 'BOKA!',
                  // labelStyle: TextStyle(
                  //   height: MediaQuery.of(context).size.height,
                  // )
                ),
                maxLines: 28,
                keyboardType: TextInputType.multiline,
                focusNode: _thePoemFocusNode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedMoment = Poem(
                      index: _editedMoment.index,
                      title: _editedMoment.title,
                      id: _editedMoment.id,
                      thePoem: value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
