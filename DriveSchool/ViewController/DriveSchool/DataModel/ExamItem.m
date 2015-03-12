//
//  ExamItem.m
//  DriveSchool
//
//  Created by apple on 15/3/10.
//  Copyright (c) 2015年 张学成. All rights reserved.
//

#import "ExamItem.h"

@implementation ExamItem
@synthesize uid=_uid;
@synthesize count=_count;
@synthesize type=_type;
@synthesize carType=_carType;
@synthesize answer=_answer;
@synthesize answerA=_answerA;
@synthesize answerB=_answerB;
@synthesize answerC=_answerC;
@synthesize answerD=_answerD;
@synthesize image=_image;
@synthesize explain=_explain;
@synthesize isError=_isError;
@synthesize isCollect=_isCollect;
@synthesize isDebar=_isDebar;




-(id)initWithDictionary:(NSDictionary *)dict
{
    self=[super init];
    if (self) {
      
        
        NSLog(@"%@",dict);

        self.uid=[dict objectForKey:@"id"];
        self.count=[dict objectForKey:@"count"];
        self.type=[dict objectForKey:@"type"];
        self.carType=[dict objectForKey:@"carType"];
        self.answer=[dict objectForKey:@"answer"];
        self.answerA=[dict objectForKey:@"answerA"];
        self.answerB=[dict objectForKey:@"answerB"];
        self.answerC=[dict objectForKey:@"answerC"];
        self.answerD=[dict objectForKey:@"answerD"];
        self.image=[dict objectForKey:@"image"];
        self.explain=[dict objectForKey:@"explain"];
        self.isError=[dict objectForKey:@"isError"];
        self.isCollect=[dict objectForKey:@"isCollect"];
        self.isDebar=[dict objectForKey:@"isDebar"];
        
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super init];
    if (self) {

        self.uid=[aDecoder decodeObjectForKey:@"id"];
        self.count=[aDecoder decodeObjectForKey:@"count"];
        self.type=[aDecoder decodeObjectForKey:@"type"];
        self.carType=[aDecoder decodeObjectForKey:@"carType"];
        self.answer=[aDecoder decodeObjectForKey:@"answer"];
        self.answerA=[aDecoder decodeObjectForKey:@"answerA"];
        self.answerB=[aDecoder decodeObjectForKey:@"answerB"];
        self.answerC=[aDecoder decodeObjectForKey:@"answerC"];
        self.answerD=[aDecoder decodeObjectForKey:@"answerD"];
        self.image=[aDecoder decodeObjectForKey:@"image"];
        self.explain=[aDecoder decodeObjectForKey:@"explain"];
        self.isError=[aDecoder decodeObjectForKey:@"isError"];
        self.isCollect=[aDecoder decodeObjectForKey:@"isCollect"];
        self.isDebar=[aDecoder decodeObjectForKey:@"isDeabar"];
        
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.uid forKey:@"id"];
    [aCoder encodeObject:self.count forKey:@"count"];
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.carType forKey:@"carType"];
    [aCoder encodeObject:self.answer forKey:@"answer"];
    [aCoder encodeObject:self.answerA forKey:@"answerA"];
    [aCoder encodeObject:self.answerB forKey:@"answerB"];
    [aCoder encodeObject:self.answerC forKey:@"answerC"];
    [aCoder encodeObject:self.answerD forKey:@"answerD"];
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeObject:self.isError forKey:@"isError"];
    [aCoder encodeObject:self.isCollect forKey:@"isCollect"];
    [aCoder encodeObject:self.explain forKey:@"explain"];
    [aCoder encodeObject:self.isDebar forKey:@"isDebar"];

}
@end
