 //
//  DSNewSubjectTwoViewController.m
//  DriveSchool
//
//  Created by 张学成 on 15/3/3.
//  Copyright (c) 2015年 张学成. All rights reserved.
//

#import "DSNewSubjectTwoViewController.h"
#import "DSSubjectTwoTableViewCell.h"

@interface DSNewSubjectTwoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *usedTeachers;                 //预约过的教练
@property (strong, nonatomic) NSMutableArray *teachersArray;                //其他教练

@end

@implementation DSNewSubjectTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setDefaultValue];
//    [self initTestData];
    [self initDataWithStart:@"0" size:@"15"];
    [self initRefreshView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"DSNewSubjectTwoViewController"];
}
-(void)setDefaultValue{
    _usedTeachers = [[NSMutableArray alloc]init];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
}
-(void)initRefreshView{
    [self.tableView addFooterWithTarget:self action:@selector(refreshBottom)];
    self.tableView.footerPullToRefreshText = @"上拉加载";
    self.tableView.footerReleaseToRefreshText = @"松开加载";
    self.tableView.footerRefreshingText = @"加载中...";
    
    
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(refreshTop) color:[UIColor whiteColor]];
    //    [self.tableView headerBeginRefreshing];
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉刷新";
    self.tableView.headerReleaseToRefreshText = @"松开刷新";
    self.tableView.headerRefreshingText = @"刷新中...";
    
}
-(void)refreshTop{
    NSString *size = [[NSString alloc]initWithFormat:@"%lu",(unsigned long)_teachersArray.count];
    [self initDataWithStart:@"0" size:size];
}
-(void)refreshBottom{
    NSString *size = [[NSString alloc]initWithFormat:@"%lu",_teachersArray.count + 15];
    [self initDataWithStart:@"0" size:size];
}
-(void)initDataWithStart:(NSString *)start size:(NSString *)size{
    NSString *uid = [[NSUserDefaults standardUserDefaults]stringForKey:kAPP_LOCALDATA_UID];
    NSString *isBind = [[NSUserDefaults standardUserDefaults]stringForKey:kAPP_IS_BIND_SCHOOL];
    NSString *province = [[NSUserDefaults standardUserDefaults]stringForKey:kAPP_PROVINCE];
    NSString *city = [[NSUserDefaults standardUserDefaults]stringForKey:kAPP_CITY];
    NSDictionary *params = @{@"userId":uid,@"subject":@"2",@"privince":province,@"city":city,@"district":@"",@"startIndex":start,@"endIndex":size};
    if(!isBind){
        params = @{@"privince":province,@"city":city,@"district":@"",@"startIndex":start,@"endIndex":size};
    }
    //    NSDictionary *params = @{@"privince":@"",@"city":@""};
    params = [AppUtil parameterToJson:params];
    [self.view makeToastActivity];
    [[AFNetworkKit sharedClient] POST:kAPI_GET_SUBJECT_TEACHER parameters:params success:^(NSURLSessionDataTask *  task, id json) {
        //SUCCESS
        NSLog(@"%@",json);
        NSString *status = [json nonNullObjectForKey:@"resultCode"];
        if([status isEqualToString:API_STATUS_OK]){
            NSLog(@"成功");
            _usedTeachers = [json nonNullValueForKey:@"teacherInfolHisList"];
            _teachersArray = [json nonNullValueForKey:@"teacherInfolList"];
            
            [_tableView reloadData];
            [self.tableView footerEndRefreshing];
            [self.tableView headerEndRefreshing];
        }else{
            NSLog(@"失败");
            NSString *error = [json nonNullValueForKey:@"retMsg"];
            [self.view makeToast:error];
        }
        [self.view hideToastActivity];
    } failure:^(NSURLSessionDataTask * task, NSError *error) {
        //fail
        
        NSString * message = [AFNetworkKit getMessageWithResponse:task.response Error:error];
        NSLog(@"%@",message);
        [self.tableView footerEndRefreshing];
        [self.tableView headerEndRefreshing];
        [self.view hideToastActivity];
    }];

}

