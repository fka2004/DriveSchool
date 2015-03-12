//
//  DemoViewController.h
//  PageDemo
//
//  Created by 4DTECH on 13-4-12.
//  Copyright (c) 2013年 4DTECH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageView.h"
#import "DBHelper.h"
@interface DemoViewController : UIViewController<PageViewDelegate>
{
    int currentIndex;
    BOOL fromLeft;
    BOOL tap;
    float startX;
    int nextPageIndex;
    float minMoveWidth;
    DBHelper*_database;
    FMDatabase*_db;
    NSString*_question;
    NSMutableArray*_dataArray;
    NSMutableArray*_dataCountArray;
    UIButton*_answerA;
    UIButton*_answerB;
    UIButton*_answerC;
    UIButton*_answerD;
    UIButton*_answer;
    NSMutableArray*_btnArray;
    PageView *_vi;
    UIImageView *_backImage;
    UIImageView*_iView;
    //纪录index
    int _indexRecod;
    NSMutableArray*_indexArray;
    NSMutableDictionary*_dict;
    
}
@property(nonatomic,retain) PageView *visitPage;
@property(nonatomic,retain) PageView *prePage;
@property(nonatomic,retain) PageView *nextPage;
@end
