//
//  DSNewSubjectThreeTableViewCell.h
//  DriveSchool
//
//  Created by 张学成 on 15/5/12.
//  Copyright (c) 2015年 张学成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSNewSubjectThreeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *teacherPhoto;
@property (weak, nonatomic) IBOutlet UILabel *teachAgeLabel;
@property (weak, nonatomic) IBOutlet UIButton *bookIngButton;

@end
