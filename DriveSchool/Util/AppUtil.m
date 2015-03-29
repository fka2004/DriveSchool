//
//  AppUtil.m
//  puke
//
//  Created by zxc on 14-7-25.
//  Copyright (c) 2014年 Bitbao. All rights reserved.
//

#import "AppUtil.h"
#import <Accelerate/Accelerate.h>
@implementation AppUtil
/**
 *  截取当前屏幕
 *
 *  @param view <#view description#>
 *
 *  @return <#return value description#>
 */
+(UIImage *)interceptScreen:(UIView *)view{
    UIGraphicsBeginImageContext(CGSizeMake(320, 320));     //currentView 当前的view  创建一个基于位图的图形上下文并指定大小为
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];//renderInContext呈现接受者及其子范围到指定的上下文
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();//返回一个基于当前图形上下文的图片
    UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文
//    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);//然后将该图片保存到图片图
    return viewImage;
}
+(UIImage *)interceptScreen:(UIView *)view imageSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);     //currentView 当前的view  创建一个基于位图的图形上下文并指定大小为
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];//renderInContext呈现接受者及其子范围到指定的上下文
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();//返回一个基于当前图形上下文的图片
    UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文
//    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);//然后将该图片保存到图片图
    return viewImage;
}
/**
 *  打开相机
 *
 *  @param vc <#vc description#>
 */
+(void)takePhoto:(UIViewController *)vc{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = vc;
        
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        
        [vc presentViewController:picker animated:YES completion:nil];
    }
}
/**
 *  从相册选择相片
 */
+(void)pickPhotoFromAlbum:(UIViewController *)vc{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = vc;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [vc presentViewController:picker animated:YES completion:nil];
}
/**
 *  压缩图片
 *
 *  @param image   <#image description#>
 *  @param newSize <#newSize description#>
 *
 *  @return <#return value description#>
 */
+(UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    //Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;

}
//检测是否是手机号码
+(BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-9]|4[0-9]|8[0-9])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
//判断是否合法邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//验证身份证
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    if (identityCard.length <= 0) {
        return NO;
    }
    //NSString *regex2 = @"^(//d{14}|//d{17})(//d|[xX])$";
    NSString *regex2 =@"(^\\d{18}$)|(^\\d{17}(\\d|X|x)$)";
    //NSString *regex2 = @"^(//d{17})(//d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    if ([identityCardPredicate evaluateWithObject:identityCard] == YES){
        return  YES;
    }else{
        return NO;
    }
    
}



/**
 
 * 功能:获取指定范围的字符串
 
 * 参数:字符串的开始小标
 
 * 参数:字符串的结束下标
 
 */

+(NSString *)getStringWithRange:(NSString *)str Value1:(NSInteger *)value1 Value2:(NSInteger )value2;

{
    
    return [str substringWithRange:NSMakeRange(value1,value2)];
    
}
//交验身份证号
+(BOOL)checkIdentityCardNo:(NSString*)sPaperId
{
    //判断位数
    
   
    if ([sPaperId length] != 15 && [sPaperId length] != 18) {
        
        return NO;
        
    }
    
    NSString *carid = sPaperId;
    
    long lSumQT =0;
    
    //加权因子
    
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    
    //校验码
    
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    
    
    //将15位身份证号转换成18位
    
    NSMutableString *mString = [NSMutableString stringWithString:sPaperId];
    
    if ([sPaperId length] == 15) {
        
        [mString insertString:@"19" atIndex:6];
        
        long p = 0;
        
        const char *pid = [mString UTF8String];
        
        for (int i=0; i<=16; i++)
            
        {
            
            p += (pid[i]-48) * R[i];
            
        }
        
        int o = p%11;
        
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        
        [mString insertString:string_content atIndex:[mString length]];
        
        carid = mString;
        
    }
    
    //判断地区码
    
//    NSString * sProvince = [carid substringToIndex:2];
//    
//    if (![self areaCode:sProvince]) {
//        
//        return NO;
//        
//    }
    
    //判断年月日是否有效
    
    
    
    //年份
    
    int strYear = [[self getStringWithRange:carid Value1:6 Value2:4] intValue];
    
    //月份
    
    int strMonth = [[self getStringWithRange:carid Value1:10 Value2:2] intValue];
    
    //日
    
    int strDay = [[self getStringWithRange:carid Value1:12 Value2:2] intValue];
    
    
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    [dateFormatter setTimeZone:localZone];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    
    if (date == nil) {
        
        return NO;
        
    }
    
    const char *PaperId  = [carid UTF8String];
    
    //检验长度
    
    if( 18 != strlen(PaperId)) return -1;
    
    
    
    //校验数字
    
    for (int i=0; i<18; i++)
        
    {
        
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) )
            
        {
            
            return NO;
            
        }
        
    }
    
    //验证最末的校验码
    
    for (int i=0; i<=16; i++)
        
    {
        
        lSumQT += (PaperId[i]-48) * R[i];
        
    }
    
    if (sChecker[lSumQT%11] != PaperId[17] )
        
    {
        
        return NO;
        
    }
    
    return YES;
}
/**
 
 * 功能:判断是否在地区码内
 
 * 参数:地区码
 
 */
