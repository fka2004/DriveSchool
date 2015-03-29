//
//  DSTeacherDateViewController.m
//  DriveSchool
//
//  Created by 张学成 on 15/2/20.
//  Copyright (c) 2015年 张学成. All rights reserved.
//

#import "DSTeacherDateViewController.h"
#import "DSTeacherDataTableViewCell.h"

@interface DSTeacherDateViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *teacherPhoto;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *teachAge;
@property (weak, nonatomic) IBOutlet UILabel *studentNum;
@property (strong, nonatomic) NSDictionary *teacherInfo;
@property (strong, nonatomic) NSMutableArray *tableItem;

@end

@implementation DSTeacherDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableValue];
    [self setDefaultValue];
    
}
-(void)setDefaultValue{
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    _teacherInfo = [self.passedParams nonNullValueForKey:@"teacherInfo"];
    
    [_teacherPhoto setImage:[UIImage imageNamed:[_teacherInfo nonNullValueForKey:@"photo"]]];
    _teachAge.text = [[NSString alloc]initWithFormat:@"%li年",(long)[[_teacherInfo nonNullValueForKey:@"teachAge"]integerValue]];
    _studentNum.text = [[NSString alloc]initWithFormat:@"%li人",(long)[[_teacherInfo nonNullValueForKey:@"studentNum"]integerValue]];
    
}
-(void)initTableValue{
    _tableItem = [[NSMutableArray alloc]init];
    NSDictionary *dicOne = @{@"start":@"07:00",@"end":@"09:00",@"num":@"21",@"limit":@"30"};
    NSDictionary *dicTwo = @{@"start":@"09:00",@"end":@"11:00",@"num":@"25",@"limit":@"30"};
    NSDictionary *dicThree = @{@"start":@"11:00",@"end":@"13:00",@"num":@"19",@"limit":@"30"};
    NSDictionary *dicFour = @{@"start":@"13:00",@"end":@"15:00",@"num":@"30",@"limit":@"30"};
    NSDictionary *dicFive = @{@"start":@"15:00",@"end":@"17:00",@"num":@"21",@"limit":@"30"};
    
    [_tableItem addObject:dicOne];
    [_tableItem addObject:dicTwo];
    [_tableItem addObject:dicThree];
    [_tableItem addObject:dicFour];
    [_tableItem addObject:dicFive];
    
}
#pragma tableDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableItem.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIndentifier = @"DataCell";
    DSTeacherDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    
    if(!cell){
        cell = [[DSTeacherDataTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
    }
    NSDictionary *dic = [_tableItem objectAtIndex:indexPath.row];
    NSString *timeStr = [[NSString alloc]initWithFormat:@"%@-%@",[dic nonNullValueForKey:@"start"],[dic nonNullValueForKey:@"end"]];
    cell.timeLabel.text = timeStr;
    NSString *peopleNum = [[NSString alloc]initWithFormat:@"%@/%@人",[dic nonNullValueForKey:@"num"],[dic nonNullValueForKey:@"limit"]];
    cell.numLabel.text = peopleNum;
    if([[dic nonNullValueForKey:@"num"] integerValue] == [[dic nonNullValueForKey:@"limit"]integerValue]){
        [cell.dataButton setTitle:@"已满" forState:UIControlStateNormal];
        [cell.dataButton setBackgroundColor:[UIColor grayColor]];
    }

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [self getViewControllerFromStoryBoard:@"DSSubjectTwoDetailViewController"];
    [self.navigationController pushViewController:vc animated:YES];
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
