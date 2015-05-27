//
//  DSFindSchoolTableViewCell.m
//  DriveSchool
//
//  Created by 张学成 on 15/3/4.
//  Copyright (c) 2015年 张学成. All rights reserved.
//

#import "DSFindSchoolTableViewCell.h"

@implementation DSFindSchoolTableViewCell

- (void)awakeFromNib {
    _moneyLabel.frame = CGRectMake(CURRENT_WIDTH-_moneyLabel.frame.size.width-20, _moneyLabel.frame.origin.y, _moneyLabel.frame.size.width, _moneyLabel.frame.size.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
