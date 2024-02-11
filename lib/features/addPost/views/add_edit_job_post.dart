// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_placement/common/utils/utils.dart';
import 'package:job_placement/features/addPost/cubit/cubit/add_edit_job_post_cubit.dart';
import 'package:job_placement/features/home/cubit/home_cubit.dart';
import 'package:job_placement/features/home/models/post.dart';

class AddEditJobPost extends StatefulWidget {
  const AddEditJobPost({super.key, this.post});

  final Post? post;

  @override
  State<AddEditJobPost> createState() => _AddEditJobPostState();
}

class _AddEditJobPostState extends State<AddEditJobPost> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _placeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _jobTypeController = TextEditingController();
  final _urlController = TextEditingController();
  XFile? _selectedImage;

  void _pickImage() async {
    try {
      final imagePicker = ImagePicker();
      final pickedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _selectedImage = pickedImage;
        });
      }
    } catch (e) {
      log("Crash Error: $e");
    }
  }

  @override
  void initState() {
    if (widget.post != null) {
      _titleController.text = widget.post!.title;
      _companyNameController.text = widget.post!.companyName;
      _placeController.text = widget.post!.place;
      _descriptionController.text = widget.post!.description;
      _jobTypeController.text = widget.post!.jobType;
      _urlController.text = widget.post!.url;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post != null ? "Edit Job " : " Add Job "),
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _pickImage();
                  },
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: _selectedImage != null
                        ? FileImage(File(_selectedImage!.path))
                        : widget.post?.image != null
                            ? NetworkImage(widget.post!.image) as ImageProvider
                            : null,
                  ),
                ),
                TextButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.image),
                    label: Text("Pick Image")),
                const SizedBox(height: 20),
                TextFormField(
                    maxLength: 50,
                    controller: _titleController,
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'job title',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    }),
                const SizedBox(height: 10),
                TextFormField(
                    maxLength: 50,
                    controller: _companyNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "company name",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    }),
                const SizedBox(height: 10),
                TextFormField(
                    maxLength: 50,
                    controller: _placeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'place',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    }),
                const SizedBox(height: 10),
                // DescriptionSheetField(
                //     onSaved: (String? value) {
                //       setState(() {
                //         _descriptionController.text = value ?? "";
                //       });
                //     },
                //     descriptionController: _descriptionController),
                TextFormField(
                    maxLength: 5000,
                    maxLines: 7,
                    onTap: () {},
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'description',
                      alignLabelWithHint: true,
                      hintText: "description",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    }),
                const SizedBox(height: 10),
                TextFormField(
                    maxLength: 50,
                    onTap: () {},
                    controller: _jobTypeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'jobType',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    }),
                const SizedBox(height: 10),
                TextFormField(
                    maxLength: 50,
                    onTap: () {},
                    controller: _urlController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'url',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please paste your some url';
                      }
                      return null;
                    }),
                const SizedBox(height: 30),
                BlocConsumer<AddEditJobPostCubit, AddJobPostState>(
                  listener: (context, state) {
                    if (state is AddEditJobPostSuccess) {
                      context.read<HomeCubit>().getHomeData();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: widget.post != null
                            ? const Text("Post Edited Successfully")
                            : const Text("Post Added Successfully"),
                      ));

                      context.read<HomeCubit>().getHomeData();

                      Navigator.pop(context);
                    }
                    if (state is AddEditJobPostError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.error),
                      ));
                    }
                  },
                  builder: (context, state) {
                    if (state is AddEditJobPostLoading) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.post == null
                              ? context.read<AddEditJobPostCubit>().addJobPost(
                                    title: _titleController.text,
                                    description: _descriptionController.text,
                                    place: _placeController.text,
                                    companyName: _companyNameController.text,
                                    jobType: _jobTypeController.text,
                                    url: _urlController.text,
                                    image: _selectedImage,
                                  )
                              : context.read<AddEditJobPostCubit>().editJobPost(
                                    post: widget.post!,
                                    title: _titleController.text,
                                    description: _descriptionController.text,
                                    place: _placeController.text,
                                    companyName: _companyNameController.text,
                                    jobType: _jobTypeController.text,
                                    url: _urlController.text,
                                    image: _selectedImage,
                                  );
                        }
                      },
                      child: Text(
                        widget.post != null ? "Edit Post" : "Post Job",
                        style: applyTextStyle(16, FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(150, 50),
                        backgroundColor: Color.fromARGB(255, 1, 27, 72),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
