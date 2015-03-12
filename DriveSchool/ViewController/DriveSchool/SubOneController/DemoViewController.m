//
//  DemoViewController.m
//  PageDemo
//
//  Created by 4DTECH on 13-4-12.
//  Copyright (c) 2013年 4DTECH. All rights reserved.
//

#import "DemoViewController.h"
#import "FMResultSet.h"
#import "FMDatabase.h"
#import "DBHelper.h"
#import "ExamItem.h"
#define MIN_MOVE_WIDTH 

#define DATABASE_NAME @"driveSchool.db"
#define DATABASE_PATH(db_name) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:db_name]
@interface DemoViewController ()

@end

@implementation DemoViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
           }
    return self;
}

- (void)viewDidLoad
{
  
    
    _dataArray=[[NSMutableArray alloc]init];
    _dataCountArray=[[NSMutableArray alloc]init];
    _btnArray=[[NSMutableArray alloc]init];
    _indexArray=[[NSMutableArray alloc]init];
    _dict=[[NSMutableDictionary alloc]init];
    

    
    _database=[[DBHelper alloc]init];
    _db=[_database getDatabase];
    
    [_db executeUpdate:@"CREATE TABLE drivelist (id text, count text,type integer,carType text,answer text,answerA text,answerB text,answerC text,answerD text,image text,explain text,isError integer,isCollect integer,isDebar integer)"];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"homeTitle" ofType:@"txt"];
    _tempArray=[NSKeyedUnarchiver unarchiveObjectWithFile:imagePath];
    NSLog(@"%d",[_tempArray count]);

    for (int i=0; i<[_tempArray count]; i++) {
        NSString*sql=[NSString stringWithFormat:@"INSERT INTO drivelist(id,count,type,carType,answer,answerA,answerB,answerC,answerD,image,explain,isError,isCollect,isDebar) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)"];
        ExamItem*item=[_tempArray objectAtIndex:i];
        
        [_db executeUpdate:sql,item.uid,item.count,item.type,item.carType,item.answer,item.answerA,item.answerB,item.answerC,item.answerD,item.image,item.explain,item.isError,item.isCollect,item.isDebar];
        
    }
    [_dataCountArray addObjectsFromArray:_tempArray];
    NSLog(@"%d",[_dataCountArray count]);
    
    
    [self selectData:0:10];
    currentIndex = 0;
    [super viewDidLoad];
    [self indexChange:1];
    minMoveWidth = self.view.frame.size.width /5.0f;
    	// Do any additional setup after loading the view.
}
-(void)selectData:(NSInteger)index :(NSInteger)count
{
    [_dataArray removeAllObjects];
    NSString*sql=[NSString stringWithFormat:@"SELECT count,id,type,carType,answer,answerA,answerB,answerC,answerD,image,explain,isError,isCollect,isDebar FROM drivelist limit %d,%d",index,count];
    FMResultSet *rs = [_db executeQuery:sql];
    while ([rs next]) {
        ExamItem*item=[[ExamItem alloc]init];
        item.uid=[rs stringForColumn:@"id"];
        item.count=[rs stringForColumn:@"count"];
        item.type=[rs stringForColumn:@"type"];
        item.carType=[rs stringForColumn:@"carType"];
        item.answer=[rs stringForColumn:@"answer"];
        item.answerA=[rs stringForColumn:@"answerA"];
        item.answerB=[rs stringForColumn:@"answerB"];
        item.answerC=[rs stringForColumn:@"answerC"];
        item.answerD=[rs stringForColumn:@"answerD"];
        item.image=[rs stringForColumn:@"image"];
        item.explain=[rs stringForColumn:@"explain"];
        item.isError=[rs stringForColumn:@"isError"];
        item.isCollect=[rs stringForColumn:@"isCollect"];
        item.isDebar=[rs stringForColumn:@"isDebar"];
        
//                [_dict setValue:[rs stringForColumn:@"id"] forKey:@"id"];
//                [_dict setValue:[rs stringForColumn:@"count"] forKey:@"count"];
//                [_dict setValue:[rs stringForColumn:@"type"] forKey:@"type"];
//                [_dict setValue:[rs stringForColumn:@"carType"]forKey:@"carType"];
//                [_dict setValue:[rs stringForColumn:@"answer"] forKey:@"answer"];
//                [_dict setValue:[rs stringForColumn:@"answerA"] forKey:@"answerA"];
//                [_dict setValue:[rs stringForColumn:@"answerB"] forKey:@"answerB"];
//                [_dict setValue:[rs stringForColumn:@"answerC"] forKey:@"answerC"];
//                [_dict setValue:[rs stringForColumn:@"answerD"] forKey:@"answerD"];
//                [_dict setValue:[rs stringForColumn:@"image"] forKey:@"image"];
//                [_dict setValue:[rs stringForColumn:@"explain"] forKey:@"emplain"];
//                [_dict setValue:[rs stringForColumn:@"isError"] forKey:@"isError"];
//                [_dict setValue:[rs stringForColumn:@"isCollect"] forKey:@"isCollect"];
//                [_dict setValue:[rs stringForColumn:@"isDebar"] forKey:@"isDebar"];
//        ExamItem*item=[[ExamItem alloc]initWithDictionary:_dict];
        [_dataArray addObject:item];
        
    }
    
    [_dataCountArray addObjectsFromArray:_dataArray];
    NSString*strFilePath=[NSHomeDirectory() stringByAppendingString:@"/Documents/homeTitle.txt"];
    [NSKeyedArchiver archiveRootObject:_dataCountArray toFile:strFilePath];
    

    NSLog(@"%d",[_dataCountArray count]);
    
    [rs close];
}
-(PageView *)createView:(int)index
{
    NSLog(@"%d",index);
   
    _indexRecod=index-1;
    NSMutableString *string = [NSMutableString string];
    _vi = [[PageView alloc] initWithFrame:self.view.bounds txt:string] ;
     _vi.tag=index+10000-1;
    NSLog(@"%d",_vi.tag);
    [_indexArray addObject:_vi];
   
    NSLog(@"%d",_vi.tag);
    
    for(int i=0;i<100;i++)
    {
        [string appendFormat:@"%d",index,nil];
        
    }
    
    ExamItem*item=[_dataCountArray objectAtIndex:index-1];
    NSLog(@"%@",item.answerA);
    
   
    _backImage=[[UIImageView alloc]initWithFrame:self.view.bounds];
    _backImage.userInteractionEnabled=YES;
    _backImage.backgroundColor=[UIColor purpleColor];
    UILabel*quest=[[UILabel alloc]initWithFrame:CGRectMake(10, 10,SCREEN_WIDTH-20, 100)];
    quest.numberOfLines=0;
    quest.text=item.count;
    [_backImage addSubview:quest];
    [_vi addSubview:_backImage];
    for (int i=0; i<4; i++) {
        _iView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 150+(i*60), SCREEN_WIDTH-40, 35)];
        _iView.userInteractionEnabled=YES;
        _iView.backgroundColor=[UIColor blackColor];
        _iView.tag=i;
        
        [_backImage addSubview:_iView];
    }
    switch ([item.type integerValue]) {
    case 1:
        {
            UILabel*answer=[[UILabel alloc]initWithFrame:CGRectMake(20, 100, SCREEN_WIDTH-40, 30)];
            answer.text=item.answer;
            [_backImage addSubview:answer];
        }
        break;
    case 2:
        {
    
            
          
            _answerA=[UIButton buttonWithType:UIButtonTypeSystem];
            _answerA.frame=CGRectMake(10, 150, 100, 40);
            
            _answerA.tag=10;
            [_answerA setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [_answerA setTitle:item.answerA forState:UIControlStateNormal];
            [_btnArray addObject:_answerA];
            [_answerA addTarget: self action:@selector(btnA:) forControlEvents:UIControlEventTouchUpInside];
            [_backImage addSubview:_answerA];
           
            _answerB=[UIButton buttonWithType:UIButtonTypeSystem];
            _answerB.frame=CGRectMake(10, 150+(1*60), 100, 40) ;
            _answerB.tag=11;
            [_answerB setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [_answerB addTarget:self action:@selector(btnB:) forControlEvents:UIControlEventTouchUpInside];
            [_answerB setTitle:item.answerB forState:UIControlStateNormal];
            [_backImage addSubview:_answerB];
            [_btnArray addObject:_answerB];
           
            
           
            _answerC=[UIButton buttonWithType:UIButtonTypeSystem];
            _answerC.frame=CGRectMake(10, 150+(2*60), 100, 40);
            _answerC.tag=12;
            [_answerC setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [_answerC setTitle:item.answerC forState:UIControlStateNormal];
            [_answerC addTarget:self action:@selector(btnC:) forControlEvents:UIControlEventTouchUpInside];
            [_backImage addSubview:_answerC];
            [_btnArray addObject:_answerC];
           
          
          
            _answerD=[UIButton buttonWithType:UIButtonTypeSystem];
            _answerD.frame=CGRectMake(10, 150+(3*60), 100, 40);
            [_answerD setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            _answerD.tag=13;
            [_answerD setTitle:item.answerD forState:UIControlStateNormal];
            [_answerD addTarget:self action:@selector(btnD:) forControlEvents:UIControlEventTouchUpInside];
            [_backImage addSubview:_answerD];
            [_btnArray addObject:_answerD];

        
        
         

        }
        break;
        
    default:
        break;
    }
  
    _vi.hidden = YES;
    _vi.delegate = self;
    return _vi;
}
-(void)btnA:(UIButton*)btn
{
     NSLog(@"%d",_vi.tag);
    PageView*page=[_indexArray objectAtIndex:[_indexArray count]-1];
    NSLog(@"%d",page.tag);
    NSLog(@"%d",[_indexArray count]);
    NSLog(@"%d",_indexRecod);
   
    for(PageView*page in _indexArray)
    {
        if (page.tag==_indexRecod+10000-1) {
            UIButton*btA=(UIButton*)[page viewWithTag:10];
            [btA setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            UIButton*btB=(UIButton*)[page viewWithTag:11];
            [btB setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            UIButton*btC=(UIButton*)[page viewWithTag:12];
            [btC setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            UIButton*btD=(UIButton*)[page viewWithTag:13];
            [btD setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }
    }
 
   
    
    

   
  
}
-(void)btnB:(UIButton*)btn
{
    for(PageView*page in _indexArray)
    {
        if (page.tag==_indexRecod+10000-1) {
            UIButton*btA=(UIButton*)[page viewWithTag:10];
            [btA setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            UIButton*btB=(UIButton*)[page viewWithTag:11];
            [btB setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            UIButton*btC=(UIButton*)[page viewWithTag:12];
            [btC setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            UIButton*btD=(UIButton*)[page viewWithTag:13];
            [btD setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }
    }
  
   
}
-(void)btnC:(UIButton*)btn
{
    for(PageView*page in _indexArray)
    {
        if (page.tag==_indexRecod+10000-1) {
            UIButton*btA=(UIButton*)[page viewWithTag:10];
            [btA setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            UIButton*btB=(UIButton*)[page viewWithTag:11];
            [btB setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            UIButton*btC=(UIButton*)[page viewWithTag:12];
            [btC setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            UIButton*btD=(UIButton*)[page viewWithTag:13];
            [btD setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }
    }
   
}
-(void)btnD:(UIButton*)btn
{
    for(PageView*page in _indexArray)
    {
        if (page.tag==_indexRecod+10000-1) {
            UIButton*btA=(UIButton*)[page viewWithTag:10];
            [btA setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            UIButton*btB=(UIButton*)[page viewWithTag:11];
            [btB setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            UIButton*btC=(UIButton*)[page viewWithTag:12];
            [btC setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            UIButton*btD=(UIButton*)[page viewWithTag:13];
            [btD setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
    }
  
}

-(void) indexChange:(int)newIndex
{
   
    if(currentIndex == newIndex)
    
        return;
    if(currentIndex ==0)
    {
        [self setVisitPage:[self createView:newIndex]];
        [self.view addSubview:self.visitPage];
        self.visitPage.hidden = NO;
    }
    if(newIndex>0)
    {
        if (newIndex>=currentIndex)
        {
            if(self.prePage)
            {
                [self.prePage removeFromSuperview];
                
            }
            if(newIndex>1)
            {
                [self setPrePage:self.visitPage];
                [self setVisitPage:self.nextPage];
            }
            //添加数据
            if (((newIndex)%10)==0) {
                [self selectData:newIndex :10];
            }
            [self setNextPage:[self createView:newIndex+1]];
          
            [self.view insertSubview:self.nextPage  atIndex:0];
        }
        else
        {
            if(self.nextPage)
            {
                [self.nextPage removeFromSuperview];
            }
            [self setNextPage:self.visitPage];
            [self setVisitPage:self.prePage];
            if(newIndex > 1)
            {
                [self setPrePage:[self createView:newIndex-1]];
                
                [self.view addSubview:self.prePage];
            }
            else
            {
                [self setPrePage:nil];
            }
        }
        //滑动位置
        NSLog(@"%d",newIndex);
       
        currentIndex = newIndex;
    }

}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    float x = [touch locationInView:self.view].x;
    startX = x;
    fromLeft = x< self.view.frame.size.width /2;
    tap = YES;
}
-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if(fromLeft && currentIndex <=1)
        return;
    UITouch *touch = [touches anyObject];
    float x = [touch locationInView:self.view].x;
    //CGRect rect = _visitPage.frame;
    if (fromLeft) {
        //self.nextPage.hidden = NO;
        if(self.prePage)
        {
           self.prePage.hidden = NO;
           self.nextPage.hidden = YES;
           [_prePage move:x animation:NO];
        }
        
    }
    else
    {
        self.prePage.hidden = YES;
        self.nextPage.hidden = NO;
        [_visitPage move:x animation:NO];

    }
    tap = NO;
    
}
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    float x = [touch locationInView:self.view].x;
    
    if (!fromLeft && (tap||startX - x >minMoveWidth))
    {
        [self.view setUserInteractionEnabled:NO];
        self.nextPage.hidden = NO;
        nextPageIndex = currentIndex+1;
        [_visitPage move:-self.view.frame.size.width animation:YES];
    }
    else if(!fromLeft && startX - x <=minMoveWidth)
    {
        [self.view setUserInteractionEnabled:NO];
        [_visitPage move:self.view.frame.size.width animation:YES];
    }
    else if(currentIndex >1)
    {
        [self.view setUserInteractionEnabled:NO];
        _prePage.hidden = NO;
        if (fromLeft && (tap||x-  startX >minMoveWidth))
        {
            nextPageIndex = currentIndex-1;
            [_prePage move:self.view.frame.size.width animation:YES];
        }
        else if(fromLeft &&  x - startX<=minMoveWidth)
        {
            [_prePage move:-self.view.frame.size.width animation:YES];
        }
    }
}
-(void) didFinishMove
{
    [self indexChange:nextPageIndex];
    [self.view setUserInteractionEnabled:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
