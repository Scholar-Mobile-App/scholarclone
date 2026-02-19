import 'package:get/get.dart';
import 'package:scholar_clone/presentation/admin/admin_add_circular/admin_add_circular_screen.dart';
import 'package:scholar_clone/presentation/admin/admin_add_photo_video/admin_add_photo_video_screen.dart';
import 'package:scholar_clone/presentation/admin/admin_approve_leave/admin_approve_student_leave_screen.dart';
import 'package:scholar_clone/presentation/admin/admin_main/admin_main_screen.dart';
import 'package:scholar_clone/presentation/admin/admin_own_profile/admin_own_profile_screen.dart';
import 'package:scholar_clone/presentation/admin/admission_confirmation/admission_confirmation_screen.dart';
import 'package:scholar_clone/presentation/admin/admission_confirmation/create/create_admission_confirmation_screen.dart';
import 'package:scholar_clone/presentation/admin/admission_enquiry/admission_enquiry_screen.dart';
import 'package:scholar_clone/presentation/admin/admission_enquiry/create/create_admission_enquiry_screen.dart';
import 'package:scholar_clone/presentation/admin/admission_registration/admission_registration_screen.dart';
import 'package:scholar_clone/presentation/admin/admission_registration/create/create_admission_registration_screen.dart';
import 'package:scholar_clone/presentation/admin/assign_homework/admin_assign_homework_screen.dart';
import 'package:scholar_clone/presentation/admin/capture_photos/admin_capture_photos_screen.dart';
import 'package:scholar_clone/presentation/admin/email_parent/admin_send_email_screen.dart';
import 'package:scholar_clone/presentation/admin/fees_collect/fees_collect_screen.dart';
import 'package:scholar_clone/presentation/admin/fees_collect/fees_details/fees_collect_details_screen.dart';
import 'package:scholar_clone/presentation/admin/fees_collect/fees_details/online_receipt_view.dart';
import 'package:scholar_clone/presentation/admin/inward/add_inward/add_admin_inward_screen.dart';
import 'package:scholar_clone/presentation/admin/inward/admin_inward_screen.dart';
import 'package:scholar_clone/presentation/admin/leave_requests/leave_requests_screen.dart';
import 'package:scholar_clone/presentation/admin/leave_requests_details/leave_requests_details_screen.dart';
import 'package:scholar_clone/presentation/admin/notification_parent/admin_send_notification_screen.dart';
import 'package:scholar_clone/presentation/admin/outward/add_outward/add_admin_outward_screen.dart';
import 'package:scholar_clone/presentation/admin/outward/admin_outward_screen.dart';
import 'package:scholar_clone/presentation/admin/sms_parent/admin_send_sms_screen.dart';
import 'package:scholar_clone/presentation/admin/student_attendance_photos/student_attendance_photos_screen.dart';
import 'package:scholar_clone/presentation/admin/student_profile_list/admin_student_profile_list_screen.dart';
import 'package:scholar_clone/presentation/admin/student_disclipline/admin_student_disclipline_screen.dart';
import 'package:scholar_clone/presentation/admin/t_teacher_profile/teacher_profile_screen.dart';
import 'package:scholar_clone/presentation/auth/login/login_screen.dart';
import 'package:scholar_clone/presentation/auth/sign_up/sign_up_screen.dart';
import 'package:scholar_clone/presentation/auth/splash/splash_screen.dart';
import 'package:scholar_clone/presentation/students/acadamic_activity/acadamic_activity_screen.dart';
import 'package:scholar_clone/presentation/students/academic_calendar/academic_calendar_screen.dart';
import 'package:scholar_clone/presentation/students/achievement/achievement_screen.dart';
import 'package:scholar_clone/presentation/students/achievement_certificate/achievement_certificate_screen.dart';
import 'package:scholar_clone/presentation/students/classwork_gallery/classwork_gallery_screen.dart';
import 'package:scholar_clone/presentation/students/consent/consent_screen.dart';
import 'package:scholar_clone/presentation/students/exam_schedule/exam_schedule_screen.dart';
import 'package:scholar_clone/presentation/students/facility/facility_screen.dart';
import 'package:scholar_clone/presentation/students/fees_details/fees_details_screen.dart';
import 'package:scholar_clone/presentation/students/health_details/health_details_screen.dart';
import 'package:scholar_clone/presentation/students/height_weight/height_weight_screen.dart';
import 'package:scholar_clone/presentation/students/homework/homework_screen.dart';
import 'package:scholar_clone/presentation/students/circular_events/circular_events_screen.dart';
import 'package:scholar_clone/presentation/students/infirmary/infirmary_screen.dart';
import 'package:scholar_clone/presentation/students/leaderboard/leaderboard_screen.dart';
import 'package:scholar_clone/presentation/students/learn/learn_screen.dart';
import 'package:scholar_clone/presentation/students/leave/leave_screen.dart';
import 'package:scholar_clone/presentation/students/lms_chapte_detail/lms_chapte_detail_screen.dart';
import 'package:scholar_clone/presentation/students/lms_pal/chepter/chapter_screen.dart';
import 'package:scholar_clone/presentation/students/lms_pal/lms_pal_screen.dart';
import 'package:scholar_clone/presentation/students/lms_subject/lms_subject_screen.dart';
import 'package:scholar_clone/presentation/students/parent_communication/parent_communication_screen.dart';
import 'package:scholar_clone/presentation/students/photos_gallery/photos_gallery_screen.dart';
import 'package:scholar_clone/presentation/students/photos_gallery_view/photos_gallery_view_screen.dart';
import 'package:scholar_clone/presentation/students/photos_gallery_view/zoom_photo/zoom_photo_screen.dart';
import 'package:scholar_clone/presentation/students/portfolio/portfolio_screen.dart';
import 'package:scholar_clone/presentation/students/principal_desk/principal_desk_screen.dart';
import 'package:scholar_clone/presentation/students/reach_us/reach_us_screen.dart';
import 'package:scholar_clone/presentation/students/results_pdf/results_pdf_screen.dart';
import 'package:scholar_clone/presentation/students/rules/rules_screen.dart';
import 'package:scholar_clone/presentation/students/school_information/school_information_screen.dart';
import 'package:scholar_clone/presentation/students/school_timing/school_timing_screen.dart';
import 'package:scholar_clone/presentation/students/social_collabrative/social_collabrative_screen.dart';
import 'package:scholar_clone/presentation/students/student_attendance/student_attendance_screen.dart';
import 'package:scholar_clone/presentation/students/student_discipline/student_discipline_screen.dart';
import 'package:scholar_clone/presentation/students/student_face_attendance/student_face_attendance_screen.dart';
import 'package:scholar_clone/presentation/students/student_main/student_main_screen.dart';
import 'package:scholar_clone/presentation/students/students_notification_hub/students_notification_hub_screen.dart';
import 'package:scholar_clone/presentation/students/students_user_list/students_user_list_screen.dart';
import 'package:scholar_clone/presentation/students/teacher_list/teacher_list_screen.dart';
import 'package:scholar_clone/presentation/students/test_qna/test_qna_screen.dart';
import 'package:scholar_clone/presentation/students/test_report/test_report_screen.dart';
import 'package:scholar_clone/presentation/students/test_report_list/test_report_list_screen.dart';
import 'package:scholar_clone/presentation/students/test_result/test_result_screen.dart';
import 'package:scholar_clone/presentation/students/timetable/timetable_screen.dart';
import 'package:scholar_clone/presentation/students/transport/transport_screen.dart';
import 'package:scholar_clone/presentation/students/vaccination/vaccination_screen.dart';
import 'package:scholar_clone/presentation/students/virtual_classroom/virtual_classroom_screen.dart';
import 'package:scholar_clone/presentation/students/web_view/web_view_screen.dart';
import 'package:scholar_clone/presentation/students/youtube_video_player/youtube_video_player_screen.dart';
import 'package:scholar_clone/presentation/students/about_us/about_us_screen.dart';
import 'package:scholar_clone/presentation/teacher/add_circular/add_circular_screen.dart';
import 'package:scholar_clone/presentation/teacher/add_circular/circular_list/circular_list_screen.dart';
import 'package:scholar_clone/presentation/teacher/add_photo_video/add_photo_video_screen.dart';
import 'package:scholar_clone/presentation/teacher/apply_leave/apply_leave_screen.dart';
import 'package:scholar_clone/presentation/teacher/approve_student_leave/approve_student_leave_screen.dart';
import 'package:scholar_clone/presentation/teacher/assign_homework/assign_homework_screen.dart';
import 'package:scholar_clone/presentation/teacher/assign_homework/homework_list/assign_homework_list_screen.dart';
import 'package:scholar_clone/presentation/teacher/gallary/gallary_screen.dart';
import 'package:scholar_clone/presentation/teacher/gallary/photos/photo_screen.dart';
import 'package:scholar_clone/presentation/teacher/gallary/videos/videos_screen.dart';
import 'package:scholar_clone/presentation/teacher/leave_history/leave_history_screen.dart';
import 'package:scholar_clone/presentation/teacher/lesson_planning/lesson_planning_screen.dart';
import 'package:scholar_clone/presentation/teacher/my_attendance/my_attendance_screen.dart';
import 'package:scholar_clone/presentation/teacher/my_leave/my_leave_screen.dart';
import 'package:scholar_clone/presentation/teacher/own_profile/own_profile_screen.dart';
import 'package:scholar_clone/presentation/teacher/punch_in_out/punch_in_out_screen.dart';
import 'package:scholar_clone/presentation/teacher/reply_parent_communication/reply_parent_communication_screen.dart';
import 'package:scholar_clone/presentation/teacher/send_notification/send_notification_screen.dart';
import 'package:scholar_clone/presentation/teacher/student_profile_list/student_profile_list_screen.dart';
import 'package:scholar_clone/presentation/teacher/student_profile_list_details/student_profile_list_details_screen.dart';
import 'package:scholar_clone/presentation/teacher/t_capture_photos/t_capture_photos_screen.dart';
import 'package:scholar_clone/presentation/teacher/t_complain/add_complain/add_complain_screen.dart';
import 'package:scholar_clone/presentation/teacher/t_complain/t_complain_screen.dart';
import 'package:scholar_clone/presentation/teacher/t_email_parent/send_email_screen.dart';
import 'package:scholar_clone/presentation/teacher/t_exam_schedule/add_exam/add_exam_screen.dart';
import 'package:scholar_clone/presentation/teacher/t_exam_schedule/t_exam_schedule_screen.dart';
import 'package:scholar_clone/presentation/teacher/t_mark_entry/t_mark_entry_screen.dart';
import 'package:scholar_clone/presentation/teacher/t_marks/t_marks_screen.dart';
import 'package:scholar_clone/presentation/teacher/t_notification_report/t_notification_report_screen.dart';
import 'package:scholar_clone/presentation/teacher/t_proxy/t_proxy_management_screen.dart';
import 'package:scholar_clone/presentation/teacher/t_requisition/add_requisition/add_requisition_screen.dart';
import 'package:scholar_clone/presentation/teacher/t_requisition/t_requisition_screen.dart';
import 'package:scholar_clone/presentation/teacher/t_sms_parent/teacher_send_sms_screen.dart';
import 'package:scholar_clone/presentation/teacher/t_social_collobrative/t_social_collobrative_screen.dart';
import 'package:scholar_clone/presentation/teacher/t_student_disclipline/t_student_disclipline_screen.dart';
import 'package:scholar_clone/presentation/teacher/t_teach/t_subject_details/t_subject_details_screen.dart';
import 'package:scholar_clone/presentation/teacher/t_teach/t_teach_screen.dart';
import 'package:scholar_clone/presentation/teacher/t_teach/teach_subject/teach_subject_screen.dart';
import 'package:scholar_clone/presentation/teacher/t_teacher_resource/t_teacher_resource_screen.dart';
import 'package:scholar_clone/presentation/teacher/t_virtual_classroom/t_virtual_classroom_screen.dart';
import 'package:scholar_clone/presentation/teacher/t_visitor/add_visitor/add_visitor_screen.dart';
import 'package:scholar_clone/presentation/teacher/t_visitor/teacher_visitor_screen.dart';
import 'package:scholar_clone/presentation/teacher/t_wrt_progress/t_wrt_progress_screen.dart';
import 'package:scholar_clone/presentation/teacher/take_attendance/take_attendance_screen.dart';
import 'package:scholar_clone/presentation/teacher/task/add_task/add_task_screen.dart';
import 'package:scholar_clone/presentation/teacher/task/task_screen.dart';
import 'package:scholar_clone/presentation/teacher/teacher_main/teacher_main_screen.dart';
import 'package:scholar_clone/presentation/teacher/time_table/time_table_screen.dart';
import 'package:scholar_clone/presentation/students/certificate/certificate_screen.dart';
import 'package:scholar_clone/presentation/students/holiday_list/holiday_list_screen.dart';
import 'package:scholar_clone/presentation/students/wrt_progress_report/wrt_progress_report_screen.dart';

