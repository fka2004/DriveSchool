//
//  DSMainSubjectViewController.m
//  DriveSchool
//
//  Created by 张学成 on 15/3/3.
//  Copyright (c) 2015年 张学成. All rights reserved.
//

#import "DSMainSubjectViewController.h"
#import "DSNewSubjectTwoViewController.h"
#import "DSNewSubjectOneViewController.h"
#import "SCNavTabBarController.h"

@interface DSMainSubjectViewController ()

@end

@implementation DSMainSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDefaultValue];
    [self setSubjectViews];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.title = @"预约";

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}
-(void)setDefaultValue{
    
    
}
-(void)setSubjectViews{
    //如果不设置看不到科目一,科目二的选择栏,但是选择了其他页面会自动往下走一点
    self.navigationController.navigationBar.translucent = NO;

    
//    UIViewController *subjectOne = [self getViewControllerFromStoryBoard:@"DSNewSubjectOneViewController"];
//    subjectOne.title = @"科目一";
    
    UIViewController *subjectTwo = [self getViewControllerFromStoryBoard:@"DSNewSubjectTwoViewController"];
    subjectTwo.title = @"科目二";
    
    UIViewController *subjectThree = [self getViewControllerFromStoryBoard:@"DSNewSubjectThreeViewController"];
    subjectThree.title = @"科目三";
    
//    UIViewController *subjectFour = [self getViewControllerFromStoryBoard:@"DSNewSubjectFourViewController"];
//    subjectFour.title = @"科目四";
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
//    NSMutableArray *array = [[NSMutableArray alloc]init];
//    for (int i; i<5; i++) {
//        [array addObject:subjectOne];
//        i++;
//    }
//    navTabBarController.subViewControllers = @[subjectOne, subjectTwo,subjectThree,subjectFour];
    navTabBarController.subViewControllers = @[subjectTwo,subjectThree];
//    navTabBarController.subViewControllers = [[NSArray alloc]initWithArray:array];
    navTabBarController.navTabBarColor = [UIColor whiteColor];
//        navTabBarController.showArrowButton = YES;
    [navTabBarController addParentController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
