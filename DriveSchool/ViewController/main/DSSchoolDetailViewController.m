//
//  DSSchoolDetailViewController.m
//  DriveSchool
//
//  Created by 张学成 on 15/3/12.
//  Copyright (c) 2015年 张学成. All rights reserved.
//

#import "DSSchoolDetailViewController.h"

@interface DSSchoolDetailViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *bannerScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *schoolName;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolInfoName;
@property (weak, nonatomic) IBOutlet UITextView *schoolInfoTextView;

@property (strong, nonatomic) NSMutableDictionary *schoolInfo;

@end

@implementation DSSchoolDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDefaultValue];
    [self getSchoolData];
}
-(void)setDefaultValue{
    self.title = @"驾校信息";
    _schoolInfo = [self.passedParams nonNullValueForKey:@"school"];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"DSSchoolDetailViewController"];
}
-(void)getSchoolData{
//    NSString *schoolId = [[NSString alloc]initWithFormat:@"%@",[_schoolInfo nonNullValueForKey:@"id"]];
    NSDictionary *params = @{@"id":[_schoolInfo nonNullValueForKey:@"id"]};
    //    NSDictionary *params = @{@"privince":@"",@"city":@""};
    params = [AppUtil parameterToJson:params];
    
    [[AFNetworkKit sharedClient] POST:kAPI_GET_SCHOOL_DETAIL parameters:params success:^(NSURLSessionDataTask *  task, id json) {
        //SUCCESS
        NSLog(@"%@",json);
        NSString *status = [json nonNullObjectForKey:@"resultCode"];
        if([status isEqualToString:API_STATUS_OK]){
            _schoolName.text = [json nonNullValueForKeyPath:@"drivingSchoolDetails.drivingSchoolName"];
            _addressLabel.text = [json nonNullValueForKeyPath:@"drivingSchoolDetails.address"];
            NSInteger price = [[json nonNullValueForKeyPath:@"drivingSchoolDetails.price"]integerValue];
            _moneyLabel.text = [[NSString alloc]initWithFormat:@"￥%i",price];
            _telLabel.text = [json nonNullValueForKeyPath:@"drivingSchoolDetails.phoneNo"];
            _schoolInfoName.text = [json nonNullValueForKeyPath:@"drivingSchoolDetails.drivingSchoolName"];
            CGFloat height = [AppUtil heightForString:[json nonNullValueForKeyPath:@"drivingSchoolDetails.introduction"] fontSize:14 andWidth:_schoolInfoTextView.frame.size.width]+50;
            _schoolInfoTextView.frame = CGRectMake(_schoolInfoTextView.frame.origin.x, _schoolInfoTextView.frame.origin.y, _schoolInfoTextView.frame.size.width, height);
            _schoolInfoTextView.text = [json nonNullValueForKeyPath:@"drivingSchoolDetails.introduction"];
            [_scrollView setContentSize:CGSizeMake(CURRENT_WIDTH, height + 70 + _bannerScrollView.frame.size.height + _schoolInfoTextView.frame.size.height + 30)];
           [self initBannerView:[json nonNullValueForKeyPath:@"drivingSchoolDetails.imageUrl"]];
        }else{
            NSLog(@"失败");
        }
        
    } failure:^(NSURLSessionDataTask * task, NSError *error) {
        //fail
        
        NSString * message = [AFNetworkKit getMessageWithResponse:task.response Error:error];
        NSLog(@"%@",message);
    }];

}
-(void)initBannerView:(NSString *)bannerImage{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:_bannerScrollView.bounds];
    [imageView sd_setImageWithURL:[NSURL URLWithString:bannerImage] placeholderImage:nil];
    [_bannerScrollView addSubview:imageView];
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
