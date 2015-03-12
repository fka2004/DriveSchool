//
//  ExamItem.h
//  DriveSchool
//
//  Created by apple on 15/3/10.
//  Copyright (c) 2015年 张学成. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExamItem : NSObject
@property(nonatomic,strong)NSString*uid;
@property(nonatomic,strong)NSString*count;
@property(nonatomic,strong)NSString*type;
@property(nonatomic,strong)NSString*carType;
@property(nonatomic,strong)NSString*answer;
@property(nonatomic,strong)NSString*answerA;
@property(nonatomic,strong)NSString*answerB;
@property(nonatomic,strong)NSString*answerC;
@property(nonatomic,strong)NSString*answerD;
@property(nonatomic,strong)NSString*image;
@property(nonatomic,strong)NSString*explain;
@property(nonatomic,strong)NSString*isError;
@property(nonatomic,strong)NSString*isCollect;
@property(nonatomic,strong)NSString*isDebar;
-(void)encodeWithCoder:(NSCoder*)aCoder;
-(id)initWithCoder:(NSCoder*)aDecoder;
-(id)initWithDictionary:(NSDictionary *)dic;
@end
