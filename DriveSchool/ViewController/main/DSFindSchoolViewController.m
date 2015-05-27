//
//  DSFindSchoolViewController.m
//  DriveSchool
//
//  Created by 张学成 on 15/3/4.
//  Copyright (c) 2015年 张学成. All rights reserved.
//

#import "DSFindSchoolViewController.h"
#import "DSFindSchoolTableViewCell.h"



@interface DSFindSchoolViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *schoolArray;

@end

@implementation DSFindSchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setDefaultValue];
    [self initRefreshView];
    [self initDataWithStart:@"0" size:@"15"];
}
-(void)setDefaultValue{
    self.title = @"找驾校";
    _schoolArray = [[NSMutableArray alloc]init];
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
    self.tableView.headerReleaseToRefreshText = @"松开加载";
    self.tableView.headerRefreshingText = @"加载中...";
    
}
-(void)refreshTop{
    NSString *size = [[NSString alloc]initWithFormat:@"%lu",(unsigned long)_schoolArray.count];
    [self initDataWithStart:@"0" size:size];
}
-(void)refreshBottom{
    NSString *size = [[NSString alloc]initWithFormat:@"%lu",_schoolArray.count + 15];
    [self initDataWithStart:@"0" size:size];
}
-(void)initDataWithStart:(NSString *)start size:(NSString *)size{
    NSString *province = [[NSUserDefaults standardUserDefaults]stringForKey:kAPP_PROVINCE];
    NSString *city = [[NSUserDefaults standardUserDefaults]stringForKey:kAPP_CITY];
    NSDictionary *params = @{@"privince":province,@"city":city,@"district":@"",@"startIndex":start,@"endIndex":size};
//    NSDictionary *params = @{@"privince":@"",@"city":@"",@"district":@"",@"startIndex":@"1",@"endIndex":@"10"};
    params = [AppUtil parameterToJson:params];
    [self.view makeToastActivity];
    [[AFNetworkKit sharedClient] POST:kAPI_GET_SCHOOL parameters:params success:^(NSURLSessionDataTask *  task, id json) {
        //SUCCESS
        [self.view hideToastActivity];
        NSLog(@"%@",json);
        NSString *status = [json nonNullObjectForKey:@"resultCode"];
        if([status isEqualToString:API_STATUS_OK]){
            _schoolArray = [json nonNullObjectForKey:@"drivingSchoolList"];
            [_tableView reloadData];
        }else{
            NSString *errorMsg = [json nonNullObjectForKey:@"resultMsg"];
            [self.view makeToast:errorMsg];
        }
        
    } failure:^(NSURLSessionDataTask * task, NSError *error) {
        //fail
        [self.view hideToastActivity];
        NSString * message = [AFNetworkKit getMessageWithResponse:task.response Error:error];
        NSLog(@"%@",message);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _schoolArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CellIdentifier = @"schoolCell";
    DSFindSchoolTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[DSFindSchoolTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *schoolInfo = [_schoolArray objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = [schoolInfo objectForKey:@"drivingSchoolName"];
    cell.studentNumLabel.text = [[NSString alloc]initWithFormat:@"%@人",[schoolInfo objectForKey:@"studentNumber"]];
    cell.addressLabel.text = [[NSString alloc]initWithFormat:@"%@，",[schoolInfo objectForKey:@"address"]];
    [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:[schoolInfo objectForKey:@"imageUrl"]] placeholderImage:nil];
    NSInteger price = [[schoolInfo objectForKey:@"price"]integerValue];
    cell.moneyLabel.text =[[NSString alloc]initWithFormat:@"￥%i",price];
    cell.photoImage = [UIImageView setImageViewRound:cell.photoImage radius:cell.photoImage.frame.size.width/10];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    DSSchoolDetailViewController *
    UIViewController *vc = [self getViewControllerFromStoryBoard:@"DSSchoolDetailViewController"];
    [vc.passedParams setObject:[_schoolArray objectAtIndex:indexPath.row] forKey:@"school"];
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
