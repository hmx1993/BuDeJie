//
//  UIBarButtonItem+Extension.m
//  BuDeJie
//
//  Created by hemengxiang on 16/3/27.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

//设置高亮的方法
+(instancetype)itemWithImage:(NSString *)image heighLightImage:(NSString *)heighLightImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:heighLightImage] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //设置按钮的尺寸为自适应,此时按钮的尺寸并不大,但是当鼠标点击按钮右侧很远的位置的时候这个按钮也会被点击,为了解决这个问题,可以换用一个View将按钮包装起来,然后用item将View包装起来
    UIView *view = [[UIView alloc] initWithFrame:btn.bounds];
    [view addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:view] ;
}

//夜间模式的月亮按钮是处于选中状态,不是高亮状态,因此要提供一个设置选中状态的方法
+(instancetype)itemWithImage:(NSString *)image selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn] ;
}

@end
