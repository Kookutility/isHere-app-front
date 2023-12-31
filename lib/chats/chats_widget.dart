import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'chats_model.dart';
export 'chats_model.dart';

//길어서 주요 주석 내용 여기에 놓겠습니다. ctrl+f 로 밑의 내용 검색해서 검색 가능합니다.

//UI적인 코드는 124번 줄 부터 시작

// 사진 리스트
// 해당 인덱스의 이미지 사용
// 채팅 메시지를 표시하는 부분 (채팅 박스를 감싸는 UI)
// 상대방 채팅 박스
// 본인 채팅 박스
// 채팅 메시지를 표시 컨테이너
// Plus버튼 onTab UI
// 텍스트 상자
// plus 플러스 버튼 온탭 <- 예전 Plus 현재 주석

// 채팅 상단바
// 하단부
// 상단바 프로필(게시글 사진 들어갈 곳)

class ChatsWidget extends StatefulWidget {
  const ChatsWidget({
    Key? key,
    this.userName,
    this.chatUser,
    this.userRef,
    this.userProfile,
  }) : super(key: key);

  final String? userName;
  final DocumentReference? chatUser;
  final DocumentReference? userRef;
  final String? userProfile;

  @override
  _ChatsWidgetState createState() => _ChatsWidgetState();
}