-(void)initTestData{
    _usedTeachers = [[NSMutableArray alloc]init];
    _teachersArray = [[NSMutableArray alloc]init];
    
    
    NSDictionary *tracherOne = @{@"name":@"高约波",@"teachAge":@"5",@"limit":@"10",@"count":@"10",@"photo":@"icon_driveSchool_teacherEight.jpg"};
    NSDictionary *tracherTwo = @{@"name":@"马艳艳",@"teachAge":@"3",@"limit":@"10",@"count":@"2",@"photo":@"icon_driveSchool_teacherEight.jpg"};
    [_usedTeachers addObject:tracherOne];
    [_usedTeachers addObject:tracherTwo];
    
    NSDictionary *tracherThree = @{@"name":@"司洪亮",@"teachAge":@"2",@"limit":@"10",@"count":@"5",@"photo":@"icon_driveSchool_teacherEight.jpg"};
    NSDictionary *tracherFour = @{@"name":@"王行",@"teachAge":@"3",@"limit":@"10",@"count":@"2",@"photo":@"icon_driveSchool_teacherEight.jpg"};
    [_teachersArray addObject:tracherThree];
    [_teachersArray addObject:tracherFour];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma tableDelagate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return _usedTeachers.count;
    }else if(section == 1){
        return _teachersArray.count;
    }
    return 0;
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if(section == 0){
//        return @"曾预约的教练";
//    }else{
//        return @"";
//    }
//}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        if(_usedTeachers.count==0){
             return 0;
        }
        return 30;
    }else{
        return 30;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionView = [[UIView alloc]init];
    sectionView.backgroundColor = [UIColor colorWithHex:0xf3f3f3];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 200, 20)];
    title.font = [UIFont boldSystemFontOfSize:16.0];
    title.textColor = [UIColor colorWithHex:0x494949];
    
    if(section == 0){
        title.text = @"曾预约的教练";
        sectionView.frame = CGRectMake(0, 0, CURRENT_WIDTH, 80);
    }else{
        title.text = @"所有教练";
        sectionView.frame = CGRectMake(0, 0, CURRENT_WIDTH, 80);
    }
    [sectionView addSubview:title];
    return sectionView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CellIdentifier = @"subjectTwoCell";
    DSSubjectTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[DSSubjectTwoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *teacherInfo;
    if(indexPath.section == 0){
        teacherInfo =  [_usedTeachers objectAtIndex:indexPath.row];
    }else{
        teacherInfo =  [_teachersArray objectAtIndex:indexPath.row];
    }
    
    cell.nameLabel.text = [teacherInfo objectForKey:@"realName"];
    cell.teachAge.text =  [[NSString alloc]initWithFormat:@"教龄:%li年",(long)[[teacherInfo objectForKey:@"teachAge"]integerValue]];
    NSInteger limit = [[teacherInfo objectForKey:@"limit"]integerValue];
    NSInteger count = [[teacherInfo objectForKey:@"count"]integerValue];
    [cell.reservationButton setTitle:@"预约" forState:UIControlStateNormal];
    cell.reservationButton.tag = indexPath.section *100+indexPath.row;
    [cell.reservationButton addTarget:self action:@selector(clickBookingButton:) forControlEvents:UIControlEventTouchUpInside];
    /*
    //这里不需要做是否已满的判断,因为没有指定时间
    if(count == limit){
        [cell.reservationButton setTitle:@"已满" forState:UIControlStateNormal];
        [cell.reservationButton setBackgroundColor:[UIColor grayColor]];
    }else{
        [cell.reservationButton setTitle:@"预约" forState:UIControlStateNormal];
        [cell.reservationButton setBackgroundColor:[UIColor colorWithHex:0x406ed2]];
    }
     */
    [cell.teacherPhoto sd_setImageWithURL:[NSURL URLWithString:[teacherInfo objectForKey:@"photoUrl"]] placeholderImage:nil];
    cell.teacherPhoto = [UIImageView setImageViewRound:cell.teacherPhoto radius:cell.teacherPhoto.frame.size.width/10];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self goDetailView:indexPath];
}
-(void)clickBookingButton:(UIButton *)button{
    NSInteger section = button.tag/100;
    NSInteger row = button.tag%100;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    
   [self goDetailView:indexPath];
    
}
-(void)goDetailView:(NSIndexPath *)indexPath{
    NSString *isBind = [[NSUserDefaults standardUserDefaults]stringForKey:kAPP_IS_BIND_SCHOOL];
    if(!isBind){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"需要绑定驾校才能使用预约功能" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView showWithHandler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if(buttonIndex == 1){
                UIViewController *vc = [self getViewControllerFromStoryBoard:@"DSBindingTelViewController"];
                [vc.passedParams setObject:@"app" forKey:@"from"];
                [self presentViewController:vc animated:YES completion:^{
                    
                }];
            }
        }];
        return;
    }
    UIViewController *vc = [self getViewControllerFromStoryBoard:@"DSSubjectTwoDetailViewController"];
    NSString *teacherId;
    NSString *photo;
    NSString *teacherAge;
    NSString *name;
    if(indexPath.section == 0){
        teacherId = [[_usedTeachers objectAtIndex:indexPath.row]objectForKey:@"id"];
        photo = [[_usedTeachers objectAtIndex:indexPath.row]objectForKey:@"photoUrl"];
        teacherAge = [[_usedTeachers objectAtIndex:indexPath.row]objectForKey:@"teachAge"];
        name = [[_usedTeachers objectAtIndex:indexPath.row]objectForKey:@"realName"];
    }else{
        teacherId = [[_teachersArray objectAtIndex:indexPath.row]objectForKey:@"id"];
        photo = [[_teachersArray objectAtIndex:indexPath.row]objectForKey:@"photoUrl"];
        teacherAge = [[_teachersArray objectAtIndex:indexPath.row]objectForKey:@"teachAge"];
        name = [[_teachersArray objectAtIndex:indexPath.row]objectForKey:@"realName"];
    }
    [vc.passedParams setObject:teacherId forKey:@"teacherId"];
    [vc.passedParams setObject:photo forKey:@"photoUrl"];
    [vc.passedParams setObject:teacherAge forKey:@"teachAge"];
    [vc.passedParams setObject:name forKey:@"realName"];
    [vc.passedParams setObject:@"2" forKey:@"subject"];
    [self.navigationController pushViewController:vc animated:YES];
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
