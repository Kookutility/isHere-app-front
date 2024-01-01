import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:badges/badges.dart' as badges;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'chat_page_model.dart';
export 'chat_page_model.dart';

//길어서 주요 주석 내용 여기에 놓겠습니다. ctrl+f 로 밑의 내용 검색해서 검색 가능합니다.

//채팅창
//마지막 채팅 시간
//마지막 채팅 글
//username 과 마지막 채팅 위치
//프로필 사진
//채팅창 박스
//채팅 위 activeuser <- 이걸 통해 사용자 끼리 연결
// 각 사용자를 누를 때 채팅을 시작하는 기능
// 스크롤 가능한 채팅 목록 생성

class ChatPageWidget extends StatefulWidget {
  const ChatPageWidget({Key? key}) : super(key: key);

  @override
  _ChatPageWidgetState createState() => _ChatPageWidgetState();
}

class _ChatPageWidgetState extends State<ChatPageWidget>
    with TickerProviderStateMixin {
  late ChatPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = { // 애니메이션 정보를 담고 있는 맵을 정의
    // 첫 번째 애니메이션: 페이지 로드 시 트리거되는 회전 효과
    'containerOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad, // 페이지 로드 시 트리거
      effects: [
        RotateEffect( // 회전 효과를 정의
          curve: Curves.easeInOut, // 애니메이션 커브
          delay: 0.ms, // 지연 시간
          duration: 600.ms,  // 지속 시간
          begin: 0.0, // 시작 값
          end: 1.0, // 종료 값
        ),
      ],
    ),

    // 두 번째 애니메이션: 페이지 로드 시 트리거되는 페이드 인 효과
    'containerOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,  // 페이지 로드 시 트리거
      effects: [
        FadeEffect(  // 페이드 인 효과를 정의
          curve: Curves.easeIn,  // 애니메이션 커브
          delay: 0.ms,  // 지연 시간
          duration: 1000.ms,  // 지속 시간
          begin: 0.0,  // 시작 값
          end: 1.0,  // 종료 값
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatPageModel());

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
            children: [
              /*Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 20.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  /*children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/_1.png',
                          width: 48.0,
                          fit: BoxFit.contain,
                        ),
                        AuthUserStreamWidget(
                          builder: (context) => InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed('Profile');
                            },
                            child: Container(
                              width: 48.0,
                              height: 48.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.network(
                                    currentUserPhoto,
                                  ).image,
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xFF828282),
                                ),
                              ),
                            ),
                          ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation1']!),
                        ),
                      ],
                    ),
                  ],*/
                ),
              ),*/

              //채팅 위 activeuser <- 이걸 통해 사용자 끼리 연결
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 60.0,
                                height: 60.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE0E0E0),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(0xFF2F80ED),
                                  ),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                StreamBuilder<List<UsersRecord>>(
                                  stream: queryUsersRecord(),
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

                                    // 사용자 목록 중에서 현재 사용자의 UID가 아닌 사용자들로 구성된 새로운 목록을 생성
                                    List<UsersRecord> rowUsersRecordList = snapshot.data!.where((u) => u.uid != currentUserUid).toList();
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: List.generate(
                                            rowUsersRecordList.length,
                                            (rowIndex) {
                                          final rowUsersRecord = rowUsersRecordList[rowIndex];
                                          return Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    6.0, 0.0, 0.0, 0.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async { // 각 사용자를 누를 때 채팅을 시작하는 기능
                                                await ChatsRecord.collection
                                                    .doc()
                                                    .set(createChatsRecordData(
                                                      user:
                                                          currentUserReference,
                                                      userA:
                                                          currentUserReference,
                                                      userB: rowUsersRecord.reference,
                                                      lastMessage: 'NA',
                                                      lastMessageTime:
                                                          getCurrentTimestamp,
                                                      image: rowUsersRecord.photoUrl,
                                                      messageSeen: false,
                                                    ));
                                              },
                                              child: Container(
                                                width: 60.0,
                                                height: 60.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Color(0xFF2F80ED),
                                                  ),
                                                ),
                                                child: ClipOval(
                                                  child: rowUsersRecord.photoUrl != null && rowUsersRecord.photoUrl.isNotEmpty
                                                      ? Image.network(
                                                    rowUsersRecord.photoUrl,
                                                    width: 60.0,
                                                    height: 60.0,
                                                    fit: BoxFit.cover,
                                                  )
                                                      : Image.asset(
                                                    'assets/images/profile.png',
                                                    width: 60.0,
                                                    height: 60.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )
                                            ),
                                          );
                                        }),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),


              Expanded( // 채팅 목록을 표시하는 화면의 일부를 구성
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 12.0, 20.0, 24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        StreamBuilder<List<ChatsRecord>>(
                          stream: queryChatsRecord(
                            queryBuilder: (chatsRecord) => chatsRecord
                                .orderBy('last_message_time', descending: true),
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                ),
                              );
                            }
                            List<ChatsRecord> listViewChatsRecordList = snapshot.data!;

                            return ListView.builder( // 스크롤 가능한 채팅 목록 생성
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: listViewChatsRecordList.length,
                              // 'itemCount는 채팅 목록의 항목 수, listViewChatsRecordList.length로 설정
                              itemBuilder: (context, listViewIndex) {
                                // 각 채팅 항목에 대한 빌더
                                final listViewChatsRecord =
                                    listViewChatsRecordList[listViewIndex];
                                return Visibility( // 현재 사용자가 채팅의 참여자인 경우에만 채팅을 표시
                                  visible: (currentUserReference ==
                                          listViewChatsRecord.userA) ||
                                      (currentUserReference ==
                                          listViewChatsRecord.userB),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 12.0, 0.0, 0.0),
                                    // StreamBuilder를 사용하여 채팅 상대방의 사용자 데이터를 비동기적으로 가져옴
                                    child: StreamBuilder<UsersRecord>( //상대방의 UID를 확인하여 그에 맞는 사용자 정보만 가져오도록 함
                                      stream: UsersRecord.getDocument(
                                        currentUserReference == listViewChatsRecord.userA
                                            ? listViewChatsRecord.userB!
                                            : listViewChatsRecord.userA!,
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
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        final containerUsersRecord = snapshot.data!;

                                        return InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            // onTap 이벤트에서는 'Chats' 페이지로 이동하고,
                                            // 채팅이 읽혔음을 표시하기 위해 messageSeen을 업데이트합니다.
                                            context.pushNamed(
                                              'Chats',
                                              queryParameters: {
                                                //'email': containerUsersRecord.email 값을 문자열로 직렬화하여 전달
                                                'chatUser': serializeParam(
                                                  listViewChatsRecord.reference,
                                                  ParamType.DocumentReference,
                                                ),
                                                'userRef': serializeParam(
                                                  currentUserReference,
                                                  ParamType.DocumentReference,
                                                ),
                                                'userProfile': serializeParam( // 상대방 프로필 사진
                                                  // 358줄 참고
                                                  containerUsersRecord.photoUrl,
                                                  ParamType.String,
                                                ),
                                                'userName': serializeParam(
                                                  containerUsersRecord.displayName,
                                                  ParamType.String,
                                                ),
                                              }.withoutNulls,
                                            );

                                            await listViewChatsRecord.reference
                                                .update(createChatsRecordData(
                                              messageSeen: true,
                                            ));
                                          },
                                          child: Container( //채팅창 박스
                                            width: double.infinity, // 가로로 끝이 없이 이어짐
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                              borderRadius: BorderRadius.circular(0),
                                              border: Border(
                                                bottom: BorderSide(
                                                  color:  Color(0x0f000000),
                                                ),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 16.0, 16.0, 16.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          if (currentUserReference != listViewChatsRecord.user) //현재 사용자와 대화 상대가 다른 경우
                                                            StreamBuilder<
                                                                UsersRecord>(
                                                              stream: UsersRecord
                                                                  .getDocument(
                                                                      listViewChatsRecord
                                                                          .userA!),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width: 50.0,
                                                                      height: 50.0,
                                                                      child: CircularProgressIndicator(
                                                                        valueColor: AlwaysStoppedAnimation<Color>(
                                                                          FlutterFlowTheme.of(context).primary,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                final circleImageUsersRecord = snapshot.data!;
                                                                return Container(
                                                                  width: 48.0,
                                                                  height: 48.0,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                  ),
                                                                  child: circleImageUsersRecord.photoUrl != null && circleImageUsersRecord.photoUrl.isNotEmpty
                                                                      ? Image.network(
                                                                    circleImageUsersRecord.photoUrl,
                                                                    fit: BoxFit.cover,
                                                                  )
                                                                      : Image.asset(
                                                                    'assets/images/profile.png',
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          if (currentUserReference == listViewChatsRecord.user) //현재 사용자와 대화 상대가 같은 경우
                                                            Container(
                                                              width: 48.0,
                                                              height: 48.0,
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: containerUsersRecord.photoUrl != null && containerUsersRecord.photoUrl.isNotEmpty
                                                                  ? Image.network(
                                                                containerUsersRecord.photoUrl,
                                                                fit: BoxFit.cover,
                                                              )
                                                                  : Image.asset(
                                                                'assets/images/profile.png',
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional //username 과 마지막 채팅 위치 조정
                                                                    .fromSTEB(12.0, 0.0, 0.0, 0.0),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.max,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                if (currentUserReference != listViewChatsRecord.user)
                                                                  StreamBuilder<
                                                                      UsersRecord>(
                                                                    stream: UsersRecord.getDocument(
                                                                        listViewChatsRecord.userA!),
                                                                    builder:
                                                                        (context, snapshot) {
                                                                      // Customize what your widget looks like when it's loading.
                                                                      if (!snapshot
                                                                          .hasData) {
                                                                        return Center(
                                                                          child:
                                                                              SizedBox(
                                                                            width: 50.0,
                                                                            height: 50.0,
                                                                            child: CircularProgressIndicator(
                                                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                                                FlutterFlowTheme.of(context).primary,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                      final textUsersRecord = snapshot.data!;
                                                                      return Text(
                                                                        textUsersRecord.displayName,
                                                                        style: FlutterFlowTheme.of(context).bodyMedium,
                                                                      );
                                                                    },
                                                                  ),
                                                                if (currentUserReference == listViewChatsRecord.user)
                                                                  Text(
                                                                    containerUsersRecord.displayName,
                                                                    style: FlutterFlowTheme.of(context).bodyMedium,
                                                                  ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(0.0, 6.0, 0.0, 0.0),
                                                                  child: Text( //마지막 채팅 글
                                                                    listViewChatsRecord.lastMessage,
                                                                    style: FlutterFlowTheme.of(context).bodyMedium
                                                                        .override(
                                                                          fontFamily: 'Urbanist',
                                                                          color: Color(0xFF828282),
                                                                          fontSize: 12.0,
                                                                          fontWeight: FontWeight.w500,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Column( //채팅창
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text( //마지막 채팅 시간
                                                        dateTimeFormat(
                                                            'relative',
                                                            listViewChatsRecord.lastMessageTime!),
                                                        style: FlutterFlowTheme.of(context).bodyMedium
                                                            .override(
                                                              fontFamily: 'Urbanist',
                                                              color: Color(0xFF828282),
                                                              fontSize: 12.0,
                                                            ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            if (listViewChatsRecord.messageSeen)
                                                              Icon(
                                                                FFIcons.kcheckAll,
                                                                color: Color(0xFF5780F7),
                                                                size: 20.0,
                                                              ),
                                                            if (!listViewChatsRecord.messageSeen)
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(0.0, 6.0, 0.0, 0.0),
                                                                child: Icon(
                                                                  FFIcons.kcheckAll,
                                                                  color: Color(0xFFBDBDBD),
                                                                  size: 20.0,
                                                                ),
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
                                        ).animateOnPageLoad(animationsMap[
                                            'containerOnPageLoadAnimation2']!);
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
