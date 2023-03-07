
import 'package:mrap7/local_storage/boxes.dart';



class All_SharePreference {
  Future<void> setLoginDataHiave(
    
      String cid, String userid, String password) async {
        final mydataBox=Boxes.allData();
    // final prefs = await SharedPreferences.getInstance();
    await mydataBox.put('CID', cid);
    await mydataBox.put('USER_ID', userid);
    await mydataBox.put('PASSWORD', password);
  }

  void setloginData() {}
  void setDmpathData() {}

//    sharedPreferencesGetDAta() async{
//  final prefs = await SharedPreferences.getInstance();
//  prefs.offer_flag =
//    }

//todo!           Device InFo

  // setDeviceInfo(String deviceId, deviceBrand, deviceModel) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('deviceId', deviceId);
  //   await prefs.setString('deviceBrand', deviceBrand!);
  //   await prefs.setString('deviceModel', deviceModel!);
  // }

  //todo!           DM Path

  setDMPathData(
      String sync_url,
      report_sales_url,
      report_dcr_url,
      report_rx_url,
      photo_submit_url,
      activity_log_url,
      client_outst_url,
      user_area_url,
      photo_url,
      leave_request_url,
      leave_report_url,
      plugin_url,
      tour_plan_url,
      tour_compliance_url,
      client_url,
      doctor_url,
      user_sales_coll_ach_url,
      os_details_url,
      ord_history_url,
      inv_history_url,
      client_edit_url,
      timer_track_url,
      exp_type_url,
      exp_submit_url,
      report_exp_url,
      report_outst_url,
      report_last_ord_url,
      report_last_inv_url,
      exp_approval_url,
      sync_notice_url,
      report_atten_url) async {
    // final prefs = await SharedPreferences.getInstance();
    final boxdata=Boxes.allData();
    await boxdata.put('sync_url', sync_url);
    // await boxdata.put('submit_url', submit_url);
    await boxdata.put('report_sales_url', report_sales_url);
    await boxdata.put('report_dcr_url', report_dcr_url);
    await boxdata.put('report_rx_url', report_rx_url);
    await boxdata.put('photo_submit_url', photo_submit_url);
    await boxdata.put('activity_log_url', activity_log_url);
    await boxdata.put('client_outst_url', client_outst_url);
    await boxdata.put('user_area_url', user_area_url);
    await boxdata.put('photo_url', photo_url);
    await boxdata.put('leave_request_url', leave_request_url);
    await boxdata.put('leave_report_url', leave_report_url);
    await boxdata.put('plugin_url', plugin_url);
    await boxdata.put('tour_plan_url', tour_plan_url);
    await boxdata.put('tour_compliance_url', tour_compliance_url);
    await boxdata.put('client_url', client_url);
    await boxdata.put('doctor_url', doctor_url);
    await boxdata.put('user_sales_coll_ach_url', user_sales_coll_ach_url);
    await boxdata.put('os_details_url', os_details_url);
    await boxdata.put('ord_history_url', ord_history_url);
    await boxdata.put('inv_history_url', inv_history_url);
    await boxdata.put('client_edit_url', client_edit_url);
    await boxdata.put('timer_track_url', timer_track_url);
    await boxdata.put('exp_type_url', exp_type_url);
    await boxdata.put('exp_submit_url', exp_submit_url);
    await boxdata.put('report_exp_url', report_exp_url);
    // await boxdata.put('report_exp_url', report_exp_url);
    await boxdata.put('report_outst_url', report_outst_url);
    await boxdata.put('report_last_ord_url', report_last_ord_url);
    await boxdata.put('report_last_inv_url', report_last_inv_url);
    await boxdata.put('exp_approval_url', exp_approval_url);
    await boxdata.put('sync_notice_url', sync_notice_url);
    await boxdata.put('report_atten_url', report_atten_url);
  }



 //todo!              Set LogIn DATA        >>>>>>>>>>>>>>>>    
 
  
setLogInData(bool userInfo,String userName,user_id,password,mobile_no,bool offer_flag,note_flag,client_edit_flag,os_show_flag,os_details_flag,ord_history_flag,inv_histroy_flag,client_flag,rx_doc_must,rx_type_must,rx_gallery_allow,order_flag,dcr_flag,timer_flag,rx_flag,others_flag,visit_plan_flag,plagin_flag,dcr_discussion,promo_flag,leave_flag,notice_flag,doc_flag,doc_edit_flag, List<String> dcr_visitedWithList, String meter_reading_last,rxTypeList)async{
  final boxdata=Boxes.allData();
        // await prefs.clear();
        await boxdata.put('areaPage', userInfo);
        await boxdata.put('userName', userName);
        await boxdata.put('user_id', user_id);
        await boxdata.put('PASSWORD', password);
        await boxdata.put('mobile_no', mobile_no);
        await boxdata.put('offer_flag', offer_flag);
        await boxdata.put('note_flag', note_flag!);
        await boxdata.put('client_edit_flag', client_edit_flag!);
        await boxdata.put('os_show_flag', os_show_flag!);
        await boxdata.put('os_details_flag', os_details_flag!);
        await boxdata.put('ord_history_flag', ord_history_flag!);
        await boxdata.put('inv_histroy_flag', inv_histroy_flag!);
        await boxdata.put('client_flag', client_flag);
        await boxdata.put('rx_doc_must', rx_doc_must!);
        await boxdata.put('rx_type_must', rx_type_must!);
        await boxdata.put('rx_gallery_allow', rx_gallery_allow!);
        await boxdata.put('order_flag', order_flag);
        await boxdata.put('dcr_flag', dcr_flag);
        await boxdata.put('timer_flag', timer_flag!);
        await boxdata.put('rx_flag', rx_flag);
        await boxdata.put('others_flag', others_flag);
        await boxdata.put('visit_plan_flag', visit_plan_flag);
        await boxdata.put('plagin_flag', plagin_flag);
        await boxdata.put('dcr_discussion', dcr_discussion);
        await boxdata.put('promo_flag', promo_flag);
        await boxdata.put('leave_flag', leave_flag);
        await boxdata.put('notice_flag', notice_flag);
        await boxdata.put('doc_flag', doc_flag);
        await boxdata.put('doc_edit_flag', doc_edit_flag);

        await boxdata.put('dcr_visit_with_list', dcr_visitedWithList);
        await boxdata.put('meter_reading_last', meter_reading_last);

        await boxdata.put('rx_type_list', rxTypeList);

}


}