-(BOOL)areaCode:(NSString *)code

{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:@"北京" forKey:@"11"];
    
    [dic setObject:@"天津" forKey:@"12"];
    
    [dic setObject:@"河北" forKey:@"13"];
    
    [dic setObject:@"山西" forKey:@"14"];
    
    [dic setObject:@"内蒙古" forKey:@"15"];
    
    [dic setObject:@"辽宁" forKey:@"21"];
    
    [dic setObject:@"吉林" forKey:@"22"];
    
    [dic setObject:@"黑龙江" forKey:@"23"];
    
    [dic setObject:@"上海" forKey:@"31"];
    
    [dic setObject:@"江苏" forKey:@"32"];
    
    [dic setObject:@"浙江" forKey:@"33"];
    
    [dic setObject:@"安徽" forKey:@"34"];
    
    [dic setObject:@"福建" forKey:@"35"];
    
    [dic setObject:@"江西" forKey:@"36"];
    
    [dic setObject:@"山东" forKey:@"37"];
    
    [dic setObject:@"河南" forKey:@"41"];
    
    [dic setObject:@"湖北" forKey:@"42"];
    
    [dic setObject:@"湖南" forKey:@"43"];
    
    [dic setObject:@"广东" forKey:@"44"];
    
    [dic setObject:@"广西" forKey:@"45"];
    
    [dic setObject:@"海南" forKey:@"46"];
    
    [dic setObject:@"重庆" forKey:@"50"];
    
    [dic setObject:@"四川" forKey:@"51"];
    
    [dic setObject:@"贵州" forKey:@"52"];
    
    [dic setObject:@"云南" forKey:@"53"];
    
    [dic setObject:@"西藏" forKey:@"54"];
    
    [dic setObject:@"陕西" forKey:@"61"];
    
    [dic setObject:@"甘肃" forKey:@"62"];
    
    [dic setObject:@"青海" forKey:@"63"];
    
    [dic setObject:@"宁夏" forKey:@"64"];
    
    [dic setObject:@"新疆" forKey:@"65"];
    
    [dic setObject:@"台湾" forKey:@"71"];
    
    [dic setObject:@"香港" forKey:@"81"];
    
    [dic setObject:@"澳门" forKey:@"82"];
    
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:code] == nil) {
        
        return NO;
        
    }
    
    return YES;
    
}
//根据卡路里显示不同颜色 since1.6.0
+(int)getColorWithCalorie:(NSString *)type withCalorie:(int)calorie{
    //由淡到深
//    int color_1 =0xdfe5ee;
//    int color_2 =0xaebcd1;
//    int color_3 =0x6580a5;
//    int color_4 =0x445a77;
//    int color_5 =0x304158;
    
    int color_1 =1;
    int color_2 =2;
    int color_3 =3;
    int color_4 =4;
    int color_5 =5;
    
    if (type&&[type isEqualToString:@"day"]) {
        
        if (calorie<=200) {
            return color_1;
        }else if (calorie>200&&calorie<=350) {
            return color_2;
        }else if (calorie>350&&calorie<=600) {
            return color_3;
        }else if (calorie>600&&calorie<=800) {
            return color_4;
        }else if (calorie>800) {
            return color_5;
        }
        
    }else if (type&&[type isEqualToString:@"week"]) {
        
        if (calorie<=600) {
            return color_1;
        }else if (calorie>600&&calorie<=1050) {
            return color_2;
        }else if (calorie>1050&&calorie<=1800) {
            return color_3;
        }else if (calorie>1800&&calorie<=2400) {
            return color_4;
        }else if (calorie>2400) {
            return color_5;
        }

        
    }else if (type&&[type isEqualToString:@"month"]) {
        
        if (calorie<=2400) {
            return color_1;
        }else if (calorie>2400&&calorie<=4200) {
            return color_2;
        }else if (calorie>4200&&calorie<=7200) {
            return color_3;
        }else if (calorie>7200&&calorie<=9600) {
            return color_4;
        }else if (calorie>9600) {
            return color_5;
        }

        
    }else if (type&&[type isEqualToString:@"year"]) {
        
        if (calorie<=28800) {
            return color_1;
        }else if (calorie>28000&&calorie<=50400) {
            return color_2;
        }else if (calorie>50400&&calorie<=86400) {
            return color_3;
        }else if (calorie>86400&&calorie<=115200) {
            return color_4;
        }else if (calorie>115200) {
            return color_5;
        }

    }
    
    
    return color_1;
}

