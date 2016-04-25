//
//  HMXDIYHeader.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/23.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXDIYHeader.h"


@interface HMXDIYHeader ()

@property(nonatomic,weak)UISwitch *s;

@end

@implementation HMXDIYHeader

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        UISwitch *s = [[UISwitch alloc] init];
        [self addSubview:s];
        self.s = s;
    }

    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.s.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
}


//监听刷新空间的状态
-(void)setState:(MJRefreshState)state
{
    [super setState:state];
    
    switch (state) {
        case MJRefreshStateIdle: {// 普通
            [self.s setOn:NO animated:YES];
            
            [UIView animateWithDuration:0.25 animations:^{
                self.s.transform = CGAffineTransformIdentity;
            }];
            break;
        }
            
        case MJRefreshStateRefreshing:
        case MJRefreshStatePulling: {// 松开就可以刷新
            [self.s setOn:YES animated:YES];
            
            [UIView animateWithDuration:0.25 animations:^{
                self.s.transform = CGAffineTransformMakeRotation(M_PI_2);
            }];
            break;
        }
            
        default:
            break;
    }
}

@end
