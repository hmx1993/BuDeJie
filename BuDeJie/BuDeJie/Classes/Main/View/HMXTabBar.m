//
//  HMXTabBar.m
//  BuDeJie
//
//  Created by hemengxiang on 16/3/27.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXTabBar.h"

@interface HMXTabBar ()
@property(nonatomic,strong)UIButton *plusBtn;
@end

@implementation HMXTabBar

//在初始化HMXTabBar的时候添加加号按钮
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加加号按钮
        UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.plusBtn = plusBtn;
        //设置按钮的图片
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        
        //添加加号按钮
        [self addSubview:plusBtn];
    }
    return self;
}


//布局子控件的位置
-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置发布按钮的frame
    self.plusBtn.bounds = CGRectMake(0, 0, self.plusBtn.currentBackgroundImage.size.width, self.plusBtn.currentBackgroundImage.size.height);
    self.plusBtn.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
    //遍历自己当前所拥有的所有子控件,设置其他UITabBarButton的位置
    CGFloat height = self.height;
    CGFloat width = self.width / 5.0;
    CGFloat y = 0;
    NSInteger index = 0;
   
    for (UIView *btn in self.subviews) {
        if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            //改变尺寸
            //如果按钮的角标大于1,就让它显示往后面一个位置显示,给发布按钮留出位置来
            btn.frame = CGRectMake(width * ((index > 1)?(index + 1):index), y, width, height);
            index++;
        }
    }
}

@end
