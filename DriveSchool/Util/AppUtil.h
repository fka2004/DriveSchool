//
//  AppUtil.h
//  puke
//
//  Created by zxc on 14-7-25.
//  Copyright (c) 2014年 Bitbao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUtil : NSObject
+(UIImage *)interceptScreen:(UIView *)view;
+(UIImage *)interceptScreen:(UIView *)view imageSize:(CGSize)size;
+(void)takePhoto:(UIViewController *)vc;
+(void)pickPhotoFromAlbum:(UIViewController *)vc;
+(UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
+(BOOL)isMobileNumber:(NSString *)mobileNum;
+(BOOL)validateIdentityCard: (NSString *)identityCard;
+(BOOL)validateEmail:(NSString *)email;
+(UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;
+(NSString *)getAppVersionInfo;
+(BOOL)checkIdentityCardNo:(NSString*)cardNo;
+(int)getColorWithCalorie:(NSString *)type withCalorie:(int)calorie;
+(double)computeCalorie:(int)sex weight:(double)weight height:(double)height age:(int)age;
+ (NSInteger)dayCount:(NSInteger)years month:(NSInteger)month;
+(NSString *)getWeek:(NSDate *)date;
+ (UIImage *)imageWithMaxSide:(CGFloat)length sourceImage:(UIImage *)image;
+ (UIImage *)TelescopicImageToSize:(CGSize) size image:(UIImage *)image;
+ (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;
+(UIViewController *)getViewController:(UIView *)view;
+(NSString *)getTime:(NSDate *)date;
+(NSDictionary *)parameterToJson:(NSDictionary *)parameter;
@end
