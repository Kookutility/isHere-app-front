import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petdemo/API/model/latest_post_model.dart';
import 'package:petdemo/API/service/rest_api.dart';
import 'package:petdemo/main_screens/post/component/post_detail_model.dart';
import 'package:petdemo/main_screens/post/component/write_screen_model.dart';

export 'component/write_screen_model.dart';

class WriteScreen extends StatefulWidget {
  final bool categoryTypeIsFind;
  const WriteScreen({
    super.key,
    required this.categoryTypeIsFind,
  });

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  late WriteScreenModel _model;

  final picker = ImagePicker();
  XFile? image; // 카메라로 촬영한 이미지를 저장할 변수
  List<XFile?> multiImage = []; // 갤러리에서 여러 장의 사진을 선택해서 저장할 변수
  List<XFile?> images = []; // 가져온 사진들을 보여주기 위한 변수
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isInstantPayButtonOn = false;
  bool isConfirm = false;
  double? xLoc, yLoc;
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WriteScreenModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController3 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();

    _model.textController4 ??= TextEditingController();
    _model.textFieldFocusNode4 ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<void> uploadFile() async {
    if (multiImage.isNotEmpty) {
      for (var image in multiImage) {
        print(image!.name);
      }
      final writePost = ApiService(context: context);

      List<MultipartFile> files = [];

      // 이미지 파일 추가
      for (XFile? image in multiImage) {
        if (image != null) {
          files.add(
            await MultipartFile.fromFile(
              image.path,
              filename: image.name,
            ),
          );
        }
      }
      FormData formData = FormData.fromMap(
        {
          'files': files,
          'postDTO': MultipartFile.fromString(
            jsonEncode({
              "postTitle": _model.textController1.text,
              "description": _model.textController3.text,
              "categoryType": widget.categoryTypeIsFind ? "찾고 있어요" : "찾았어요",
              "immediateCase": isInstantPayButtonOn ? 1 : 0,
              "reward": int.parse(
                _model.textController2.text,
              ),
              "xLoc": xLoc ?? 0,
              "yLoc": yLoc ?? 0,
            }),
            contentType: MediaType.parse('application/json'),
          )
        },
      );

      // 업로드 요청
      final response = await writePost.postRequestWithToken(
        toUrl: '/board/upload',
        data: formData,
        contentType: 'multipart/form-data',
      );
      var result = await writePost.reponseMessageCheck(response);
      print(result);
      print(result!['imageUrls']);
      print(result['imageUrls'].runtimeType);
      // print(jsonDecode(result['imageUrls']));
      sendToDetail(result);
    } else {
      // 아무런 파일도 선택되지 않음.
    }
  }

