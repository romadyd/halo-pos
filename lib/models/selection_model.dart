/*
  Created By : Yudi Dwi Romadhoni
  E-mail : yudi2610@gmail.com
 */


/* Model */
class SelectionModel {
  final String value;
  final String text;

  SelectionModel ({ this.value, this.text });

  @override
  String toString() {
    return 'ResponseModel{value: $value, text: $text}';
  }
}