+ (NSInteger)dayCount:(NSInteger)years month:(NSInteger)month
{
    NSInteger count = 0;
    for (int i = 1; i <= 12; i++) {
        if (2 == i) {
            if((years % 4 == 0 && years % 100!=0) || years % 400 == 0) //是闰年
            {
                count = 29;
            }
            else
            {
                count = 28;
            }
            
        }else if (4 == i || 6 == i || 9 == i || 11 == i){
            count = 30;
        }else{
            count = 31;
        }
        if(month == i){
            return count;
        }
    }
    return count;
}
+(NSString *)getWeek:(NSDate *)date{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    NSInteger unitFlags = NSWeekdayCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    return [self getWeekByWeekDay:[comps weekday]];
}
//获得时间(时分秒)
+(NSString *)getTime:(NSDate *)date{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    NSInteger unitFlags = NSWeekdayCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger hour = [comps hour];
    NSString *hourStr;
    if(hour<10){
        hourStr = [[NSString alloc]initWithFormat:@"0%li",(long)hour];
    }else{
        hourStr = [[NSString alloc]initWithFormat:@"%li",(long)hour];
    }
    NSInteger min = [comps minute];
    NSString *minStr;
    if(min<10){
        minStr = [[NSString alloc]initWithFormat:@"0%li",(long)min];
    }else{
        minStr = [[NSString alloc]initWithFormat:@"%li",(long)min];
    }
    NSInteger sec = [comps second];
    NSString *secStr;
    if(sec<10){
        secStr = [[NSString alloc]initWithFormat:@"0%li",(long)sec];
    }else{
        secStr = [[NSString alloc]initWithFormat:@"%li",(long)sec];
    }
    NSString *time = [[NSString alloc]initWithFormat:@"%@:%@:%@",hourStr,minStr,secStr];
    return time;
}
enum{
    SUN = 1,
    MON,
    TEUS,
    WED,
    THUR,
    FRI,
    SAT,
};
+ (NSString *)getWeekByWeekDay:(NSInteger)weekday{
    BTLog(@"%d",0x01<<weekday);
    switch (weekday) {
        case SUN:
            return @"星期日";
            break;
        case MON:
            return @"星期一";
            break;
        case TEUS:
            return @"星期二";
            break;
        case WED:
            return @"星期三";
            break;
        case THUR:
            return @"星期四";
            break;
        case FRI:
            return @"星期五";
            break;
        case SAT:
            return @"星期六";
            break;
        default:
            break;
    }
    return Nil;
}

+(void)openURL{

}
+ (UIImage *)imageWithMaxSide:(CGFloat)length sourceImage:(UIImage *)image
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGSize imgSize = CWSizeReduce(image.size, length);
    UIImage *img = nil;
    
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, scale);  // 创建一个 bitmap context
    
    [image drawInRect:CGRectMake(0, 0, imgSize.width, imgSize.height)
            blendMode:kCGBlendModeNormal alpha:1.0];              // 将图片绘制到当前的 context 上
    
    img = UIGraphicsGetImageFromCurrentImageContext();            // 从当前 context 中获取刚绘制的图片
    UIGraphicsEndImageContext();
    
    return img;
}

static inline
CGSize CWSizeReduce(CGSize size, CGFloat limit)   // 按比例减少尺寸
{
    CGFloat max = MAX(size.width, size.height);
    if (max < limit) {
        return size;
    }
    
    CGSize imgSize;
    CGFloat ratio = size.height / size.width;
    
    if (size.width > size.height) {
        imgSize = CGSizeMake(limit, limit*ratio);
    } else {
        imgSize = CGSizeMake(limit/ratio, limit);
    }
    
    return imgSize;
}
+(UIImage *)TelescopicImageToSize:(CGSize) size image:(UIImage *)image

{
    
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}
//计算文字高度
+ (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
}
//返回view所在viewcontroller
+(UIViewController *)getViewController:(UIView *)view{
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
//版本信息，设置在request.header和登录请求中
+(NSString *)getAppVersionInfo{
    
    NSString *outdoorversion = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    NSString *indoorversion = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleVersion"];
    NSString *app_version=[NSString stringWithFormat:@"ios-%@(%@)-%@",outdoorversion,indoorversion,kAPP_VERSION_INFO];
    return app_version;
}
+(NSDictionary *)parameterToJson:(NSDictionary *)parameter{
    NSMutableString *paramsStr = [[NSMutableString alloc]initWithString:@"{"];
    for (NSString *key in parameter.allKeys) {
        [paramsStr appendString:@"\""];
        [paramsStr appendString:key];
        [paramsStr appendString:@"\":\""];
        [paramsStr appendString:[parameter objectForKey:key]];
        [paramsStr appendString:@"\","];
        
    }
    paramsStr = [[NSMutableString alloc]initWithString:[paramsStr substringToIndex:paramsStr.length-1]];
    [paramsStr appendString:@"}"];
    NSDictionary *dic = @{@"data":paramsStr};
    
    return dic;
}
@end