import '../presentation/admin/capture_attendance/admin_capture_attendance_screen.dart';
import '../presentation/admin/t_teacher_profile/admin_teacher_profile_screen.dart';
import '../presentation/students/hostel/hostel_screen.dart';
import '../presentation/students/video_player/video_player_screen.dart';
import '../presentation/teacher/gallary/t_zoom_photo/t_zoom_photo_screen.dart';
import '../presentation/teacher/t_calander/t_calander_screen.dart';
import '../presentation/teacher/t_message/t_message_screen.dart';

class AppRoutes {
  static const String splash = "/splash";
  static const String login = "/login";
  static const String signUp = "/signUp";
  static const String studentUserList = "/studentUserList";
  static const String studentMain = "/studentMain";
  static const String learn = "/learn";
  static const String lmsSubject = "/lmsSubject";
  static const String lmsChapteDetail = "/lmsChapteDetail";
  static const String circularEvents = "/circularEvents";
  static const String studentAttendance = "/studentAttendance";
  static const String teacherList = "/teacherList";
  static const String photoGallery = "/photoGallery";
  static const String studentNotificationHub = "/studentNotificationHub";
  static const String homework = "/homework";
  static const String leave = "/leave";
  static const String parentCommunication = "/parentCommunication";
  static const String timeTable = "/timeTable";
  static const String photoGalleryView = "/photoGalleryView";
  static const String teacherMain = "/teacherMain";
  static const String ownProfile = "/ownProfile";
  static const String assignHomeWork = "/assignHomeWork";
  static const String assignHomeWorkList = "/assignHomeWorkList";
  static const String addCircular = "/addCircular";
  static const String circularList = "/circularList";
  static const String takeAttendance = "/takeAttendance";
  static const String replyParentCommunication = "/replyParentCommunication";
  static const String studentProfileList = "/studentProfileList";
  static const String studentProfileListDetail = "/studentProfileListDetail";
  static const String sendNotification = "/sendNotification";
  static const String teacherTimetable = "/teacherTimetable";
  static const String approveStudentLeave = "/approveStudentLeave";
  static const String testQnA = "/testQnA";
  static const String testReport = "/testReport";
  static const String testReportList = "/testReportList";
  static const String testResult = "/testResult";
  static const String zoomPhoto = "/zoomPhoto";
  static const String tzoomPhoto = "/tzoomPhoto";
  static const String studentDiscipline = "/studentDiscipline";
  static const String healthDetails = "/healthDetails";
  static const String holidayList = "/holidayList";
  static const String feesDetails = "/feesDetails";
  static const String wrtProgressReport = "/wrtProgressReport";
  static const String certificate = "/certificate";
  static const String transport = "/transport";
  static const String gallary = "/gallary";
  static const String addPhotoVideo = "/addPhotoVideo";
  static const String tPhotos = "/tPhotos";
  static const String tVideos = "/tVideos";
  static const String tStudentDisclipline = "/tStudentDisclipline";
  static const String webView = "/webView";
  static const String youtubeVideoPlayer = "/youtubeVideoPlayer";
  static const String videoPlayer = "/videoPlayer";
  static const String hostel = "/hostel";
  static const String infirmary = "/infirmary";
  static const String vaccination = "/vaccination";
  static const String heightWeight = "/heightWeight";
  static const String consent = "/consent";
  static const String resultsPDF = "/resultsPDF";
  static const String examSchedule = "/examSchedule";
  static const String academicCalendar = "/academicCalendar";
  static const String tProxy = "/tProxy";
  static const String tWRTProgress = "/tWRTProgress";
  static const String aboutUs = "/aboutUs";
  static const String principalDesk = "/principalDesk";
  static const String schoolInformation = "/schoolInformation";
  static const String achievement = "/achievement";
  static const String schoolTiming = "/schoolTiming";
  static const String rules = "/rules";
  static const String facility = "/facility";
  static const String acadamicActivity = "/acadamicActivity";
  static const String reachUs = "/reachUs";
  static const String portfolio = "/portfolio";
  static const String leaderboard = "/leaderboard";
  static const String socialCollabrative = "/socialCollabrative";
  static const String virtualClassroom = "/virtualClassroom";
  static const String studentFaceAttendance = "/studentFaceAttendance";
  static const String tMessage = "/tMessage";
  static const String tExamSchedule = "/tExamSchedule";
  static const String tCalander = "/tCalander";
  static const String addExam = "/addExam";
  static const String task = "/task";
  static const String addTask = "/addTask";
  static const String tRequisition = "/tRequisition";
  static const String addRequisition = "/addRequisition";
  static const String tComplain = "/tComplain";
  static const String addComplain = "/addComplain";
  static const String teacherVisitor = "/teacherVisitor";
  static const String addVisitor = "/addVisitor";
  static const String sendSMS = "/sendSMS";
  static const String sendEmail = "/sendEmail";
  static const String adminMain = "/adminMain";
  static const String adminAssignHomeWork = "/adminAssignHomeWork";
  static const String adminAddCircular = "/adminAddCircular";
  static const String adminStudentProfileList = "/adminStudentProfileList";
  static const String adminStudentDiscipline = "/adminStudentDiscipline";
  static const String adminSendSMS = "/adminSendSMS";
  static const String adminSendNotification = "/adminSendNotification";
  static const String adminSendEmail = "/adminSendEmail";
  static const String adminApproveLeave = "/adminApproveLeave";
  static const String adminAddPhotos = "/adminAddPhotos";
  static const String adminTeacherProfile = "/adminTeacherProfile";
  static const String teacherProfile = "/teacherProfile";
  static const String teach = "/teach";
  static const String teachSubject = "/teachSubject";
  static const String tLMSChapteDetail = "/tLMSChapteDetail";
  static const String tVirtualClassroom = "/tVirtualClassroom";
  static const String teacherResource = "/teacherResource";
  static const String lessonPlanning = "/lessonPlanning";
  static const String tsocialCollobrative = "/tsocialCollobrative";
  static const String adminCapturePhotos = "/adminCapturePhotos";
  static const String studentAttendancePhoto = "/studentAttendancePhoto";
  static const String adminOwnProfile = "/adminOwnProfile";
  static const String adminCaptureAttendance = "/adminCaptureAttendance";
  static const String tmarks = "/tmarks";
  static const String marksEntryResult = "/marksEntryResult";
  static const String teacherCapturePhoto = "/teacherCapturePhoto";
  static const String teacherNotificationReport = "/teacherNotificationReport";
  static const String adminOutward = "/adminOutward";
  static const String addAdminOutward = "/addAdminOutward";
  static const String adminInward = "/adminInward";
  static const String addAdminInward = "/addAdminInward";
  static const String admissionConfirmation = "/admissionConfirmation";
  static const String createAdmissionConfirmation =
      "/createAdmissionConfirmation";
  static const String admissionEnquiry = "/admissionEnquiry";
  static const String admissionRegistration = "/admissionRegistration";
  static const String createAdmissionRegistration =
      "/createAdmissionRegistration";
  static const String createAdmissionEnquiry = "/createAdmissionEnquiry";
  static const String achievementCertificate = "/achievementCertificate";
  static const String pal = "/pal";
  static const String chapter = "/chapter";
  static const String feesCollect = "/feesCollect";
  static const String feesCollectDetails = "/feesCollectDetails";
  static const String onlineReceptView = "/onlineReceptView";
  static const String myLeave = "/my_leave";
  static const String leaveHistory = "/leave_history";
  static const String myAttendance = "/my_attendance";
  static const String leaveRequests = "/leave_requests";
  static const String leaveRequestsDetails = "/leave_requests_details";
  static const String applyLeave = "/apply_leave";
  static const String punchInOut = "/punch_in_out";
  static const String classworkGallery = "/classwork_gallery";

