//
//  DSFindTeacherTableViewCell.m
//  DriveSchool
//
//  Created by 张学成 on 15/3/3.
//  Copyright (c) 2015年 张学成. All rights reserved.
//

#import "DSFindTeacherTableViewCell.h"

@implementation DSFindTeacherTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.moneyLabel.frame = CGRectMake(CURRENT_WIDTH-70, self.moneyLabel.frame.origin.y, self.moneyLabel.frame.size.width, self.moneyLabel.frame.size.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
