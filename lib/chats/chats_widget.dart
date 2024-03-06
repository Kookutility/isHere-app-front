import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petdemo/main_screens/exception/payment_done.dart';
import 'package:petdemo/sign_step/pages/payment_password.dart';
import 'package:provider/provider.dart';

import '../authentication/auth/firebase_auth/auth_util.dart';
import '../sign_step/steps.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import 'chats_model.dart';

export 'chats_model.dart';

//길어서 주요 주석 내용 여기에 놓겠습니다. ctrl+f 로 밑의 내용 검색해서 검색 가능합니다.

//UI적인 코드는 124번 줄 부터 시작

// 사진 리스트
// 해당 인덱스의 이미지 사용
// 채팅 메시지를 표시하는 부분 (채팅 박스를 감싸는 UI)
// 본인 채팅 박스
// 채팅 메시지를 표시 컨테이너
// Plus버튼 onTab UI
// 텍스트 상자
// plus 플러스 버튼 온탭 <- 예전 Plus 현재 주석
// 메세지 전송 (파이어 베이스) + // 해당 채팅방의 마지막 메시지 업데이트 (1,2 두개 있음 1은 +버튼 2는 send버튼)

// 채팅 상단바
// 하단부
// 상단바 프로필(게시글 사진 들어갈 곳)

void main() => runApp(
      MaterialApp(
        home: ChatsWidget(
          chatUser: null,
          userName: '',
          userRef: null,
          userProfile: '',
        ),
      ),
    );

class ChatsWidget extends StatefulWidget {
  const ChatsWidget({
    super.key,
    this.userName,
    this.chatUser, // 채팅방 이름
    this.userRef,
    this.userProfile,
  });

  final String? userName;
  final DocumentReference? chatUser;
  final DocumentReference? userRef;
  final String? userProfile;

  @override
  _ChatsWidgetState createState() => _ChatsWidgetState();
}

List<String> imageList = [
  // 사진 리스트
  'assets/icons/photo_purple.png',
  'assets/icons/send_money_gradation.png',
  'assets/icons/report_gradation.png',
];

