//
//  HMXFastLoginBtn.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/7.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXFastLoginBtn.h"

@implementation HMXFastLoginBtn

-(void)layoutSubviews
{
  
    [super layoutSubviews];
    
    //重新设置按钮内部子控件的位置(在调用父类的方法之后就将按钮内部的控件的位置和尺寸算好了)
    //调整图片的位置
    self.imageView.centerX = self.bounds.size.width * 0.5;
    self.imageView.y = 0;
    
    //设置按钮的内容自适应
    [self.titleLabel sizeToFit];
    
    //调整文字标签的位置
    self.titleLabel.centerX = self.bounds.size.width * 0.5;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
}
@end
