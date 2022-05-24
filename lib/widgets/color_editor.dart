import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorEditor extends StatefulWidget {
  String title;
  Color colorToChange;
  ColorEditor(this.title, this.colorToChange);
  Color? get getColor => this.colorToChange;

  @override
  State<ColorEditor> createState() => _ColorEditorState();
}

class _ColorEditorState extends State<ColorEditor> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Pick color"),
                    scrollable: true,
                    backgroundColor: widget.colorToChange,
                    content: ColorPicker(
                      portraitOnly: false,
                      pickerColor: widget.colorToChange,
                      onColorChanged: (Color color) {
                        setState(() {
                          widget.colorToChange = color;
                        });
                      },
                    ),
                  ));
        },
        child: Container(
          height: MediaQuery.of(context).size.height * .1,
          width: double.infinity,
          alignment: Alignment.center,
          child: Text(
            widget.title,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: widget.colorToChange == null
                ? Theme.of(context).appBarTheme.backgroundColor
                : widget.colorToChange,
          ),
        ),
      ),
    );
  }
}
