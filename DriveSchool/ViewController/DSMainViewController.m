//
//  DSMainViewController.m
//  DriveSchool
//
//  Created by 张学成 on 15/2/8.
//  Copyright (c) 2015年 张学成. All rights reserved.
//

#import "DSMainViewController.h"
#import "DSMainTableViewCell.h"

@interface DSMainViewController ()<UITableViewDelegate,UIScrollViewDelegate,UITableViewDataSource>
@property (strong ,nonatomic) NSTimer *timer;                 //自动滚屏timer
@property (weak, nonatomic) IBOutlet UIScrollView *bannerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableItems;
@property (strong, nonatomic) NSMutableArray *bannerArray;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) NSTimer *bannerTimer;
@property (strong, nonatomic) NSMutableArray *functionItemArray;
@property (weak, nonatomic) IBOutlet UIView *functionItemView;


@end

@implementation DSMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDefaultValue];
    [self initFrame];
    [self initFounctionItem];
//    [self apiTest];
    [self initData];
}
-(void)initData{
    NSString *province = [[NSUserDefaults standardUserDefaults]stringForKey:kAPP_PROVINCE];
    NSString *city = [[NSUserDefaults standardUserDefaults]stringForKey:kAPP_CITY];
    if(!province){
        province = @"吉林省";
    }
    if(!city){
        city = @"长春市";
    }
    NSDictionary *params = @{@"privince":province,@"city":city};
    params = [AppUtil parameterToJson:params];
    
    [[AFNetworkKit sharedClient] POST:kAPI_GET_MAIN parameters:params success:^(NSURLSessionDataTask *  task, id json) {
        //SUCCESS
        NSLog(@"%@",json);
        NSString *status = [json nonNullObjectForKey:@"resultCode"];
        if([status isEqualToString:API_STATUS_OK]){
            NSLog(@"成功");
            //填充banner信息
            _bannerArray = [json nonNullObjectForKey:@"bannerList"];
            _tableItems = [json nonNullObjectForKey:@"newsList"];
            [self initBanner];
            [_tableView reloadData];
        }else{
            NSLog(@"失败");
        }
        
    } failure:^(NSURLSessionDataTask * task, NSError *error) {
        //fail
        
        NSString * message = [AFNetworkKit getMessageWithResponse:task.response Error:error];
        NSLog(@"%@",message);
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.title = @"首页";
}

-(void)initBanner{
    _bannerView.frame = CGRectMake(0, _bannerView.frame.origin.y, CURRENT_WIDTH, 160);
    [_bannerView setContentSize:CGSizeMake(CURRENT_WIDTH*_bannerArray.count, 160)];
    
    for (int i = 0; i < _bannerArray.count; i++) {
        NSDictionary *dic = [_bannerArray objectAtIndex:i];
        UIButton *bannerBtn = [[UIButton alloc]initWithFrame:CGRectMake(i*CURRENT_WIDTH, 0, CURRENT_WIDTH, 160)];
        [bannerBtn sd_setBackgroundImageWithURL:[dic nonNullObjectForKey:@"imageUrl"] forState:UIControlStateNormal placeholderImage:nil];
//        [bannerBtn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
        [_bannerView addSubview:bannerBtn];
    }
    
    [_pageControl setNumberOfPages:_bannerArray.count];
    if(!_bannerTimer){
        _bannerTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(bannerAutoScroll) userInfo:nil repeats:YES];
    }
}
//生成功能项
-(void)initFounctionItem{
    _functionItemArray = [[NSMutableArray alloc]init];
    NSDictionary *itemOne = @{@"name":@"新手驾到",@"image":@"btn_main_item_one.png",@"url":@"http://baidu.com"};
    NSDictionary *itemTwo = @{@"name":@"找驾校",@"image":@"btn_main_item_two.png",@"url":@"http://baidu.com"};
    NSDictionary *itemThree = @{@"name":@"找教练",@"image":@"btn_main_item_three.png",@"url":@"http://baidu.com"};
    
//    [_functionItemArray addObject:itemOne];
    [_functionItemArray addObject:itemTwo];
    [_functionItemArray addObject:itemThree];

    if(_functionItemArray.count<5){
        NSLog(@"%f",_functionItemView.frame.size.height);
        for (int i=0; i<_functionItemArray.count; i++) {
            NSDictionary *dic =  [_functionItemArray objectAtIndex:i];
            int width = CURRENT_WIDTH / _functionItemArray.count;
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(width*i, 0, width, _functionItemView.frame.size.height)];
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, _functionItemView.frame.size.height-10)];
            button.tag = i;
            [button setImage:[UIImage imageNamed:[dic objectForKey:@"image"]] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(clickFunctionItem:) forControlEvents:UIControlEventTouchUpInside];
            NSLog(@"%f",view.frame.size.width);
            int offset = 18;
            if(iPhone6plus){
                offset = 15;
                button.frame = CGRectMake(0, -5, view.frame.size.width, _functionItemView.frame.size.height-10);
            }else if(iPhone4){
                offset = 22;
                button.frame = CGRectMake(0, -5, view.frame.size.width, _functionItemView.frame.size.height-10);
            }else if(iPhone6){
                offset = 20;
            }
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,  view.frame.size.height-offset, view.frame.size.width, 20)];
            
            label.text = [dic objectForKey:@"name"];

            label.font = [UIFont systemFontOfSize:13.5];
            label.textColor = [UIColor darkGrayColor];
            label.textAlignment = YES;
            
            
            [view addSubview:button];
            [view addSubview:label];
            
            [_functionItemView addSubview:view];
        }
    }
}
//生成测试数据
-(void)initTestData{
    NSDictionary *newsOne = @{@"image":@"image_main_news_one.png",@"url":@"http://baidu.com",@"title":@"新2015年驾校科目四安全常识",@"content":@"为了更好的培养出优秀的驾驶员，驾驶员考试越来越严格且项目增多。对于学员的驾驶技能又有很大的考验。特此考试吧为大家整理了相关内容，供大家参考学习！"};
    NSDictionary *newsTwo = @{@"image":@"image_main_news_two.png",@"url":@"http://baidu.com",@"title":@"教练想学员索要500元保险费被开除",@"content":@"佛山一名驾校教练为疏通关系,收取学员300元到500元不等的“保险费”后向考官行贿,共有14名交警牵涉其中,涉案金额达61.7万元。"};
    NSDictionary *newsThree = @{@"image":@"image_main_news_three.jpg",@"url":@"http://baidu.com",@"title":@"报名前选择驾校与教练的注意事项",@"content":@" 城市的外来人口多，学驾校的人很多，而做教练这行的就更多，俗话说：人上一百，形形色色，如何找到一个适合自己的教练，就变得很难。我这里不说人品，不说距离，就仅从这个行业的管理规定，来告诉准备学驾校的新手，如何从资质上选择一个教练。"};
    NSDictionary *newsFour = @{@"image":@"image_main_news_four.jpg",@"url":@"http://baidu.com",@"title":@"新人学车，是手动挡好还是自动挡好",@"content":@"赶着报考驾校，但现在正在纠结着报手动挡好还是自动挡好。自动挡么方便，而且听说好学点，但缺点是钱贵点，而且学得东西好像没有那么精(听说的)。手动挡么难学点，但是听说便宜点，学得东西多一点。 各位前辈们，给点宝贵的意见把。"};
    NSDictionary *newsFive = @{@"image":@"image_main_news_five.jpg",@"url":@"http://baidu.com",@"title":@"分享：驾校与教练选择的终极经验.",@"content":@"在坛论看了很多帖子，很少有好的帖子可以给新手在选驾校，教练和考试方面可以借鉴。就想到写一些考驾照的经验给大家学习一下，但是太懒一直没有动，才想起应该分享些经验，给同学们一些参考。"};
    
    
    [_tableItems addObject:newsOne];
    [_tableItems addObject:newsTwo];
    [_tableItems addObject:newsThree];
    [_tableItems addObject:newsFour];
    [_tableItems addObject:newsFive];

}
-(void)clickFunctionItem:(UIButton *)button{
    NSLog(@"clickItem");
    if(button.tag == 0){
        UIViewController *vc = [self getViewControllerFromStoryBoard:@"DSFindSchoolViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(button.tag == 1){
        UIViewController *vc = [self getViewControllerFromStoryBoard:@"DSFindTeacherViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
/**
 *  banner自动滚动
 */
-(void)bannerAutoScroll{
    NSInteger bannerCount = _pageControl.numberOfPages;
    NSInteger currentPage = _pageControl.currentPage;
    if (currentPage < bannerCount-1) {
        CGPoint point = CGPointMake(CURRENT_WIDTH*currentPage+CURRENT_WIDTH,0);
        [_bannerView setContentOffset:point animated:YES];
        [_pageControl setCurrentPage:currentPage+1];
    }else if(currentPage+1 == bannerCount){
        CGPoint point = CGPointMake(0,0);
        [_bannerView setContentOffset:point animated:YES];
        [_pageControl setCurrentPage:0];
    }
}
-(void)setNewsData{
    
}
-(void)setDefaultValue{
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundColor:[UIColor blueColor]];
    
    _tableItems = [[NSMutableArray alloc]init];

    
    _tableView.delegate = self;
    _tableView.dataSource = self;
}
-(void)initFrame{
    if(iPhone6){
        _tableView.frame = CGRectMake(0,_tableView.frame.origin.y , CURRENT_WIDTH, _tableView.frame.size.height+40);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableItems.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIndentifier = @"mainCell";
    NSDictionary *dic = [_tableItems objectAtIndex:indexPath.row];
    DSMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    if(!cell){
        cell = [[DSMainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.title.text = [dic nonNullValueForKey:@"title"];
    cell.content.text = [dic nonNullValueForKey:@"content"];
    NSString *imageUrl = [dic nonNullValueForKey:@"imageUrl"];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     NSDictionary *dic = [_tableItems objectAtIndex:indexPath.row];
    UIViewController *vc = [self getViewControllerFromStoryBoard:@"YDNewsViewController"];
    NSString *url = [[NSString alloc]initWithFormat:@"%@%@",kAPP_GET_NEWS,[dic nonNullValueForKey:@"id"]];
    [vc.passedParams setObject:url forKey:@"url"];
    [vc.passedParams setObject:[dic nonNullValueForKey:@"title"] forKey:@"title"];
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
