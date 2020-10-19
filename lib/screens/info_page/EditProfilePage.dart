import 'package:flutter/material.dart';
import 'package:shop_app/utils/CustomTextStyle.dart';


class EditProfilePage extends StatefulWidget {
  static String routeName = "/edit_profile";
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Edit Profile",
          style: CustomTextStyle.textFormFieldBlack.copyWith(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 24,
            ),
            Container(
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  border: border,
                  hintText: "Name",
                  focusedBorder: border.copyWith(
                      borderSide: BorderSide(color: Color(0xFF1B5E20))),
                ),
              ),
              margin: EdgeInsets.only(left: 12, right: 12, top: 24),
            ),
            Container(
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    border: border,
                    hintText: "Email",
                    focusedBorder: border.copyWith(
                        borderSide: BorderSide(color: Color(0xFF1B5E20)))),
              ),
              margin: EdgeInsets.only(left: 12, right: 12, top: 12),
            ),
            Container(
              child: TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    border: border,
                    hintText: "Mobile Number",
                    focusedBorder: border.copyWith(
                        borderSide: BorderSide(color: Color(0xFF1B5E20)))),
              ),
              margin: EdgeInsets.only(left: 12, right: 12, top: 12),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 48, right: 48),
              child: ButtonTheme(
                minWidth: 200.0,
                height: 60.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                child: RaisedButton(
                  color: Color(0xFF1B5E20),
                  textColor: Colors.white,
                  onPressed: () {},
                  child: Text(
                    "Save",
                    style: CustomTextStyle.textFormFieldBlack
                        .copyWith(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  var border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: Colors.grey));
}