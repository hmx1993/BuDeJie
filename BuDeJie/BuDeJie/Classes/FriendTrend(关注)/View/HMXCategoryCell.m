//
//  HMXCategoryCell.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/25.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXCategoryCell.h"
#import "CategoryItem.h"
@interface HMXCategoryCell ()

@property(nonatomic,weak)IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *indicator;

@end

@implementation HMXCategoryCell

-(void)awakeFromNib
{
//    //如果一个cell处于被选中的状态,那么,它里面的子控件都将进入高量状态;如果,按钮取消选中,那么,里面的自控家都将取消高亮状态
//    self.nameLabel.highlightedTextColor = [UIColor redColor];
    
}

-(void)setCategoryItem:(CategoryItem *)categoryItem
{
    _categoryItem = categoryItem;
    self.nameLabel.text = categoryItem.name;
}

//当想在cell被选中或者取消选中的时候做什么事情就可以在这个方法中做事情
-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected) {//选中
        self.nameLabel.textColor = [UIColor redColor];
        self.indicator.hidden = NO;
    }else{//取消选中
        self.nameLabel.textColor = [UIColor blackColor];
        self.indicator.hidden = YES;
    }
}

@end
