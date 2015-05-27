//
//  DSFindTeacherViewController.m
//  DriveSchool
//
//  Created by 张学成 on 15/3/3.
//  Copyright (c) 2015年 张学成. All rights reserved.
//

#import "DSFindTeacherViewController.h"
#import "DSFindTeacherTableViewCell.h"

@interface DSFindTeacherViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *teacherArray;

@end

@implementation DSFindTeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setDefaultValue];
    [self initData:@"0" size:@"15"];
    [self initRefreshView];
}
-(void)setDefaultValue{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.title = @"找教练";
    
    UIButton *teacherLoginButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,80, 30)];
    [teacherLoginButton setTitle:@"教练登录" forState:UIControlStateNormal];
    [teacherLoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [teacherLoginButton addTarget:self action:@selector(clickTeacherLoginView) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:teacherLoginButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
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
    self.tableView.headerReleaseToRefreshText = @"松开加载";
    self.tableView.headerRefreshingText = @"加载中...";
    
}
-(void)clickTeacherLoginView{
    UIViewController *vc = [self getViewControllerFromStoryBoard:@"DSTeacherLoginViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)refreshTop{
    NSString *size = [[NSString alloc]initWithFormat:@"%lu",(unsigned long)_teacherArray.count];
    [self initData:@"0" size:size];
}
-(void)refreshBottom{
    NSString *size = [[NSString alloc]initWithFormat:@"%lu",_teacherArray.count + 15];
    [self initData:@"0" size:size];
}
-(void)initData:(NSString *)start size:(NSString *)size{
    NSString *province = [[NSUserDefaults standardUserDefaults]stringForKey:kAPP_PROVINCE];
    NSString *city = [[NSUserDefaults standardUserDefaults]stringForKey:kAPP_CITY];
    NSDictionary *params = @{@"privince":province,@"city":city,@"district":@"",@"startIndex":start,@"endIndex":size};
    params = [AppUtil parameterToJson:params];
    
    [[AFNetworkKit sharedClient] POST:kAPI_GET_TEACHER parameters:params success:^(NSURLSessionDataTask *  task, id json) {
        //SUCCESS
        NSLog(@"%@",json);
        NSString *status = [json nonNullObjectForKey:@"resultCode"];
        if([status isEqualToString:API_STATUS_OK]){
            _teacherArray = [json nonNullObjectForKey:@"teacherInfolList"];
            [_tableView reloadData];
        }else{
            NSString *errorMsg = [json nonNullObjectForKey:@"resultMsg"];
            [self.view makeToast:errorMsg];
        }
        [self.tableView footerEndRefreshing];
        [self.tableView headerEndRefreshing];
    } failure:^(NSURLSessionDataTask * task, NSError *error) {
        //fail
        
        NSString * message = [AFNetworkKit getMessageWithResponse:task.response Error:error];
        NSLog(@"%@",message);
        [self.tableView footerEndRefreshing];
        [self.tableView headerEndRefreshing];
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _teacherArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CellIdentifier = @"findCell";
    DSFindTeacherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[DSFindTeacherTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *teacherInfo = [_teacherArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = [teacherInfo objectForKey:@"realName"];
    cell.teachAgeLabel.text = [[NSString alloc]initWithFormat:@"%@年教龄",[teacherInfo objectForKey:@"teachAge"]];
    cell.studentNumLabel.text = [[NSString alloc]initWithFormat:@"%@",[teacherInfo objectForKey:@"drivingSchoolName"]];
    cell.sexLabel.text = [[NSString alloc]initWithFormat:@"%@，",[teacherInfo objectForKey:@"sex"]];
    [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:[teacherInfo objectForKey:@"photoUrl"]] placeholderImage:[UIImage imageNamed:[teacherInfo objectForKey:@"photoUrl"]]];
    cell.photoImage = [UIImageView setImageViewRound:cell.photoImage radius:cell.photoImage.frame.size.width/10];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [self getViewControllerFromStoryBoard:@"DSTeacherDetailViewController"];
    
    [vc.passedParams setObject:[_teacherArray objectAtIndex:indexPath.row] forKey:@"teacherInfo"];
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
