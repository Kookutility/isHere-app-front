import 'package:flutterflow_ui/flutterflow_ui.dart';

import '../write_screen.dart' show WriteScreen;
import 'package:flutter/material.dart';

// 첫 번째 패키지에서 FlutterFlowTheme 및 FormFieldController를 가져옵니다.
// 플러터 플로우 패키지가 기존에 있기 때문에 이 경로를 설정하였음.
import 'package:flutterflow_ui/src/flutter_flow/form_field_controller.dart';
import 'package:flutterflow_ui/src/flutter_flow/flutter_flow_model.dart';

class WriteScreenModel extends FlutterFlowModel<WriteScreen> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for ChoiceChips widget.
  String? choiceChipsValue;
  FormFieldController<List<String>>? choiceChipsValueController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode4;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();

    textFieldFocusNode4?.dispose();
    textController4?.dispose();
  }

/// Action blocks are added here.

/// Additional helper methods are added here.
}