List<String> imageList = [ // 사진 리스트
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
                width: 50.0,
                height: 50.0,
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
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 24.0, 20.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding( // 상단바 프로필(게시글 사진 들어갈 곳)
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    25.0, 0.0, 0.0, 0.0),
                                            child: Container(
                                              width: 60.0,
                                              height: 60.0,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20), // 사진 곡률
                                              ),
                                              child: Image.asset(
                                                'assets/images/macbook2.png', // 게시글 사진 
                                                // 이미지 용량에 따라서 로드 안될때가 있는 거 같음 현재 테스트시 150kb 이하는 가능
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Padding( //채팅 상단바
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20.0, 0.0, 0.0, 0.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '그린 플로럴',
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Urbanist',
                                                    color: Color(0xc9000000),
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                                Text(
                                                  '[귀중품] 구의역쪽에서 구찌 반지갑\n분실했습니다.', // 일정 크기 넘어가면 over됨
                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Urbanist',
                                                    color: Color(0xa5000000),
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding( // 상단바 프로필(게시글 사진 들어갈 곳)
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                25.0, 0.0, 0.0, 0.0),
                                            child: Image.asset(
                                              'assets/icons/right_gray.png',
                                              color: Color(0xFFBDBDBD),
                                              width: 24.0,
                                              height: 24.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Divider( //채팅 메시지 목록과 다른 UI 요소 간의 구분을 위한 수평 구분선을 생성
                          height: 48.0,
                          thickness: 1.0,
                          color: Color(0xFFE0E0E0),
                        ),

                        Expanded( //채팅 메시지를 표시하는 부분을 화면 표시
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 0.0, 20.0, 16.0),
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
                                            width: 50.0,
                                            height: 50.0,
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

                                      List<ChatMessagesRecord> // 스트림에서 비동기로 가져온 채팅 메시지 목록을 변수에 할당
                                          listViewChatMessagesRecordList =
                                          snapshot.data!;

                                      return ListView.builder( // 동적으로 아이템을 생성하여 스크롤 가능한 목록을 생성
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
                                              if ((listViewChatMessagesRecord.user != currentUserReference) &&
                                                  (listViewChatMessagesRecord.image != null && listViewChatMessagesRecord.image != ''))
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 24.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      // 1. 사용자 프로필 이미지
                                                      Container(
                                                        width: 36.0,
                                                        height: 36.0,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        // 상대방 프로필 사진 (이미지를 보낼때)
                                                        child: widget.userProfile != null && widget.userProfile!.isNotEmpty
                                                            ? Image.network(
                                                          widget.userProfile!,
                                                          fit: BoxFit.cover,
                                                        )
                                                            : Image.asset(
                                                          'assets/images/profile.png',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),

                                                      // 2. 이미지 채팅 메시지 컨테이너
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(16.0, 0.0, 0.0, 0.0),
                                                        child: Container(
                                                          width: 300.0,
                                                          height: 180.0,
                                                          constraints:
                                                              BoxConstraints(
                                                            maxWidth: 260.0,
                                                            maxHeight: 180.0,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                            image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: Image.network(
                                                                listViewChatMessagesRecord.image,
                                                              ).image,
                                                            ),
                                                            borderRadius: BorderRadius.only(
                                                              bottomLeft: Radius.circular(24.0),
                                                              bottomRight: Radius.circular(24.0),
                                                              topLeft: Radius.circular(24.0),
                                                              topRight: Radius.circular(24.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                              //채팅 메시지가 현재 사용자에 의해 작성되었고, 해당 메시지에 이미지가 첨부되어 있을 경우
                                              //이미지 메시지가 있는 경우 (타 사용자 작성)
                                              if ((listViewChatMessagesRecord.user == currentUserReference) &&
                                                  (listViewChatMessagesRecord.image != null && listViewChatMessagesRecord.image != ''))

                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      // 이미지 채팅 메시지 컨테이너
                                                      Container(
                                                        width: 300.0,
                                                        height: 180.0,
                                                        constraints: BoxConstraints(
                                                          maxWidth: 260.0,
                                                          maxHeight: 180.0,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                          image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: Image.network(listViewChatMessagesRecord.image,
                                                            ).image,
                                                          ),
                                                          borderRadius: BorderRadius.only(
                                                            bottomLeft: Radius.circular(24.0),
                                                            bottomRight: Radius.circular(24.0),
                                                            topLeft: Radius.circular(24.0),
                                                            topRight: Radius.circular(24.0),
                                                          ),
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            // 체크 아이콘
                                                            Align(
                                                              alignment: AlignmentDirectional(0.90, 0.85),
                                                              child: Icon(FFIcons.kcheckAll,
                                                                color: Colors.white,
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
                                              if ((listViewChatMessagesRecord.user != currentUserReference) &&
                                                  (listViewChatMessagesRecord.text != null && listViewChatMessagesRecord.text != ''))

                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: 36.0,
                                                        height: 36.0,
                                                        clipBehavior: Clip.antiAlias,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                        ),
                                                        // 상대방 프로필 사진 (텍스트만 보낼때)
                                                        child: widget.userProfile != null && widget.userProfile!.isNotEmpty
                                                            ? Image.network(
                                                          widget.userProfile!,
                                                          fit: BoxFit.cover,
                                                        )
                                                            : Image.asset(
                                                          'assets/images/profile.png',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),

                                                      Padding( //상대방 채팅 창
                                                        padding:
                                                            EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                                                        child: Container(
                                                          width: 300.0,
                                                          constraints: BoxConstraints(
                                                            maxWidth: 260.0,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                borderRadius:
                                                                BorderRadius.only(
                                                              bottomLeft: Radius.circular(4.0),
                                                              bottomRight: Radius.circular(18.0),
                                                              topLeft: Radius.circular(18.0),
                                                              topRight: Radius.circular(18.0),
                                                            ),
                                                                border: Border.all(
                                                                  color: Color(0xFF828282),
                                                                ),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.max,
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                              children: [
                                                                Column(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Container(
                                                                      width: 160.0,
                                                                      constraints: BoxConstraints(maxWidth: 260.0,
                                                                      ),
                                                                      decoration: BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                      ),
                                                                      child:
                                                                      Text(
                                                                        listViewChatMessagesRecord.text,
                                                                        style: FlutterFlowTheme.of(context).bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Urbanist',
                                                                              color: Color(0xff000000),
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Text(
                                                                      dateTimeFormat(
                                                                          'jm',
                                                                          listViewChatMessagesRecord.timestamp!),
                                                                      style: FlutterFlowTheme.of(context).bodyMedium
                                                                          .override(
                                                                            fontFamily: 'Urbanist',
                                                                            color: Color(0xff000000),
                                                                            fontSize: 11.0,
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
                                              if (listViewChatMessagesRecord.user == widget.userRef)
                                                Padding( // 본인 채팅 박스
                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      if (listViewChatMessagesRecord.text != null &&
                                                          listViewChatMessagesRecord.text != '')
                                                        Container(
                                                          width: 300.0,
                                                          constraints: BoxConstraints(
                                                            maxWidth: 260.0,
                                                          ),
                                                          decoration:
                                                          // 내가 보내는 채팅
                                                              BoxDecoration(
                                                            color: Color(0xff4d40ea),
                                                            borderRadius: BorderRadius.only(
                                                              bottomLeft: Radius.circular(18.0),
                                                              bottomRight: Radius.circular(4.0),
                                                              topLeft: Radius.circular(18.0),
                                                              topRight: Radius.circular(18.0),
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.max,
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                              children: [
                                                                Column(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Container( // 채팅 메시지를 표시 컨테이너
                                                                      width: 160.0,
                                                                      decoration: BoxDecoration(),
                                                                      child:
                                                                          Text(listViewChatMessagesRecord.text,
                                                                        style: FlutterFlowTheme.of(context).bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Urbanist',
                                                                              color: Color(0xffffffff),
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),


                                                                Row( // 채팅 메시지의 타임스탬프(timestamp)를 형식화하여 표시
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Column(
                                                                      mainAxisSize: MainAxisSize.max,
                                                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                                                                fontSize: 11.0,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),


                                                                    Padding( // 채팅 메시지가 읽음 여부 아이콘
                                                                      padding: EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 0.0, 0.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize: MainAxisSize.max,
                                                                        children: [
                                                                          if (chatsChatsRecord?.messageSeen ?? true)
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
                  Padding( //텍스트 박스
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 290.0, //텍스트 박스 크기
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                  color: Color(0xFFE0E0E0),
                                ),
                              ),


                              child: Padding( // 텍스트 상자
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 6.0, 12.0, 6.0),
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
                                      height: 24.0,
                                      child: VerticalDivider(
                                        thickness: 1.0,
                                      ),
                                    ),


                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          6.0, 0.0, 0.0, 0.0),
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
                                          showModalBottomSheet( // 모달 바텀 시트 보여주기
                                            context: context,
                                            isDismissible: false,
                                            builder: (context) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.zero,
                                                    topRight: Radius.zero,
                                                  ),
                                                  gradient: LinearGradient(
                                                    begin: Alignment(0, -1),
                                                    end: Alignment(0, 1),
                                                    colors: <Color>[Color(0x0c4d40ea), Color(0x0c6be0d2)], // 그라디언트 색상
                                                    stops: <double>[0, 1], // 그라디언트 색상의 위치
                                                  ),
                                                ),
                                                width: double.infinity,
                                                height: 190,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: List.generate(
                                                    3,
                                                        (index) => Transform.translate(
                                                      offset: Offset(0, -5.0), // 상단으로 올리고 싶은 만큼의 값 설정
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          if (index == 0) {
                                                            // 미디어 선택
                                                            final selectedMedia = await selectMedia(
                                                              maxWidth: 300.00,
                                                              maxHeight: 300.00,
                                                              imageQuality: 50,
                                                              mediaSource: MediaSource.photoGallery,
                                                              multiImage: false,
                                                            );
                                                            if (selectedMedia != null &&
                                                                selectedMedia.every((m) =>
                                                                    validateFileFormat(m.storagePath, context))) {
                                                              setState(() => _model.isDataUploading = true);
                                                              var selectedUploadedFiles = <FFUploadedFile>[];

                                                              var downloadUrls = <String>[];
                                                              try {
                                                                showUploadMessage(
                                                                  context,
                                                                  'Uploading file...',
                                                                  showLoading: true,
                                                                );
                                                                selectedUploadedFiles = selectedMedia
                                                                    .map(
                                                                      (m) => FFUploadedFile(
                                                                    name: m.storagePath.split('/').last,
                                                                    bytes: m.bytes,
                                                                    height: m.dimensions?.height,
                                                                    width: m.dimensions?.width,
                                                                    blurHash: m.blurHash,
                                                                  ),
                                                                )
                                                                    .toList();

                                                                downloadUrls = (await Future.wait(
                                                                  selectedMedia.map(
                                                                        (m) async =>
                                                                    await uploadData(m.storagePath, m.bytes),
                                                                  ),
                                                                ))
                                                                    .where((u) => u != null)
                                                                    .map((u) => u!)
                                                                    .toList();
                                                              } finally {
                                                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                                _model.isDataUploading = false;
                                                              }
                                                              if (selectedUploadedFiles.length ==
                                                                  selectedMedia.length &&
                                                                  downloadUrls.length == selectedMedia.length) {
                                                                setState(() {
                                                                  _model.uploadedLocalFile =
                                                                      selectedUploadedFiles.first;
                                                                  _model.uploadedFileUrl = downloadUrls.first;
                                                                });
                                                                showUploadMessage(context, 'Success!');
                                                                Navigator.pop(context);
                                                              } else {
                                                                setState(() {});
                                                                showUploadMessage(context, 'Failed to upload data');
                                                                return;
                                                              }
                                                            }

                                                            if ((_model.textController.text != null &&
                                                                _model.textController.text != '') ||
                                                                (_model.uploadedFileUrl != null &&
                                                                    _model.uploadedFileUrl != '')) {
                                                              // 채팅 메시지 생성
                                                              await ChatMessagesRecord.collection.doc().set(
                                                                createChatMessagesRecordData(
                                                                  user: currentUserReference,
                                                                  chatUser: widget.chatUser,
                                                                  timestamp: getCurrentTimestamp,
                                                                  image: _model.uploadedFileUrl,
                                                                ),
                                                              );
                                                              // 마지막 메시지 업데이트
                                                              await chatsChatsRecord!.reference.update(
                                                                createChatsRecordData(
                                                                  lastMessageTime: getCurrentTimestamp,
                                                                  lastMessage: _model.textController.text,
                                                                ),
                                                              );
                                                              setState(() {
                                                                _model.textController?.clear();
                                                              });
                                                            } else {
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Please type something...',
                                                                    style: TextStyle(
                                                                      color:
                                                                      FlutterFlowTheme.of(context).primaryText,
                                                                    ),
                                                                  ),
                                                                  duration: Duration(milliseconds: 4000),
                                                                  backgroundColor: Color(0x00000000),
                                                                ),
                                                              );
                                                            }
                                                          }
                                                        },
                                                        child: Container(
                                                          width: 70.0,
                                                          height: 120.0,
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Container(
                                                                width: 70.0,
                                                                height: 70.0,
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(color: Color(0x0c000000)),
                                                                  borderRadius: BorderRadius.circular(50),
                                                                  gradient: LinearGradient(
                                                                    begin: Alignment(0, -1),
                                                                    end: Alignment(0, 1),
                                                                    colors: <Color>[
                                                                      Color(0x0c000000),
                                                                      Color(0x00ffffff)
                                                                    ],
                                                                    stops: <double>[0, 1],
                                                                  ),
                                                                ),
                                                                child: Stack(
                                                                  children: [
                                                                    Positioned(
                                                                      child: Align(
                                                                        alignment: Alignment.center,
                                                                        child: Image.asset(
                                                                          imageList[index],
                                                                          width: 45.0,
                                                                          height: 45.0,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(height: 8.0),
                                                              Text(
                                                                index == 0
                                                                    ? '사진\n전송하기'
                                                                    : index == 1
                                                                    ? '사례금\n전달하기'
                                                                    : '부정사례\n신고하기',
                                                                style: TextStyle(
                                                                  color: Color(0xc5000000),
                                                                  fontSize: 13.0,
                                                                ),
                                                                textAlign: TextAlign.center,
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
                                          height: 16.0,
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
                              onTap: () async {
                                if (_model.textController.text != null &&
                                    _model.textController.text != '') {
                                  await ChatMessagesRecord.collection
                                      .doc()
                                      .set(createChatMessagesRecordData(
                                        user: currentUserReference,
                                        chatUser: widget.chatUser,
                                        text: _model.textController.text,
                                        timestamp: getCurrentTimestamp,
                                      ));

                                  await chatsChatsRecord!.reference
                                      .update(createChatsRecordData(
                                    lastMessageTime: getCurrentTimestamp,
                                    lastMessage: _model.textController.text,
                                  ));
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
                                width: 60.0,
                                height: 50.0,
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
                                      height: 24.0,
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