  sendToDetail(Map<String, dynamic> result) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return PostDetailModel();
        },
        settings: RouteSettings(arguments: Post.fromJson(result)),
      ),
    );
  }

  instantPayTap() {
    setState(() {
      isInstantPayButtonOn = !isInstantPayButtonOn;
    });
  }

  selectPhoto() async {
    multiImage = await picker.pickMultiImage();
    setState(() {
      images.addAll(multiImage);
    });

    onValidCheck();
  }

  onValidCheck() {
    print("checking");
    xLoc = 0;
    yLoc = 0;
    if (multiImage.isEmpty) return;
    if (xLoc == null && yLoc == null) return;
    if (_model.textController1.text.isEmpty) return;
    if (_model.textController2.text.isEmpty) return;
    if (_model.textController3.text.isEmpty) return;

    setState(() {
      isConfirm = true;
    });

    uploadFile();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }
    final borderStyle = OutlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.none,
      ),
    );
    bool iskeyBoardOn = MediaQuery.of(context).viewInsets.bottom != 0;
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '게시물 등록',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 15,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FlexibleSpace(iskeyBoardOn: iskeyBoardOn),
                  multiImage.isNotEmpty
                      ? GestureDetector(
                          onTap: selectPhoto,
                          child: ImageSlider(
                            imageXFileList: multiImage,
                          ),
                        )
                      : PhotoSelection(
                          onPhotoSelectPressed: selectPhoto,
                        ),
                  FlexibleSpace(iskeyBoardOn: iskeyBoardOn),
                  FormField(
                    textControllerValidator: _model.textController1Validator,
                    borderStyle: borderStyle,
                    focusNode: _model.textFieldFocusNode1,
                    textEditingController: _model.textController1,
                    canExpaned: false,
                    title: '제목(분실물 습득)',
                    hintText: '제목',
                  ),
                  FlexibleSpace(iskeyBoardOn: iskeyBoardOn),
                  Label(title: '즉시 사례 하기'),
                  FlexibleSpace(iskeyBoardOn: iskeyBoardOn),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: instantPayTap,
                          child: WantButton(
                              isInstantPayButtonOn: isInstantPayButtonOn),
                        ),
                        GestureDetector(
                          onTap: instantPayTap,
                          child: NotWantButton(
                              isInstantPayButtonOn: isInstantPayButtonOn),
                        ),
                      ],
                    ),
                  ),
                  FlexibleSpace(iskeyBoardOn: iskeyBoardOn),
                  WarningText(text: '즉시 사례를 등록하면 게시물이 상위 노출되어 습득 확률이 증가해요!'),
                  FlexibleSpace(iskeyBoardOn: iskeyBoardOn),
                  FormField(
                    textControllerValidator: _model.textController2Validator,
                    borderStyle: borderStyle,
                    focusNode: _model.textFieldFocusNode2,
                    textEditingController: _model.textController2,
                    canExpaned: false,
                    title: '사례금 등록',
                    hintText: '￦ 가격을 입력해주세요.',
                  ),
                  FlexibleSpace(iskeyBoardOn: iskeyBoardOn),
                  FormField(
                    textControllerValidator: _model.textController3Validator,
                    borderStyle: borderStyle,
                    textEditingController: _model.textController3,
                    focusNode: _model.textFieldFocusNode3,
                    title: '자세한 설명',
                    canExpaned: true,
                    hintText:
                        '1.분실물 정보 요약\n잃어버린 장소를 포함한 분실물 정보 요약\n\n2.잃어버린 장소 혹은 찾은 장소\n구체적인 잃어버린 장소 혹은 찾은 장소 기재\n\n3.분실물 정보\n물건의 종류와 특징적인 특징 작성\n\n4.연락처\n연락 가능한 방법(전화번호 등) 작성\n\n5.추가 정보\n분실 시간, 분실 경위 등 추가 정보 작성',
                  ),
                  FlexibleSpace(iskeyBoardOn: iskeyBoardOn),
                  Label(
                    title: '분실 전, 마지막으로 확인한 위치',
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2,
                          spreadRadius: 0,
                          blurStyle: BlurStyle.normal,
                          offset: Offset(
                            0,
                            3,
                          ),
                        )
                      ],
                      border: Border.all(
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "장소 선택",
                            style: TextStyle(
                              color: Color(0xff606060),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Color(0xff606060),
                          )
                        ],
                      ),
                    ),
                  ),
                  FlexibleSpace(iskeyBoardOn: iskeyBoardOn),
                  WarningText(text: '마지막으로 확인한 분실물의 정보가 지도상에 등록돼요!'),
                  FlexibleSpace(iskeyBoardOn: iskeyBoardOn),
                  GestureDetector(
                    onTap: onValidCheck,
                    child: BlueButton(isConfirm: isConfirm),
                  ),
                  FlexibleSpace(iskeyBoardOn: iskeyBoardOn),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NotWantButton extends StatelessWidget {
  const NotWantButton({
    super.key,
    required this.isInstantPayButtonOn,
  });

  final bool isInstantPayButtonOn;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        color: Color(0xff969BA4),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isInstantPayButtonOn)
            Icon(
              Icons.check_rounded,
              color: Colors.white,
            ),
          Text(
            "괜찮아요",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class WantButton extends StatelessWidget {
  const WantButton({
    super.key,
    required this.isInstantPayButtonOn,
  });

  final bool isInstantPayButtonOn;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        color: Color(0xff4E40EA),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isInstantPayButtonOn)
            Icon(
              Icons.check_rounded,
              color: Colors.white,
            ),
          Text(
            "원해요",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class WarningText extends StatelessWidget {
  final String text;
  const WarningText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
      child: Text(
        '※ $text',
        textAlign: TextAlign.start,
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 40,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFF5C5C)),
      ),
    );
  }
}

