import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/contants/constants.dart';
import 'package:weight_app/modals/weight.dart';
import 'package:weight_app/providers/data_provider.dart';
import 'package:weight_app/resources/firebase_methods.dart';
import 'package:weight_app/utils/services.dart';
import 'package:weight_app/widgets/main_button.dart';
import 'package:weight_app/widgets/text_field_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weight Tracker"),
        actions: [
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kSecondaryColor,
        child: Icon(Icons.add),
        onPressed: () => showCustomDialog('Add'),
      ),
      body: Container(
        child: Consumer<DataProvider>(
          builder: (context, provider, ch) {
            if (provider.list.isEmpty) {
              return Center(
                child: Text("No previous history"),
              );
            } else {
              return ListView.builder(
                  itemCount: provider.list.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          showBottomSheetFunction(provider.list[index].id,
                              provider.list[index].weightInKg.toString());
                        },
                        trailing: Text(
                            provider.list[index].weightInKg.toString() + 'Kg'),
                        title: Text(DateFormat.yMMMMEEEEd()
                            .format(provider.list[index].date)
                            .toString()),
                      ),
                    );
                  });
            }
          },
          child: Center(
            child: Text("No previous history"),
          ),
        ),
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        FirebaseMethods.signOut(context);
        break;
    }
  }

  showCustomDialog(String type, {String? id}) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              height: 250,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    type == 'Edit' ? 'Edit Entry' : "Add Entry",
                    textAlign: TextAlign.center,
                    style: kHeadingStyle,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(weightController),
                  SizedBox(
                    height: 20,
                  ),
                  MainElevatedButton(
                      text: type == 'Edit' ? 'Edit' : 'Add',
                      onPressed: () async {
                        if (weightController.text.isEmpty) {
                          return CustomServices.showSnackBar(
                              context, "Weight shouldn't be empty");
                        }
                        if (type == 'Add') {
                          await Provider.of<DataProvider>(context,
                                  listen: false)
                              .addItemToList(
                                  WeightModal(weightController.text));
                          weightController.text = '';
                          CustomServices.showSnackBar(context, 'Item added');
                        } else {
                          await Provider.of<DataProvider>(context,
                                  listen: false)
                              .upDateAnItem(id, weightController.text);
                          weightController.text = '';
                          CustomServices.showSnackBar(context, 'Item updated');
                          Navigator.of(context).pop();
                        }

                        Navigator.of(context).pop();
                      })
                ],
              ),
            ),
          );
        });
  }

  showBottomSheetFunction(String id, String weight) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                  leading: Icon(Icons.edit),
                  title: Text("Edit"),
                  onTap: () async {
                    weightController.text = weight;
                    showCustomDialog('Edit', id: id);
                  }),
              ListTile(
                  leading: Icon(Icons.delete),
                  title: Text("Delete"),
                  onTap: () async {
                    await Provider.of<DataProvider>(context, listen: false)
                        .deleteAnItem(id, context);
                  }),
            ],
          );
        });
  }
}
