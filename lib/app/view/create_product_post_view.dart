import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicleservicingapp/app/data/model/accessory_post.dart';

import 'package:vehicleservicingapp/app/data/repository/accessory_repository.dart';

class CreateAccessoryPostView extends StatelessWidget {
  final TextEditingController _productNameController = TextEditingController(),
      _priceController = TextEditingController(),
      _brandController = TextEditingController(),
      _descriptionController = TextEditingController(),
      _tagsController = TextEditingController();

  CreateAccessoryPostView({Key key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _productNameController,
                  decoration: InputDecoration(labelText: "Name"),
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: "Price"),
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _brandController,
                  decoration: InputDecoration(labelText: "Brand"),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: _descriptionController,
                        maxLines: 4,
                        decoration: InputDecoration(labelText: "Description"),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    IconButton(icon: Icon(Icons.add_a_photo), onPressed: () {})
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _tagsController,
                  maxLines: 4,
                  decoration: InputDecoration(
                      labelText: "Tags", hintText: "i.e #Radiator #Fan"),
                ),
                SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: Get.width,
                  height: 55,
                  child: ElevatedButton(
                      onPressed: () {
                        AccessoryRepository productRepository =
                            new AccessoryRepository();

                        AccessoryPost post = new AccessoryPost(
                            productName: _productNameController.text,
                            price: double.parse(_productNameController.text),
                            brand: _brandController.text,
                            productDescription: _descriptionController.text,
                            tags: _tagsController.text.split("#"));

                        productRepository.add(post);
                      },
                      child: Text("Create Post")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
