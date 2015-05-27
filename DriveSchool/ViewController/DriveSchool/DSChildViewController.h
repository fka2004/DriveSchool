//
//  DSChildViewController.h
//  ChildViewDemo
//
//  Created by 张学成 on 15/4/3.
//  Copyright (c) 2015年 张学成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSQuestionModel.h"
@protocol DSChildViewDelegate;
@interface DSChildViewController : UIViewController
@property (weak, nonatomic) id<DSChildViewDelegate> delegate;
@property (assign, nonatomic) NSInteger index;              //题目的index
@property (assign, nonatomic) NSInteger leftOrRight;        //0:点击左侧    1:点击右侧
-(instancetype)initWithType: (NSInteger)type info:(NSMutableDictionary *)infoDic;
-(instancetype)initWithQuestion:(DSQuestionModel *)question status:(NSDictionary *)status;
@end
@protocol DSChildViewDelegate <NSObject>

//点击界面
-(void)tapView:(NSInteger)leftOrRight;
-(void)tapViewWithVC:(UIViewController *)vc;
-(void)tapAnswerView:(UIGestureRecognizer *)gesture;
-(void)tellRightOrError:(BOOL) right selectAnswer:(NSString *)answer question:(DSQuestionModel *)question;                   //返回答题结果  yes:正确    no:错误       如果错误则要返回选择的错误选项



@end