  static List<GetPage> pages = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: signUp, page: () => SignUpSreen()),
    GetPage(name: studentUserList, page: () => StudentUserListScreen()),
    GetPage(name: studentMain, page: () => StudentMainScreen()),
    GetPage(name: learn, page: () => LearnScreen()),
    GetPage(name: lmsSubject, page: () => LMSSubjectScreen()),
    GetPage(name: lmsChapteDetail, page: () => LMSChapteDetailScreen()),
    GetPage(name: studentAttendance, page: () => StudentAttendanceScreen()),
    GetPage(name: circularEvents, page: () => CircularEventsScreen()),
    GetPage(name: teacherList, page: () => TeacherListScreen()),
    GetPage(name: photoGallery, page: () => PhotoGalleryScreen()),
    GetPage(
        name: studentNotificationHub,
        page: () => StudentNotificationHubScreen()),
    GetPage(name: homework, page: () => HomeworkScreen()),
    GetPage(name: leave, page: () => LeaveScreen()),
    GetPage(name: parentCommunication, page: () => ParentCommunicationScreen()),
    GetPage(name: timeTable, page: () => TimeTableScreen()),
    GetPage(name: photoGalleryView, page: () => PhotoGalleryViewScreen()),
    GetPage(name: teacherMain, page: () => TeacherMainScreen()),
    GetPage(name: ownProfile, page: () => OwnProfileScreen()),
    GetPage(name: assignHomeWork, page: () => AssignHomeWorkScreen()),
    GetPage(name: assignHomeWorkList, page: () => AssignHomeWorkListScreen()),
    GetPage(name: addCircular, page: () => AddCircularScreen()),
    GetPage(name: circularList, page: () => CircularListScreen()),
    GetPage(name: takeAttendance, page: () => TakeAttendanceScreen()),
    GetPage(
        name: replyParentCommunication,
        page: () => ReplyParentCommunicationScreen()),
    GetPage(name: studentProfileList, page: () => StudentProfileListScreen()),
    GetPage(
        name: studentProfileListDetail,
        page: () => StudentProfileListDetailScreen()),
    GetPage(name: sendNotification, page: () => SendNotificationScreen()),
    GetPage(name: teacherTimetable, page: () => TeacherTimetableScreen()),
    GetPage(name: approveStudentLeave, page: () => ApproveStudentLeaveScreen()),
    GetPage(name: testQnA, page: () => TestQnAScreen()),
    GetPage(name: testReport, page: () => TestReportScreen()),
    GetPage(name: testReportList, page: () => TestReportListScreen()),
    GetPage(name: testResult, page: () => TestResultScreen()),
    GetPage(name: zoomPhoto, page: () => ZoomPhotoScreen()),
    GetPage(name: tzoomPhoto, page: () => TeacherZoomPhotoScreen()),
    GetPage(name: studentDiscipline, page: () => StudentDisciplineScreen()),
    GetPage(name: healthDetails, page: () => HealthDetailsScreen()),
    GetPage(name: holidayList, page: () => HolidayListScreen()),
    GetPage(name: feesDetails, page: () => FeesDetailsScreen()),
    GetPage(name: wrtProgressReport, page: () => WRTProgressReportScreen()),
    GetPage(name: certificate, page: () => CertificateScreen()),
    GetPage(name: transport, page: () => TransportScreen()),
    GetPage(name: gallary, page: () => GallaryScreen()),
    GetPage(name: addPhotoVideo, page: () => AddPhotoVideoScreen()),
    GetPage(name: tPhotos, page: () => PhotoScreen()),
    GetPage(name: tVideos, page: () => const VideoScreen()),
    GetPage(name: tStudentDisclipline, page: () => TStudentDiscliplineScreen()),
    GetPage(name: webView, page: () => WebViewScreen()),
    GetPage(name: youtubeVideoPlayer, page: () => YoutubeVideoPlayer()),
    GetPage(name: videoPlayer, page: () => VideoPlayerScreen()),
    GetPage(name: hostel, page: () => HostelScreen()),
    GetPage(name: infirmary, page: () => InfirmaryScreen()),
    GetPage(name: vaccination, page: () => VaccinationScreen()),
    GetPage(name: heightWeight, page: () => HeightWeightScreen()),
    GetPage(name: consent, page: () => ConsentScreen()),
    GetPage(name: resultsPDF, page: () => ResultsPDFScreen()),
    GetPage(name: examSchedule, page: () => ExamScheduleScreen()),
    GetPage(name: academicCalendar, page: () => AcademicCalendarScreen()),
    GetPage(name: tProxy, page: () => TProxyManagementScreen()),
    GetPage(name: tWRTProgress, page: () => TWRTProgressReportScreen()),
    GetPage(name: aboutUs, page: () => AboutUsScreen()),
    GetPage(name: principalDesk, page: () => PrincipalDeskScreen()),
    GetPage(name: schoolInformation, page: () => SchoolInformationScreen()),
    GetPage(name: achievement, page: () => AchievementScreen()),
    GetPage(name: schoolTiming, page: () => SchoolTimingScreen()),
    GetPage(name: rules, page: () => RuleScreen()),
    GetPage(name: facility, page: () => FacilityScreen()),
    GetPage(name: acadamicActivity, page: () => AcadamicActivityScreen()),
    GetPage(name: reachUs, page: () => ReachUsScreen()),
    GetPage(name: portfolio, page: () => PortfolioScreen()),
    GetPage(name: leaderboard, page: () => LeaderboardScreen()),
    GetPage(name: socialCollabrative, page: () => SocialCollabrativeScreen()),
    GetPage(name: virtualClassroom, page: () => VirtualClassroomScreen()),
    GetPage(
        name: studentFaceAttendance, page: () => StudentFaceAttendanceScreen()),
    GetPage(name: tMessage, page: () => TMessageScreen()),
    GetPage(name: tExamSchedule, page: () => TeacherExamScheduleScreen()),
    GetPage(name: tCalander, page: () => TeacherCalanderScreen()),
    GetPage(name: addExam, page: () => AddExamScreen()),
    GetPage(name: task, page: () => TaskScreen()),
    GetPage(name: addTask, page: () => AddTaskScreen()),
    GetPage(name: tRequisition, page: () => InventoryRequisitionScreen()),
    GetPage(name: addRequisition, page: () => AddRequisitionScreen()),
    GetPage(name: tComplain, page: () => TeacherComplainScreen()),
    GetPage(name: addComplain, page: () => AddComplainScreen()),
    GetPage(name: teacherVisitor, page: () => TeacherVisitorScreen()),
    GetPage(name: addVisitor, page: () => AddVisitorScreen()),
    GetPage(name: sendSMS, page: () => SendSMSScreen()),
    GetPage(name: sendEmail, page: () => SendEmailScreen()),
    GetPage(name: adminMain, page: () => AdminMainScreen()),
    GetPage(name: adminAssignHomeWork, page: () => AdminAssignHomeWorkScreen()),
    GetPage(name: adminAddCircular, page: () => AdminAddCircularScreen()),
    GetPage(
        name: adminStudentProfileList,
        page: () => AdminStudentProfileListScreen()),
    GetPage(
        name: adminStudentDiscipline,
        page: () => AdminStudentDiscliplineScreen()),
    GetPage(name: adminSendSMS, page: () => AdminSendSMSScreen()),
    GetPage(
        name: adminSendNotification, page: () => AdminSendNotificationScreen()),
    GetPage(name: adminSendEmail, page: () => AdminSendEmailScreen()),
    GetPage(
        name: adminApproveLeave, page: () => AdminApproveStudentLeaveScreen()),
    GetPage(name: adminAddPhotos, page: () => AdminAddPhotoVideoScreen()),
    GetPage(name: adminTeacherProfile, page: () => AdminTeacherProfileScreen()),
    GetPage(name: teacherProfile, page: () => TeacherProfileScreen()),
    GetPage(name: teach, page: () => TeachScreen()),
    GetPage(name: teachSubject, page: () => TeachSubjectScreen()),
    GetPage(name: tLMSChapteDetail, page: () => TeacherLMSChapteDetailScreen()),
    GetPage(
        name: tVirtualClassroom, page: () => TeacherVirtualClassroomScreen()),
    GetPage(name: teacherResource, page: () => TeacherResourceScreen()),
    GetPage(name: lessonPlanning, page: () => LessonPlanningScreen()),
    GetPage(
        name: tsocialCollobrative,
        page: () => TeacherSocialCollobrativeScreen()),
    GetPage(name: adminCapturePhotos, page: () => AdminCapturePhotoScreen()),
    GetPage(
        name: studentAttendancePhoto,
        page: () => StudentAttendancePhotoScreen()),
    GetPage(name: adminOwnProfile, page: () => AdminOwnProfileScreen()),
    GetPage(
        name: adminCaptureAttendance,
        page: () => AdminCaptureAttendanceScreen()),
    GetPage(name: tmarks, page: () => TeacherMarkScreen()),
    GetPage(name: marksEntryResult, page: () => MarksEntryResultScreen()),
    GetPage(name: teacherCapturePhoto, page: () => TeacherCapturePhotoScreen()),
    GetPage(
        name: teacherNotificationReport,
        page: () => TeacherNotificationReportScreen()),
    GetPage(name: adminOutward, page: () => AdminOutwardScreen()),
    GetPage(name: addAdminOutward, page: () => AddAdminOutwardScreen()),
    GetPage(name: adminInward, page: () => AdminInwardScreen()),
    GetPage(name: addAdminInward, page: () => AddAdminInwardScreen()),
    GetPage(
        name: admissionConfirmation, page: () => AdmissionConfirmationScreen()),
    GetPage(
        name: createAdmissionConfirmation,
        page: () => CreateAdmissionConfirmationScreen()),
    GetPage(name: admissionEnquiry, page: () => AdmissionEnquiryScreen()),
    GetPage(
        name: admissionRegistration, page: () => AdmissionRegistrationScreen()),
    GetPage(
        name: createAdmissionRegistration,
        page: () => CreateAdmissionRegistrationScreen()),
    GetPage(
        name: createAdmissionEnquiry,
        page: () => CreateAdmissionEnquiryScreen()),
    GetPage(
        name: achievementCertificate,
        page: () => AchievementCertificateScreen()),
    GetPage(name: pal, page: () => PalScreen()),
    GetPage(name: chapter, page: () => ChapterScreen()),
    GetPage(name: feesCollect, page: () => FeesCollectScreen()),
    GetPage(name: feesCollectDetails, page: () => FeesCollectDetailsScreen()),
    GetPage(name: onlineReceptView, page: () => const OnlineReceiptView()),
    GetPage(name: myLeave, page: () => MyLeaveScreen()),
    GetPage(name: leaveHistory, page: () => LeaveHistoryScreen()),
    GetPage(name: myAttendance, page: () => MyAttendanceScreen()),
    GetPage(name: leaveRequests, page: () => LeaveRequestsScreen()),
    GetPage(
        name: leaveRequestsDetails, page: () => LeaveRequestsDetailsScreen()),
    GetPage(name: applyLeave, page: () => ApplyLeaveScreen()),
    GetPage(name: punchInOut, page: () => PunchInOutScreen()),
    GetPage(name: classworkGallery, page: () => ClassworkGalleryScreen()),
  ];
}
