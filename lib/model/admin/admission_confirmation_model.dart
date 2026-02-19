class AdmissionConfirmationModel {
  String? message;
  List<AdmissionConfirmation>? data;
  String? status;

  AdmissionConfirmationModel({
    this.message,
    this.data,
    this.status,
  });

  factory AdmissionConfirmationModel.fromJson(Map<String, dynamic> json) =>
      AdmissionConfirmationModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<AdmissionConfirmation>.from(
                json["data"]!.map((x) => AdmissionConfirmation.fromJson(x))),
        status: json["status"],
      );
}

class AdmissionConfirmation {
  int? id;
  String? enquiryNo;
  String? firstName;
  String? middleName;
  String? lastName;
  String? gender;
  String? mobile;
  String? email;
  String? address;
  DateTime? dateOfBirth;
  int? age;
  int? syear;
  String? previousSchoolName;
  String? previousStandard;
  String? admissionStandard;
  String? remarks;
  DateTime? followupDate;
  String? sourceOfEnquiry;
  String? category;
  String? sendSms;
  String? smsMessage;
  DateTime? createdOn;
  int? createdBy;
  int? subInstituteId;
  dynamic previousDivision;
  dynamic mobile2;
  dynamic test;
  dynamic fatherName;
  dynamic motherTongue;
  dynamic religion;
  dynamic nationality;
  dynamic whetherBelongsTo;
  dynamic percentage;
  dynamic motherName;
  dynamic fatherQualification;
  dynamic fatherOccupation;
  dynamic motherQualification;
  dynamic motherOccupation;
  dynamic guardianName;
  dynamic councilerName;
  dynamic placeOfBirth;
  dynamic mobileNumberFather;
  dynamic mobileNumberMother;
  dynamic guardianRelation;
  dynamic annualIncome;
  dynamic houseNo;
  dynamic streetName;
  dynamic buildingName;
  dynamic districtName;
  dynamic pinCode;
  dynamic state;
  dynamic aadharcardNumber;
  dynamic buildingNameAppratmentNameSocietyName;
  dynamic admissionFees;
  dynamic receiptId;
  dynamic receiptHtml;
  dynamic feesAmount;
  dynamic feesRemark;
  dynamic feesCircularHtml;
  dynamic feesCircularFormNo;
  dynamic interactionDate;
  dynamic interactionRemarks;
  int? totalStudentCount;
  String? enquiryRemark;
  String? stdName;
  String? currentStatusColor;
  String? enquiryStatus;
  dynamic displayEnquiryStatus;
  String? enqColor;
  dynamic nextFollowUpDate;
  dynamic formNumber;
  String? todaysNextFollowup;

  AdmissionConfirmation({
    this.id,
    this.enquiryNo,
    this.firstName,
    this.middleName,
    this.lastName,
    this.gender,
    this.mobile,
    this.email,
    this.address,
    this.dateOfBirth,
    this.age,
    this.syear,
    this.previousSchoolName,
    this.previousStandard,
    this.admissionStandard,
    this.remarks,
    this.followupDate,
    this.sourceOfEnquiry,
    this.category,
    this.sendSms,
    this.smsMessage,
    this.createdOn,
    this.createdBy,
    this.subInstituteId,
    this.previousDivision,
    this.mobile2,
    this.test,
    this.fatherName,
    this.motherTongue,
    this.religion,
    this.nationality,
    this.whetherBelongsTo,
    this.percentage,
    this.motherName,
    this.fatherQualification,
    this.fatherOccupation,
    this.motherQualification,
    this.motherOccupation,
    this.guardianName,
    this.councilerName,
    this.placeOfBirth,
    this.mobileNumberFather,
    this.mobileNumberMother,
    this.guardianRelation,
    this.annualIncome,
    this.houseNo,
    this.streetName,
    this.buildingName,
    this.districtName,
    this.pinCode,
    this.state,
    this.aadharcardNumber,
    this.buildingNameAppratmentNameSocietyName,
    this.admissionFees,
    this.receiptId,
    this.receiptHtml,
    this.feesAmount,
    this.feesRemark,
    this.feesCircularHtml,
    this.feesCircularFormNo,
    this.interactionDate,
    this.interactionRemarks,
    this.totalStudentCount,
    this.enquiryRemark,
    this.stdName,
    this.currentStatusColor,
    this.enquiryStatus,
    this.displayEnquiryStatus,
    this.enqColor,
    this.nextFollowUpDate,
    this.formNumber,
    this.todaysNextFollowup,
  });

  factory AdmissionConfirmation.fromJson(Map<String, dynamic> json) =>
      AdmissionConfirmation(
        id: json["id"],
        enquiryNo: json["enquiry_no"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        mobile: json["mobile"],
        email: json["email"],
        address: json["address"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        age: json["age"],
        syear: json["syear"],
        previousSchoolName: json["previous_school_name"],
        previousStandard: json["previous_standard"],
        admissionStandard: json["admission_standard"].toString(),
        remarks: json["remarks"],
        followupDate: json["followup_date"] == null
            ? null
            : DateTime.parse(json["followup_date"]),
        sourceOfEnquiry: json["source_of_enquiry"],
        category: json["category"],
        sendSms: json["send_sms"],
        smsMessage: json["sms_message"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
        createdBy: json["created_by"],
        subInstituteId: json["sub_institute_id"],
        previousDivision: json["previous_division"],
        mobile2: json["mobile2"],
        test: json["test"],
        fatherName: json["father_name"],
        motherTongue: json["mother_tongue"],
        religion: json["religion"],
        nationality: json["nationality"],
        whetherBelongsTo: json["whether_belongs_to"],
        percentage: json["percentage"],
        motherName: json["mother_name"],
        fatherQualification: json["father_qualification"],
        fatherOccupation: json["father_occupation"],
        motherQualification: json["mother_qualification"],
        motherOccupation: json["mother_occupation"],
        guardianName: json["guardian_name"],
        councilerName: json["counciler_name"],
        placeOfBirth: json["place_of_birth"],
        mobileNumberFather: json["mobile_number_father"],
        mobileNumberMother: json["mobile_number_mother"],
        guardianRelation: json["guardian_relation"],
        annualIncome: json["annual_income"],
        houseNo: json["house_no"],
        streetName: json["street_name"],
        buildingName: json["building_name"],
        districtName: json["district_name"],
        pinCode: json["pin_code"],
        state: json["state"],
        aadharcardNumber: json["aadharcard_number"],
        buildingNameAppratmentNameSocietyName:
            json["building_name_appratment_name_society_name"],
        admissionFees: json["admission_fees"],
        receiptId: json["receipt_id"],
        receiptHtml: json["receipt_html"],
        feesAmount: json["fees_amount"],
        feesRemark: json["fees_remark"],
        feesCircularHtml: json["fees_circular_html"],
        feesCircularFormNo: json["fees_circular_form_no"],
        interactionDate: json["interaction_date"],
        interactionRemarks: json["interaction_remarks"],
        totalStudentCount: json["total_student_count"],
        enquiryRemark: json["enquiry_remark"],
        stdName: json["std_name"],
        enquiryStatus: json["enquiry_status"],
        displayEnquiryStatus: json["display_enquiry_status"],
        enqColor: json["enq_color"],
        nextFollowUpDate: json["next_follow_up_date"],
        formNumber: json["form_number"],
        todaysNextFollowup: json["todays_next_followup"],
        currentStatusColor: json["current_status_color"],
      );
}
