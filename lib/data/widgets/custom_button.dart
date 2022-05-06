// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:news_app/util/color_resources.dart';
// import 'package:news_app/util/dimensions.dart';

// class CustomButton extends StatefulWidget {

//   CustomButton(
//       );

//   @override
//   _CustomButtonState createState() => _CustomButtonState();
// }

// class _CustomButtonState extends State<CustomButton> {
//   bool _obscureText = true;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 44.0,
//       decoration: BoxDecoration(
//         color: widget.fillColor,
//         borderRadius: BorderRadius.circular(widget.radius),
//       ),
//       child: TextField(
//         maxLines: widget.maxLines,
//         controller: widget.controller,
//         focusNode: widget.focusNode,
//         style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.black, fontSize: Dimensions.FONT_SIZE_DEFAULT, height: 1.7),
//         textInputAction: widget.inputAction,
//         keyboardType: widget.inputType,
//         cursorColor: Theme.of(context).primaryColor,
//         textCapitalization: widget.capitalization,
//         enabled: widget.isEnabled,
//         autofocus: false,
//         //onChanged: widget.isSearch ? widget.languageProvider.searchLanguage : null,
//         obscureText: widget.isPassword ? _obscureText : false,
//         inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9+]'))] : null,
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: widget.isPadding ? 22 : 0),
//           border: widget.isShowBorder
//               ? OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(widget.radius),
//                   borderSide: const BorderSide(color: ColorResources.border_blue, width: 0),
//                 )
//               : InputBorder.none,
//           focusedBorder: widget.isShowBorder
//               ? OutlineInputBorder(
//                   borderSide: const BorderSide(color: ColorResources.border_blue, width: 1),
//                   borderRadius: BorderRadius.circular(widget.radius),
//                 )
//               : InputBorder.none,
//           enabledBorder: widget.isShowBorder
//               ? OutlineInputBorder(
//                   borderSide: const BorderSide(color: ColorResources.border_blue, width: 0.2),
//                   borderRadius: BorderRadius.circular(widget.radius),
//                 )
//               : InputBorder.none,
//           isDense: true,
//           hintText: widget.hintText,
//           hintStyle: const TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
//           prefixIcon: widget.isShowPrefixIcon ? widget.prefixIconUrl : null,
//           suffixIcon: widget.isShowSuffixIcon
//               ? widget.isPassword
//                   ? IconButton(icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Theme.of(context).hintColor), onPressed: _toggle)
//                   : widget.isIcon
//                       ? Icon(widget.suffixIconUrl, color: Colors.black45)
//                       : null
//               : null,
//         ),
//       ),
//     );
//   }

// }
