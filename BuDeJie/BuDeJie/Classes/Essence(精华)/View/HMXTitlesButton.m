//
//  HMXTitlesButton.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/9.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXTitlesButton.h"

@implementation HMXTitlesButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        //设置普通和选中状态下的颜色
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];

    }
    return self;
}

/**
 *  取消按钮的高亮状态
 */

-(void)setHighlighted:(BOOL)highlighted
{
    
}
@end
