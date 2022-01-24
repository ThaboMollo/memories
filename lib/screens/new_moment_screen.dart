import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/moment.dart';
import '../providers/moments.dart';

class NewMomentScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _NewMomentScreenState createState() => _NewMomentScreenState();
}

class _NewMomentScreenState extends State<NewMomentScreen> {
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedMoment = Moment(
    id: '',
    title: '',
    imageUrl: '',
    date: '',
    index: 0,
  );
  var _initValues = {'title': '', 'date': '', 'imageUrl': '', 'index': ''};
  var _isInit = true;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final momentId = ModalRoute.of(context)?.settings.arguments as String;
      if (momentId != null) {
        _editedMoment =
            Provider.of<Moments>(context, listen: false).findById(momentId);
        _initValues = {
          'title': _editedMoment.title!,
          'date': _editedMoment.date.toString(),
          'imageUrl': _editedMoment.imageUrl!,
          'imageUrl': _editedMoment.index.toString(),
        };
        _imageUrlController.text = _editedMoment.imageUrl!;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _titleFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState?.save();
    if (_editedMoment.id != null) {
      Provider.of<Moments>(context, listen: false)
          .updateMoment(_editedMoment.id, _editedMoment);
    } else {
      Provider.of<Moments>(context, listen: false).addMoment(_editedMoment);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
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
                  _editedMoment = Moment(
                      index: _editedMoment.index,
                      title: value,
                      imageUrl: _editedMoment.imageUrl,
                      id: _editedMoment.id,
                      date: _editedMoment.date);
                },
              ),
              TextFormField(
                initialValue: _initValues['date'],
                decoration: InputDecoration(labelText: 'Date'),
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
                  _editedMoment = Moment(
                      index: _editedMoment.index,
                      title: _editedMoment.title,
                      imageUrl: _editedMoment.imageUrl,
                      id: _editedMoment.id,
                      date: value);
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an image URL.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedMoment = Moment(
                          index: _editedMoment.index,
                          title: _editedMoment.title,
                          imageUrl: value,
                          id: _editedMoment.id,
                          date: _editedMoment.date,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