class _ChatsWidgetState extends State<ChatsWidget> {
  late ChatsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatsModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    print('화면 가로 픽셀 크기: $screenWidth'); //411
    print('화면 세로 픽셀 크기: $screenHeight'); //867

    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return StreamBuilder<List<ChatsRecord>>(
      stream: queryChatsRecord(
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // 스냅샷에 데이터가 없는 경우 (로드 중인 경우)
        if (!snapshot.hasData) {
          // 로딩 중을 나타내는 Scaffold 위젯 반환
          return Scaffold(
            backgroundColor: Colors.white, // 배경색을 흰색으로 설정
            body: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * (50 / 411),
                height: MediaQuery.of(context).size.height * (50 / 867),
                child: CircularProgressIndicator(
                  // Circular 프로그레스 인디케이터를 사용하여 로딩 중임을 시각적으로 나타냄
                  valueColor: AlwaysStoppedAnimation<Color>(
                    // 인디케이터의 색상을 테마에서 정의한 주 색상으로 설정
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }

        // 채팅 목록 데이터를 가져온다.
        List<ChatsRecord> chatsChatsRecordList = snapshot.data!;
        // 아이템이 없는 경우 빈 Container를 반환한다.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        // 첫 번째 채팅 레코드를 가져온다.
        final chatsChatsRecord =
            chatsChatsRecordList.isNotEmpty ? chatsChatsRecordList.first : null;
        // 화면을 터치하면 포커스가 요청될 때만 포커스를 설정하거나 해제한다.
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    // 여기에 채팅 목록을 표시하는 위젯 또는 기능을 추가할 수 있음
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          // 상단바 프로필(게시글 사진 들어갈 곳)
                          padding: EdgeInsetsDirectional.fromSTEB(
                              MediaQuery.of(context).size.width * (4 / 411),
                              MediaQuery.of(context).size.width * (24 / 411),
                              MediaQuery.of(context).size.width * (20 / 411),
                              0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 30.0,
                                borderWidth: 1.0,
                                buttonSize: 48.0,
                                icon: Icon(
                                  Icons.more_vert_sharp,
                                  color: Color(0xFFBDBDBD),
                                  size: MediaQuery.of(context).size.width *
                                      (30 / 411),
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListTile(
                                              leading: Icon(Icons.report),
                                              title: Text('신고하기'),
                                              onTap: () {
                                                // '신고하기' 항목을 선택했을 때 수행할 동작 추가
                                                print('신고하기');
                                                Navigator.pop(
                                                    context); // 모달 바텀 시트 닫기
                                              },
                                            ),
                                            ListTile(
                                              leading: Icon(Icons.block),
                                              title: Text('차단하기'),
                                              onTap: () {
                                                // '차단하기' 항목을 선택했을 때 수행할 동작 추가
                                                print('차단하기');
                                                Navigator.pop(
                                                    context); // 모달 바텀 시트 닫기
                                              },
                                            ),
                                            ListTile(
                                              leading: Icon(Icons.exit_to_app),
                                              title: Text('대화방 나가기'),
                                              onTap: () {
                                                // '대화방 나가기' 항목을 선택했을 때 경고 다이얼로그 표시
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      contentPadding: EdgeInsets
                                                          .all(MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              (50 /
                                                                  411)), // 패딩을 조절하여 중앙 정렬
                                                      content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            '대화 내용이 모두 삭제됩니다.\n계속 하시겠습니까?',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize:
                                                                  18.0, // 텍스트 크기 조정
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            // "확인"을 선택했을 때 ChatPageWidget으로 이동하는 코드 추가
                                                            print('확인 선택');

                                                            // chatUser(채팅방 이름)에 해당하는 문서를 삭제
                                                            if (widget
                                                                    .chatUser !=
                                                                null) {
                                                              widget.chatUser!
                                                                  .delete();
                                                            }

                                                            Navigator.popUntil(
                                                                context,
                                                                (route) => route
                                                                    .isFirst); // 세 번 뒤로 가기
                                                          },
                                                          child: Text(
                                                            '확인',
                                                            style: TextStyle(
                                                              fontSize:
                                                                  18.0, // 버튼 텍스트 크기 조정
                                                            ),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            // "아니오"를 선택했을 때 수행할 동작 추가
                                                            print('취소 선택');
                                                            Navigator.pop(
                                                                context); // 경고 다이얼로그 닫기
                                                            Navigator.pop(
                                                                context); // showModalBottomSheet 닫기
                                                          },
                                                          child: Text(
                                                            '취소',
                                                            style: TextStyle(
                                                              fontSize:
                                                                  18.0, // 버튼 텍스트 크기 조정
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),

                              SizedBox(width: 5.0), // 간격 조정
                              Container(
                                width: MediaQuery.of(context).size.width *
                                    (60 / 411),
                                height: MediaQuery.of(context).size.height *
                                    (60 / 867),
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                // 게시글 사진
                                // 이미지 용량에 따라서 로드 안될때가 있는 거 같음 현재 테스트시 150kb 이하는 가능
                                child: Image.asset(
                                  'assets/images/macbook2.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 20.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '그린 플로럴',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Urbanist',
                                            color: Color(0xc9000000),
                                            fontSize: 14.0,
                                          ),
                                    ),
                                    Text(
                                      '[귀중품] 구의역쪽에서 구찌 반지갑\n분실했습니다.',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Urbanist',
                                            color: Color(0xa5000000),
                                            fontSize: 14.0,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 25.0),
                              Image.asset(
                                'assets/icons/right_gray.png',
                                color: Color(0xFFBDBDBD),
                                width: MediaQuery.of(context).size.width *
                                    (24 / 411),
                                height: MediaQuery.of(context).size.height *
                                    (24 / 867),
                              ),
                            ],
                          ),
                        ),

                        Divider(
                          //채팅 메시지 목록과 다른 UI 요소 간의 구분을 위한 수평 구분선을 생성
                          height:
                              MediaQuery.of(context).size.height * (48 / 867),
                          thickness: 1.0,
                          color: Color(0xFFE0E0E0),
                        ),

                        Expanded(
                          //채팅 메시지를 표시하는 부분을 화면 표시
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                MediaQuery.of(context).size.width * (20 / 411),
                                0.0,
                                MediaQuery.of(context).size.width * (20 / 411),
                                MediaQuery.of(context).size.width * (16 / 411)),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  StreamBuilder<List<ChatMessagesRecord>>(
                                    stream: queryChatMessagesRecord(
                                      queryBuilder: (chatMessagesRecord) =>
                                          chatMessagesRecord
                                              .where(
                                                'chat_user',
                                                isEqualTo: widget.chatUser,
                                              )
                                              .orderBy('timestamp'),
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                (50 / 411),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                (50 / 867),
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                              ),
                                            ),
                                          ),
                                        );
                                      }

                                      List<
                                              ChatMessagesRecord> // 스트림에서 비동기로 가져온 채팅 메시지 목록을 변수에 할당
                                          listViewChatMessagesRecordList =
                                          snapshot.data!;

                                      return ListView.builder(
                                        // 동적으로 아이템을 생성하여 스크롤 가능한 목록을 생성
                                        padding: EdgeInsets.zero,
                                        primary: false,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            listViewChatMessagesRecordList
                                                .length,
                                        itemBuilder: (context, listViewIndex) {
                                          final listViewChatMessagesRecord =
                                              listViewChatMessagesRecordList[
                                                  listViewIndex];
                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              //현재 사용자가 보낸 메시지가 아니면서 이미지가 있는 경우에 대한 체크

                                              //첫 번째 블록에서는 상대방이 보낸 이미지인 경우에만 사용자 프로필 이미지를 표시
                                              //이미지 메시지가 있는 경우 (타 사용자 작성)
                                              if ((listViewChatMessagesRecord
                                                          .user !=
                                                      currentUserReference) &&
                                                  (listViewChatMessagesRecord
                                                          .image !=
                                                      ''))
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0,
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              (24 / 411),
                                                          0.0,
                                                          0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // 1. 사용자 프로필 이미지
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            (36 / 411),
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            (36 / 867),
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        // 상대방 프로필 사진 (이미지를 보낼때)
                                                        child: widget.userProfile !=
                                                                    null &&
                                                                widget
                                                                    .userProfile!
                                                                    .isNotEmpty
                                                            ? Image.network(
                                                                widget
                                                                    .userProfile!,
                                                                fit: BoxFit
                                                                    .cover,
                                                              )
                                                            : Image.asset(
                                                                'assets/images/profile.png',
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                      ),

                                                      // 2. 이미지 채팅 메시지 컨테이너
                                                      Padding(
                                                        padding: EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    (16 / 411),
                                                                0.0,
                                                                0.0,
                                                                0.0),
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              (300 / 411),
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              (180 / 867),
                                                          constraints:
                                                              BoxConstraints(
                                                            maxWidth: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                (260 / 411),
                                                            maxHeight: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                (180 / 867),
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image:
                                                                  Image.network(
                                                                listViewChatMessagesRecord
                                                                    .image,
                                                              ).image,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      24.0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          24.0),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      24.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      24.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                              //채팅 메시지가 현재 사용자에 의해 작성되었고, 해당 메시지에 이미지가 첨부되어 있을 경우
                                              //이미지 메시지가 있는 경우 (타 사용자 작성)
                                              if ((listViewChatMessagesRecord
                                                          .user ==
                                                      currentUserReference) &&
                                                  (listViewChatMessagesRecord
                                                          .image !=
                                                      ''))
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0,
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              (24 / 411),
                                                          0.0,
                                                          0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // 이미지 채팅 메시지 컨테이너
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            (300 / 411),
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            (180 / 867),
                                                        constraints:
                                                            BoxConstraints(
                                                          maxWidth: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              (260 / 411),
                                                          maxHeight:
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  (180 / 867),
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image:
                                                                Image.network(
                                                              listViewChatMessagesRecord
                                                                  .image,
                                                            ).image,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    24.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    24.0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    24.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    24.0),
                                                          ),
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            // 체크 아이콘
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.90,
                                                                      0.85),
                                                              child: Icon(
                                                                FFIcons
                                                                    .kcheckAll,
                                                                color: Colors
                                                                    .white,
                                                                size: 16.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                              //두 번째 블록에서는 이미지 채팅 메시지를 보낸 사용자인 경우에만 사용자 프로필 이미지를 표시
                                              //텍스트 메시지가 있는 경우 (타 사용자 작성)
                                              if ((listViewChatMessagesRecord
                                                          .user !=
                                                      currentUserReference) &&
                                                  (listViewChatMessagesRecord
                                                          .text !=
                                                      ''))
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0,
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              (24 / 411),
                                                          0.0,
                                                          0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            (36 / 411),
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            (36 / 867),
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        // 상대방 프로필 사진 (텍스트만 보낼때)
                                                        child: widget.userProfile !=
                                                                    null &&
                                                                widget
                                                                    .userProfile!
                                                                    .isNotEmpty
                                                            ? Image.network(
                                                                widget
                                                                    .userProfile!,
                                                                fit: BoxFit
                                                                    .cover,
                                                              )
                                                            : Image.asset(
                                                                'assets/images/profile.png',
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                      ),
                                                      Padding(
                                                        //상대방 채팅 창
                                                        padding: EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    (16 / 411),
                                                                0.0,
                                                                0.0,
                                                                0.0),
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              (300 / 411),
                                                          constraints:
                                                              BoxConstraints(
                                                            maxWidth: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                (260 / 411),
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      4.0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          18.0),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      18.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      18.0),
                                                            ),
                                                            border: Border.all(
                                                              color: Color(
                                                                  0xFF828282),
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    (16 / 411),
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    (12 / 411),
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    (16 / 411),
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    (12 / 411)),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          (160 /
                                                                              411),
                                                                      constraints:
                                                                          BoxConstraints(
                                                                        maxWidth:
                                                                            MediaQuery.of(context).size.width *
                                                                                (260 / 411),
                                                                      ),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        listViewChatMessagesRecord
                                                                            .text,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Urbanist',
                                                                              color: Color(0xff000000),
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      dateTimeFormat(
                                                                          'jm',
                                                                          listViewChatMessagesRecord
                                                                              .timestamp!),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Urbanist',
                                                                            color:
                                                                                Color(0xff000000),
                                                                            fontSize:
                                                                                10.0,
                                                                          ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                              //텍스트 메시지가 있는 경우 (자신이 작성)
                                              if (listViewChatMessagesRecord
                                                      .user ==
                                                  widget.userRef)
                                                Padding(
                                                  // 본인 채팅 박스
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0,
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              (24 / 411),
                                                          0.0,
                                                          0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      if (listViewChatMessagesRecord
                                                              .text !=
                                                          '')
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              (300 / 411),
                                                          constraints:
                                                              BoxConstraints(
                                                            maxWidth: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                (260 / 411),
                                                          ),
                                                          decoration:
                                                              // 내가 보내는 채팅
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xff4d40ea),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      18.0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          4.0),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      18.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      18.0),
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    (16 / 411),
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    (12 / 411),
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    (16 / 411),
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    (12 / 411)),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      // 채팅 메시지를 표시 컨테이너
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          (160 /
                                                                              411),
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child:
                                                                          Text(
                                                                        listViewChatMessagesRecord
                                                                            .text,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Urbanist',
                                                                              color: Color(0xffffffff),
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  // 채팅 메시지의 타임스탬프(timestamp)를 형식화하여 표시
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          dateTimeFormat(
                                                                              'jm',
                                                                              listViewChatMessagesRecord.timestamp!),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Urbanist',
                                                                                color: Color(0xffffffff),
                                                                                fontSize: 10.0,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      // 채팅 메시지가 읽음 여부 아이콘
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          MediaQuery.of(context).size.width *
                                                                              (6 / 411),
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          if (chatsChatsRecord?.messageSeen ??
                                                                              true)
                                                                            Icon(
                                                                              FFIcons.kcheckAll,
                                                                              color: Color(0xffffffff),
                                                                              size: 16.0,
                                                                            ),
                                                                          if (!chatsChatsRecord!
                                                                              .messageSeen)
                                                                            Icon(
                                                                              FFIcons.kcheckAll,
                                                                              color: Color(0xffffffff),
                                                                              size: 16.0,
                                                                            ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ), //채팅 메시지를 표시하는 부분을 화면에표시
                      ],
                    ),
                  ),

                  // 하단부
                  Padding(
                    //텍스트 박스
                    padding: EdgeInsetsDirectional.fromSTEB(
                        MediaQuery.of(context).size.width * (20 / 411),
                        0.0,
                        MediaQuery.of(context).size.width * (20 / 411),
                        MediaQuery.of(context).size.width * (24 / 411)),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width *
                                  (290 / 411), //텍스트 박스 크기
                              height: MediaQuery.of(context).size.height *
                                  (50 / 867),
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                  color: Color(0xFFE0E0E0),
                                ),
                              ),

                              child: Padding(
                                // 텍스트 상자
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    MediaQuery.of(context).size.width *
                                        (12 / 411),
                                    MediaQuery.of(context).size.width *
                                        (6 / 411),
                                    MediaQuery.of(context).size.width *
                                        (12 / 411),
                                    MediaQuery.of(context).size.width *
                                        (6 / 411)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: _model.textController,
                                        focusNode: _model.textFieldFocusNode,
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          hintText: 'Aa',
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Urbanist',
                                                    color: Color(0xFFBDBDBD),
                                                  ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium,
                                        validator: _model
                                            .textControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              (24 / 867),
                                      child: VerticalDivider(
                                        thickness: 1.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          MediaQuery.of(context).size.width *
                                              (6 / 411),
                                          0.0,
                                          0.0,
                                          0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        /* onTap: () async { // plus 플러스 버튼 온탭
                                          final selectedMedia =
                                              await selectMedia(
                                            maxWidth: 300.00,
                                            maxHeight: 300.00,
                                            imageQuality: 50,
                                            mediaSource:
                                                MediaSource.photoGallery,
                                            multiImage: false,
                                          );
                                          if (selectedMedia != null &&
                                              selectedMedia.every((m) =>
                                                  validateFileFormat(
                                                      m.storagePath,
                                                      context))) {
                                            setState(() =>
                                                _model.isDataUploading = true);
                                            var selectedUploadedFiles =
                                                <FFUploadedFile>[];

                                            var downloadUrls = <String>[];
                                            try {
                                              showUploadMessage(
                                                context,
                                                'Uploading file...',
                                                showLoading: true,
                                              );
                                              selectedUploadedFiles =
                                                  selectedMedia
                                                      .map(
                                                          (m) => FFUploadedFile(
                                                                name: m
                                                                    .storagePath
                                                                    .split('/')
                                                                    .last,
                                                                bytes: m.bytes,
                                                                height: m
                                                                    .dimensions
                                                                    ?.height,
                                                                width: m
                                                                    .dimensions
                                                                    ?.width,
                                                                blurHash:
                                                                    m.blurHash,
                                                              ))
                                                      .toList();

                                              downloadUrls = (await Future.wait(
                                                selectedMedia.map(
                                                  (m) async => await uploadData(
                                                      m.storagePath, m.bytes),
                                                ),
                                              ))
                                                  .where((u) => u != null)
                                                  .map((u) => u!)
                                                  .toList();
                                            } finally {
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();
                                              _model.isDataUploading = false;
                                            }
                                            if (selectedUploadedFiles.length ==
                                                    selectedMedia.length &&
                                                downloadUrls.length ==
                                                    selectedMedia.length) {
                                              setState(() {
                                                _model.uploadedLocalFile =
                                                    selectedUploadedFiles.first;
                                                _model.uploadedFileUrl =
                                                    downloadUrls.first;
                                              });
                                              showUploadMessage(
                                                  context, 'Success!');
                                            } else {
                                              setState(() {});
                                              showUploadMessage(context,
                                                  'Failed to upload data');
                                              return;
                                            }
                                          }

                                          if ((_model.textController.text !=
                                                      null &&
                                                  _model.textController.text !=
                                                      '') ||
                                              (_model.uploadedFileUrl != null &&
                                                  _model.uploadedFileUrl !=
                                                      '')) {
                                            await ChatMessagesRecord.collection
                                                .doc()
                                                .set(
                                                    createChatMessagesRecordData(
                                                  user: currentUserReference,
                                                  chatUser: widget.chatUser,
                                                  timestamp:
                                                      getCurrentTimestamp,
                                                  image: _model.uploadedFileUrl,
                                                ));

                                            await chatsChatsRecord!.reference
                                                .update(createChatsRecordData(
                                              lastMessageTime:
                                                  getCurrentTimestamp,
                                              lastMessage:
                                                  _model.textController.text,
                                            ));
                                            setState(() {
                                              _model.textController?.clear();
                                            });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Please type something...',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    Color(0x00000000),
                                              ),
                                            );
                                          }
                                        }, */
                                        // Plus버튼 onTab UI
                                        onTap: () async {
                                          showModalBottomSheet(
                                            // 모달 바텀 시트 보여주기
                                            context: context,
                                            isDismissible: false,
                                            builder: (context) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.zero,
                                                    topRight: Radius.zero,
                                                  ),
                                                  gradient: LinearGradient(
                                                    begin: Alignment(0, -1),
                                                    end: Alignment(0, 1),
                                                    colors: <Color>[
                                                      Color(0x0c4d40ea),
                                                      Color(0x0c6be0d2)
                                                    ], // 그라디언트 색상
                                                    stops: <double>[
                                                      0,
                                                      1
                                                    ], // 그라디언트 색상의 위치
                                                  ),
                                                ),
                                                width: double.infinity,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    (190 / 867),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: List.generate(
                                                    3,
                                                    (index) =>
                                                        Transform.translate(
                                                      offset: Offset(0,
                                                          -5.0), // 상단으로 올리고 싶은 만큼의 값 설정
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          if (index == 0) {
                                                            // 미디어 선택
                                                            final selectedMedia =
                                                                await selectMedia(
                                                              maxWidth: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  (300 / 411),
                                                              maxHeight: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  (300 / 867),
                                                              imageQuality: 50,
                                                              mediaSource:
                                                                  MediaSource
                                                                      .photoGallery,
                                                              multiImage: false,
                                                            );
                                                            if (selectedMedia !=
                                                                    null &&
                                                                selectedMedia.every((m) =>
                                                                    validateFileFormat(
                                                                        m.storagePath,
                                                                        context))) {
                                                              setState(() =>
                                                                  _model.isDataUploading =
                                                                      true);
                                                              var selectedUploadedFiles =
                                                                  <FFUploadedFile>[];

                                                              var downloadUrls =
                                                                  <String>[];
                                                              try {
                                                                showUploadMessage(
                                                                  context,
                                                                  'Uploading file...',
                                                                  showLoading:
                                                                      true,
                                                                );
                                                                selectedUploadedFiles =
                                                                    selectedMedia
                                                                        .map(
                                                                          (m) =>
                                                                              FFUploadedFile(
                                                                            name:
                                                                                m.storagePath.split('/').last,
                                                                            bytes:
                                                                                m.bytes,
                                                                            height:
                                                                                m.dimensions?.height,
                                                                            width:
                                                                                m.dimensions?.width,
                                                                            blurHash:
                                                                                m.blurHash,
                                                                          ),
                                                                        )
                                                                        .toList();

                                                                downloadUrls = (await Future
                                                                        .wait(
                                                                  selectedMedia
                                                                      .map(
                                                                    (m) async =>
                                                                        await uploadData(
                                                                            m.storagePath,
                                                                            m.bytes),
                                                                  ),
                                                                ))
                                                                    .where((u) =>
                                                                        u !=
                                                                        null)
                                                                    .map((u) =>
                                                                        u!)
                                                                    .toList();
                                                              } finally {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .hideCurrentSnackBar();
                                                                _model.isDataUploading =
                                                                    false;
                                                              }
                                                              if (selectedUploadedFiles
                                                                          .length ==
                                                                      selectedMedia
                                                                          .length &&
                                                                  downloadUrls
                                                                          .length ==
                                                                      selectedMedia
                                                                          .length) {
                                                                setState(() {
                                                                  _model.uploadedLocalFile =
                                                                      selectedUploadedFiles
                                                                          .first;
                                                                  _model.uploadedFileUrl =
                                                                      downloadUrls
                                                                          .first;
                                                                });
                                                                showUploadMessage(
                                                                    context,
                                                                    'Success!');
                                                                Navigator.pop(
                                                                    context);
                                                              } else {
                                                                setState(() {});
                                                                showUploadMessage(
                                                                    context,
                                                                    'Failed to upload data');
                                                                return;
                                                              }
                                                            }

                                                            if ((_model.textController
                                                                        .text !=
                                                                    '') ||
                                                                (_model.uploadedFileUrl !=
                                                                    '')) {
                                                              // 채팅 메시지 생성
                                                              await ChatMessagesRecord
                                                                  .collection
                                                                  .doc()
                                                                  .set(
                                                                    createChatMessagesRecordData(
                                                                      user:
                                                                          currentUserReference,
                                                                      chatUser:
                                                                          widget
                                                                              .chatUser,
                                                                      timestamp:
                                                                          getCurrentTimestamp,
                                                                      image: _model
                                                                          .uploadedFileUrl,
                                                                    ),
                                                                  );
                                                              // 마지막 메시지 업데이트 1
                                                              await (widget
                                                                      .chatUser
                                                                      ?.update(
                                                                          createChatsRecordData(
                                                                    lastMessageTime:
                                                                        getCurrentTimestamp,
                                                                    lastMessage:
                                                                        _model
                                                                            .textController
                                                                            .text,
                                                                  )) ??
                                                                  Future
                                                                      .value());
                                                              setState(() {
                                                                _model
                                                                    .textController
                                                                    ?.clear();
                                                              });
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Please type something...',
                                                                    style:
                                                                        TextStyle(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                    ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                  backgroundColor:
                                                                      Color(
                                                                          0x00000000),
                                                                ),
                                                              );
                                                            }
                                                          } else if (index ==
                                                              1) {
                                                            // Navigate to RewardScreen when index is 1
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      PaymentPassword(
                                                                        getPayPinNum:
                                                                            (value) =>
                                                                                print(value),
                                                                        onPinContinuePressed:
                                                                            () =>
                                                                                Navigator.of(context).push(
                                                                          MaterialPageRoute(
                                                                            builder:
                                                                                (context) {
                                                                              return PaymentDone();
                                                                            },
                                                                          ),
                                                                        ),
                                                                      )), // Replace signUpScreen() with your actual screen widget
                                                            );
                                                          } else {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          SignUpStepsScreen()), // Replace signUpScreen() with your actual screen widget
                                                            );
                                                          }
                                                        },
                                                        child: SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              (70 / 411),
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              (120 / 867),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    (70 / 411),
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    (70 / 867),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Color(
                                                                          0x0c000000)),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                  gradient:
                                                                      LinearGradient(
                                                                    begin:
                                                                        Alignment(
                                                                            0,
                                                                            -1),
                                                                    end:
                                                                        Alignment(
                                                                            0,
                                                                            1),
                                                                    colors: <Color>[
                                                                      Color(
                                                                          0x0c000000),
                                                                      Color(
                                                                          0x00ffffff)
                                                                    ],
                                                                    stops: <double>[
                                                                      0,
                                                                      1
                                                                    ],
                                                                  ),
                                                                ),
                                                                child: Stack(
                                                                  children: [
                                                                    Positioned(
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child: Image
                                                                            .asset(
                                                                          imageList[
                                                                              index],
                                                                          width:
                                                                              MediaQuery.of(context).size.width * (45 / 411),
                                                                          height:
                                                                              MediaQuery.of(context).size.height * (45 / 867),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 8.0),
                                                              Text(
                                                                index == 0
                                                                    ? '사진\n전송하기'
                                                                    : index == 1
                                                                        ? '사례금\n전달하기'
                                                                        : '부정사례\n신고하기',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xc5000000),
                                                                  fontSize:
                                                                      13.0,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },

                                        child: Image.asset(
                                          'assets/icons/plus_white.png',
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              (16 / 867),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              // 메세지 전송 (파이어 베이스)
                              onTap: () async {
                                if (_model.textController.text != '') {
                                  // 사용자 간의 채팅 메시지 생성
                                  await ChatMessagesRecord.collection
                                      .doc()
                                      .set(createChatMessagesRecordData(
                                        user: currentUserReference,
                                        chatUser: widget.chatUser,
                                        text: _model.textController.text,
                                        timestamp: getCurrentTimestamp,
                                      ));

                                  // 해당 채팅방의 마지막 메시지 업데이트 2
                                  await (widget.chatUser
                                          ?.update(createChatsRecordData(
                                        lastMessageTime: getCurrentTimestamp,
                                        lastMessage: _model.textController.text,
                                      )) ??
                                      Future.value());
                                  setState(() {
                                    _model.textController?.clear();
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Aa',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor: Color(0x00000000),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    (60 / 411),
                                height: MediaQuery.of(context).size.height *
                                    (50 / 867),
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(6.0),
                                  border: Border.all(
                                    color: Color(0xFFE0E0E0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icons/send_gradation.png',
                                      height:
                                          MediaQuery.of(context).size.height *
                                              (24 / 867),
                                      fit: BoxFit.contain,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
