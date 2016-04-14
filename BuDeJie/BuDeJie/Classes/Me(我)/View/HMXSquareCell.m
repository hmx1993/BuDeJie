//
//  HMXSquareCell.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/7.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXSquareCell.h"
#import <UIImageView+WebCache.h>
#import "HMXSqaureItem.h"
@interface HMXSquareCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation HMXSquareCell

-(void)setSqaureItem:(HMXSqaureItem *)sqaureItem
{
    _sqaureItem = sqaureItem;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:sqaureItem.icon]];
    self.nameLabel.text = sqaureItem.name;
    
}

@end
