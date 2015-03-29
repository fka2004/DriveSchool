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
    if(LOCAL_TEST){
        [self initTableItem];
    }else{
        [self initData];
    }
    
    
}
-(void)setDefaultValue{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.title = @"找教练";
}
-(void)initData{
    NSDictionary *params = @{@"privince":@"吉林省",@"city":@"长春市",@"district":@"朝阳区"};
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
        
    } failure:^(NSURLSessionDataTask * task, NSError *error) {
        //fail
        
        NSString * message = [AFNetworkKit getMessageWithResponse:task.response Error:error];
        NSLog(@"%@",message);
    }];

}
-(void)initTableItem{
    _teacherArray = [[NSMutableArray alloc]init];
    NSDictionary *teacherOne = @{@"realName":@"王艳伟",@"teachAge":@"5",@"studentNum":@"10",@"photoUrl":@"icon_driveSchool_teacherOne.jpg",@"sex":@"男",@"tel":@"15101022345",@"money":@"￥3000",@"address":@"长春市绿园区青年路日新小区66号",@"introduce":@"谈教练,男,教练员.\n隶属于汇通驾校,有15年教龄.\n简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介"};
    NSDictionary *teacherTwo = @{@"realName":@"佳腾",@"teachAge":@"8",@"studentNum":@"16",@"photoUrl":@"icon_driveSchool_teacherTwo.jpg",@"sex":@"男",@"tel":@"15101022345",@"money":@"￥3000",@"address":@"长春市绿园区青年路日新小区66号",@"introduce":@"谈教练,男,教练员.\n隶属于汇通驾校,有15年教龄.\n简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介"};
    NSDictionary *teacherThree = @{@"realName":@"吴悠恒",@"teachAge":@"3",@"studentNum":@"12",@"photoUrl":@"icon_driveSchool_teacherThree.jpg",@"sex":@"男",@"tel":@"15101022345",@"money":@"￥3000",@"address":@"长春市绿园区青年路日新小区66号",@"introduce":@"谈教练,男,教练员.\n隶属于汇通驾校,有15年教龄.\n简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介"};
    NSDictionary *teacherFour = @{@"realName":@"高越博",@"teachAge":@"5",@"studentNum":@"12",@"photoUrl":@"icon_driveSchool_teacherFour.jpg",@"sex":@"男",@"tel":@"15101022345",@"money":@"￥3000",@"address":@"长春市绿园区青年路日新小区66号",@"introduce":@"谈教练,男,教练员.\n隶属于汇通驾校,有15年教龄.\n简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介"};
    NSDictionary *teacherFive = @{@"realName":@"宋杰心",@"teachAge":@"5",@"studentNum":@"13",@"photoUrl":@"icon_driveSchool_teacherFive.jpg",@"sex":@"男",@"tel":@"15101022345",@"money":@"￥3000",@"address":@"长春市绿园区青年路日新小区66号",@"introduce":@"谈教练,男,教练员.\n隶属于汇通驾校,有15年教龄.\n简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介"};
    NSDictionary *teacherSix = @{@"realName":@"张伟",@"teachAge":@"5",@"studentNum":@"18",@"photoUrl":@"icon_driveSchool_teacherSix.jpg",@"sex":@"男",@"tel":@"15101022345",@"money":@"￥3000",@"address":@"长春市绿园区青年路日新小区66号",@"introduce":@"谈教练,男,教练员.\n隶属于汇通驾校,有15年教龄.\n简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介"};
    NSDictionary *teacherSenve = @{@"realName":@"刘磊",@"teachAge":@"5",@"studentNum":@"9",@"photoUrl":@"icon_driveSchool_teacherSeven.jpg",@"sex":@"男",@"tel":@"15101022345",@"money":@"￥3000",@"address":@"长春市绿园区青年路日新小区66号",@"introduce":@"谈教练,男,教练员.\n隶属于汇通驾校,有15年教龄.\n简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介"};
    NSDictionary *teacherEight = @{@"realName":@"王茹",@"teachAge":@"5",@"studentNum":@"11",@"photoUrl":@"icon_driveSchool_teacherEight.jpg",@"sex":@"男",@"tel":@"15101022345",@"money":@"￥3000",@"address":@"长春市绿园区青年路日新小区66号",@"introduce":@"谈教练,男,教练员.\n隶属于汇通驾校,有15年教龄.\n简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介"};
    NSDictionary *teacherNine = @{@"realName":@"张明",@"teachAge":@"5",@"studentNum":@"12",@"photoUrl":@"icon_driveSchool_teacherNine.jpg",@"sex":@"男",@"tel":@"15101022345",@"money":@"￥3000",@"address":@"长春市绿园区青年路日新小区66号",@"introduce":@"谈教练,男,教练员.\n隶属于汇通驾校,有15年教龄.\n简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介简介"};

    [_teacherArray addObject:teacherOne];
    [_teacherArray addObject:teacherTwo];
    [_teacherArray addObject:teacherThree];
    [_teacherArray addObject:teacherFour];
    [_teacherArray addObject:teacherFive];
    [_teacherArray addObject:teacherSix];
    [_teacherArray addObject:teacherSenve];
    [_teacherArray addObject:teacherEight];
    [_teacherArray addObject:teacherNine];
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
