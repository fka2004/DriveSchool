//
//  env_dev.h
//  puke
//
//  Created by Bitbao on 14-6-11.
//  Copyright (c) 2014年 Bitbao. All rights reserved.
//

#ifndef puke_env_dev_h
#define puke_env_dev_h


//##API 地址配置
//static NSString * const kAPI_BASE_URL = @"http://10.32.0.58:8888";


//开发联调地址
//static NSString * const kAPI_BASE_URL = @"http://10.63.255.22:8080";
//测试地址
//static NSString * const kAPI_BASE_URL = @"http://localhost:8081/driving-school-test/servlet";

static NSString * const kAPI_BASE_URL = @"http://182.92.219.53:8080";
//大飞机器
//static NSString * const kAPI_BASE_URL = @"http://192.168.1.106:8080";


//企业版生产地址
//static NSString * const kAPI_BASE_URL = @"http://apibak.yundong.runnerbar.com";
//appstore版生产地址
//static NSString * const kAPI_BASE_URL = @"http://api.yundong.runnerbar.com";

//推送消息地址

//##API 地址配置
//static NSString * const kAPI_BASE_TWO_URL = @"http://10.32.0.58:8888";
//开发联调地址
//static NSString * const kAPI_BASE_TWO_URL = @"http://10.63.255.22:9080";
//测试地址
static NSString * const kAPI_BASE_TWO_URL = @"http://182.92.219.53:8080";

//static NSString * const kAPI_BASE_TWO_URL = @"http://192.168.1.106:8080";
//企业版生产地址
//static NSString * const kAPI_BASE_TWO_URL = @"http://pushbak.yundong.runnerbar.com";
//appstore版生产地址
//static NSString * const kAPI_BASE_TWO_URL = @"http://push.yundong.runnerbar.com";

//新闻获取url
static  NSString * kAPP_GET_NEWS = @"http://182.92.219.53:8080/driving-school-web/app/getNews.action?id=";

//新版本API
static  NSString * kAPP_VERSION_INFO = @"Fir.im 内测版";
//登录测试
static NSString * const kAPI_TEST_LOGIN = @"/driving-school-web/app/login";
//首页接口
static NSString * const kAPI_GET_MAIN = @"/driving-school-web/app/index";
//找驾校
static NSString * const kAPI_GET_SCHOOL = @"/driving-school-web/app/findDrivingSchool";
//找驾校具体信息
static NSString * const kAPI_GET_SCHOOL_DETAIL = @"/driving-school-web/app/queryDrivingSchool";
//找教练
static NSString * const kAPI_GET_TEACHER = @"/driving-school-web/app/findTeacher";
//获取教练具体信息
static NSString * const kAPI_GET_TEACHER_DETAIL = @"/driving-school-web/app/queryTeacher";

//科目获取教练接口
static NSString * const kAPI_GET_SUBJECT_TEACHER = @"/driving-school-web/app/findTeacher";
//获取预约天数以及第一天的数据
static NSString * const kAPI_GET_SUBJECT_DAYS = @"/driving-school-web/app/getAppointmentDays";


//获取教练可预约时间接口
static NSString * const kAPI_GET_SUBJECT_BOOKING= @"/driving-school-web/app/getAppointmentTime";
//预约练车
static NSString * const kAPI_GET_SUBJECT_APPLYLEARN= @"/driving-school-web/app/applyLearn";
//预约练车
static NSString * const kAPI_UPDATE_CANCEL_SUBJECT_APPLYLEARN= @"/driving-school-web/app/cancelApplyLearn";

//获取开通城市
static NSString * const kAPI_GET_CITYS= @"/driving-school-web/app/getOpenDistrict";
//创建匿名用户和教练登录
static NSString * const kAPI_UPDATE_USER= @"/driving-school-web/app/login";
//获取验证码
static NSString * const kAPI_GET_CODE= @"/driving-school-web/app/getRandomCode";
//注册接口
static NSString * const kAPI_UPDATE_REGIST= @"/driving-school-web/app/regist";
//找回密码接口
static NSString * const kAPI_UPDATE_FINDPWD= @"/driving-school-web/app/findPassword";
//绑定驾校
static NSString * const kAPI_UPDATE_BIND= @"/driving-school-web/app/bindDrivingSchool";
//修改教练密码
static NSString * const kAPI_UPDATE_TEACHER_PWD= @"/driving-school-web/app/updatePassword";

//获取教练考勤的日期接口
static NSString * const kAPI_GET_SCHEDULE = @"/driving-school-web/app/getScheduleDays";
//获取教练考勤接口
static NSString * const kAPI_GET_SCHEDULES= @"/driving-school-web/app/getSchedule";
//教练请假接口
static NSString * const kAPI_UPDATE_LEAVE= @"/driving-school-web/app/askLeave";
//教练取消请假接口
static NSString * const kAPI_UPDATE_CANCEL_LEAVE= @"/driving-school-web/app/cancelAskLeave";
#endif
