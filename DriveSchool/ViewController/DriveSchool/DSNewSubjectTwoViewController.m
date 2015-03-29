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
    [self initData];
}
-(void)setDefaultValue{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
}
-(void)initData{
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
        return 30;
    }else{
        return 10;
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
        sectionView.frame = CGRectMake(0, 0, CURRENT_WIDTH, 30);
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
    
    cell.nameLabel.text = [teacherInfo objectForKey:@"name"];
    cell.teachAge.text =  [[NSString alloc]initWithFormat:@"教龄:%li年",(long)[[teacherInfo objectForKey:@"teachAge"]integerValue]];
    NSInteger limit = [[teacherInfo objectForKey:@"limit"]integerValue];
    NSInteger count = [[teacherInfo objectForKey:@"count"]integerValue];
    [cell.reservationButton setTitle:@"预约" forState:UIControlStateNormal];
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
    [cell.teacherPhoto setImage:[UIImage imageNamed:[teacherInfo objectForKey:@"photo"]]];
    cell.teacherPhoto = [UIImageView setImageViewRound:cell.teacherPhoto radius:cell.teacherPhoto.frame.size.width/2];
//    cell.teacherPhoto = [UIImageView setImageViewRound:cell.teacherPhoto radius:cell.teacherPhoto.frame.size.width/10];
//    [cell.teacherPhoto sd_setImageWithURL:[NSURL URLWithString:[teacherInfo objectForKey:@"photo"]] placeholderImage:nil];
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [self getViewControllerFromStoryBoard:@"DSSubjectTwoDetailViewController"];
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