class BlueButton extends StatelessWidget {
  const BlueButton({
    super.key,
    required this.isConfirm,
  });

  final bool isConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 15,
      decoration: BoxDecoration(
        boxShadow: isConfirm
            ? null
            : [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 3),
                  blurRadius: 3,
                )
              ],
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: isConfirm
              ? [
                  Color.fromRGBO(78, 64, 234, 1),
                  Color.fromRGBO(107, 224, 210, 1),
                ]
              : [
                  Colors.white,
                  Colors.white,
                ],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 20,
              ),
              child: Text(
                isConfirm ? "작성완료" : "작성을 완료해주세요",
                style: TextStyle(
                  color: isConfirm ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            isConfirm
                ? Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: CupertinoActivityIndicator(
                      color: Colors.black,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class FormField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final String? Function(BuildContext, String?)? textControllerValidator;
  final bool canExpaned;
  const FormField({
    super.key,
    required this.borderStyle,
    required this.title,
    required this.hintText,
    required this.textEditingController,
    required this.focusNode,
    required this.textControllerValidator,
    required this.canExpaned,
  });

  final OutlineInputBorder borderStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Label(title: title),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2,
                spreadRadius: 0,
                blurStyle: BlurStyle.normal,
                offset: Offset(
                  0,
                  3,
                ),
              )
            ],
            border: Border.all(
              style: BorderStyle.none,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
            autofocus: true,
            obscureText: false,
            maxLines: canExpaned ? null : 1,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: hintText,
              hintStyle: FlutterFlowTheme.of(context).labelMedium,
              enabledBorder: borderStyle,
              focusedBorder: borderStyle,
              errorBorder: borderStyle,
              focusedErrorBorder: borderStyle,
            ),
            style: FlutterFlowTheme.of(context).bodyMedium,
            validator: textControllerValidator.asValidator(context),
          ),
        ),
      ],
    );
  }
}

class Label extends StatelessWidget {
  const Label({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.start,
      style: TextStyle(
          fontSize: MediaQuery.of(context).size.width / 25,
          fontWeight: FontWeight.bold),
    );
  }
}

class FlexibleSpace extends StatelessWidget {
  final int? more;

  const FlexibleSpace({
    super.key,
    this.more,
    required this.iskeyBoardOn,
  });

  final bool iskeyBoardOn;

  @override
  Widget build(BuildContext context) {
    final num = more ?? 1;
    final space = MediaQuery.of(context).size.height / 50 / num;
    return SizedBox(
      height: iskeyBoardOn ? space / 2 : space,
    );
  }
}

class PhotoSelection extends StatelessWidget {
  final VoidCallback onPhotoSelectPressed;
  const PhotoSelection({
    super.key,
    required this.onPhotoSelectPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPhotoSelectPressed,
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.width / 3,
        decoration: BoxDecoration(
          color: Color(0xff696969).withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: onPhotoSelectPressed,
                icon: Icon(
                  Icons.camera_alt_rounded,
                  size: MediaQuery.of(context).size.width / 8,
                  color: Color(0xff848484),
                )),
            Text(
              "0 / 10",
              style: TextStyle(
                color: Color(0xff848484),
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width / 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
