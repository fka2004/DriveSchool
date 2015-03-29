//
//  UIImage+Additions.h
//  JuGeiLi
//
//  Created by kimziv on 13-11-1.
//  Copyright (c) 2013年 kimziv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Additions)
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithHexColor:(NSInteger)hexValue;
+ (UIImage *)separatorWithHexColor:(NSInteger)hexValue1  andHexColor:(NSInteger)hexValue2;
+(UIImage *)separatorInPostStep1;
+ (UIImage *)imageWithColor:(UIColor *)color view:(UIView *)view;

@end
