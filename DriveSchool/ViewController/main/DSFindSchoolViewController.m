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
    [self initData];
}
-(void)setDefaultValue{
    _schoolArray = [[NSMutableArray alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}
-(void)initData{
    NSDictionary *params = @{@"privince":@"吉林省",@"city":@"长春市",@"district":@"朝阳区"};
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
    cell.studentNumLabel.text = [[NSString alloc]initWithFormat:@"%@人",[schoolInfo objectForKey:@"introduction"]];
    cell.addressLabel.text = [[NSString alloc]initWithFormat:@"%@，",[schoolInfo objectForKey:@"address"]];
    [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:[schoolInfo objectForKey:@"imageUrl"]] placeholderImage:nil];
    cell.moneyLabel.text =[[NSString alloc]initWithFormat:@"￥%@",[schoolInfo objectForKey:@"price"]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
