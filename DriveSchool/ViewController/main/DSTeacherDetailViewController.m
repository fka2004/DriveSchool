//
//  DSTeacherDetailViewController.m
//  DriveSchool
//
//  Created by 张学成 on 15/3/5.
//  Copyright (c) 2015年 张学成. All rights reserved.
//

#import "DSTeacherDetailViewController.h"

@interface DSTeacherDetailViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UITextView *addressField;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UITextView *teacherInfoTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableDictionary *teacherInfo;
@property (weak, nonatomic) IBOutlet UIView *teacherInfoView;
@property (weak, nonatomic) IBOutlet UIView *infoVoew;
@property (weak, nonatomic) IBOutlet UIScrollView *bannerScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) NSTimer *bannerTimer;
@property (strong, nonatomic) NSMutableArray *bannerArray;
@property (strong, nonatomic) NSMutableDictionary *teacherDetailDic;






@end

@implementation DSTeacherDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setDefaultValue];
    [self initTeacherInfo];
//    [self initBanner];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"DSTeacherDetailViewController"];
}
-(void)setDefaultValue{
    self.title = @"教练信息";
//    _teacherInfoView.layer.borderWidth = 1;
//    _teacherInfoView.layer.borderColor = [[UIColor colorWithHex:0xf3f3f3]CGColor];
//    _infoVoew.layer.borderWidth = 1;
//    _infoVoew.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
   
    
    [self initTeacherInfo];
    //要计算教练简介的高度来设置
    //因为要去除不滑动显示的内容高度,所以减去50
    CGFloat height  = [AppUtil heightForString:[_teacherInfo objectForKey:@"introduce"] fontSize:17.0 andWidth:290]-50;
    
    
}
-(void)initBannerWithUrl:(NSString *)imageUrl{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:_bannerScrollView.bounds];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    [_bannerScrollView addSubview:imageView];
}
-(void)initBanner{
    _bannerArray = [[NSMutableArray alloc]init];
    NSDictionary *bannerOne = @{@"image":@"icon_main_banner_one.png",@"url":@"http://baidu.com"};
    NSDictionary *bannerTwo = @{@"image":@"icon_main_banner_four.jpg",@"url":@"http://baidu.com"};
    [_bannerArray addObject:bannerOne];
    [_bannerArray addObject:bannerTwo];
    [_bannerScrollView setContentSize:CGSizeMake(CURRENT_WIDTH*_bannerArray.count, 160)];
    
    for (int i = 0; i < _bannerArray.count; i++) {
        NSDictionary *dic = [_bannerArray objectAtIndex:i];
        NSString *imageName = [dic nonNullValueForKey:@"image"];
        UIButton *bannerBtn = [[UIButton alloc]initWithFrame:CGRectMake(i*CURRENT_WIDTH, 0, CURRENT_WIDTH, 160)];
        [bannerBtn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
        [_bannerScrollView addSubview:bannerBtn];
    }
    
    [_pageControl setNumberOfPages:_bannerArray.count];
    if(!_bannerTimer){
        _bannerTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(bannerAutoScroll) userInfo:nil repeats:YES];
    }
}
-(void)bannerAutoScroll{
    NSInteger bannerCount = _pageControl.numberOfPages;
    NSInteger currentPage = _pageControl.currentPage;
    if (currentPage < bannerCount-1) {
        CGPoint point = CGPointMake(CURRENT_WIDTH*currentPage+CURRENT_WIDTH,0);
        [_bannerScrollView setContentOffset:point animated:YES];
        [_pageControl setCurrentPage:currentPage+1];
    }else if(currentPage+1 == bannerCount){
        CGPoint point = CGPointMake(0,0);
        [_bannerScrollView setContentOffset:point animated:YES];
        [_pageControl setCurrentPage:0];
    }
}
-(void)initTeacherInfo{
    _teacherInfo = [self.passedParams objectForKey:@"teacherInfo"];
    NSDictionary *params = @{@"id":[_teacherInfo objectForKey:@"id"]};
     params = [AppUtil parameterToJson:params];
    [[AFNetworkKit sharedClient] POST:kAPI_GET_TEACHER_DETAIL parameters:params success:^(NSURLSessionDataTask *  task, id json) {
        //SUCCESS
        NSLog(@"%@",json);
        NSString *status = [json nonNullObjectForKey:@"resultCode"];
        if([status isEqualToString:API_STATUS_OK]){
            _teacherDetailDic = [json nonNullValueForKey:@"teacherDetails"];
            _nameLabel.text = [_teacherDetailDic nonNullValueForKey:@"realName"];
            NSString *money = [[NSString alloc]initWithFormat:@"￥%i",[[_teacherDetailDic nonNullValueForKey:@"price"]integerValue]];
            _moneyLabel.text = money;
            _telLabel.text = [_teacherDetailDic nonNullValueForKey:@"phoneNo"];
            _addressField.text = [_teacherDetailDic nonNullValueForKey:@"drivingschoolName"];
            NSString *teacherInfo = [_teacherDetailDic nonNullValueForKey:@"introduction"];
            //根据文字高度计算view高度
            CGFloat height = [AppUtil heightForString:teacherInfo fontSize:14 andWidth:_teacherInfoTextView.frame.size.width]+50;
            _teacherInfoTextView.frame = CGRectMake(_teacherInfoTextView.frame.origin.x, _teacherInfoTextView.frame.origin.y, _teacherInfoTextView.frame.size.width, height);
            _teacherInfoTextView.text = teacherInfo;
            _teacherInfoView.frame = CGRectMake( _teacherInfoView.frame.origin.x,  _teacherInfoView.frame.origin.y,  _teacherInfoView.frame.size.width,  height + 70);
            [_scrollView setContentSize:CGSizeMake(CURRENT_WIDTH, height + 70 + _bannerScrollView.frame.size.height + _infoVoew.frame.size.height + 30)];
            [self initBannerWithUrl:[_teacherDetailDic nonNullValueForKey:@"imageUrl"]];
        }else{
            NSString *errorMsg = [json nonNullObjectForKey:@"resultMsg"];
            [self.view makeToast:errorMsg];
        }
        
    } failure:^(NSURLSessionDataTask * task, NSError *error) {
        //fail
        
        NSString * message = [AFNetworkKit getMessageWithResponse:task.response Error:error];
        NSLog(@"%@",message);
    }];
    _addressField.editable = NO;
}
- (IBAction)clickCallButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc]initWithFormat:@"telprompt://%@",[_teacherDetailDic nonNullValueForKey:@"phoneNo"]]]];
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
