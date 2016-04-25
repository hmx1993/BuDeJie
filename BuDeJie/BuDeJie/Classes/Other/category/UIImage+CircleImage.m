//
//  UIImage+CircleImage.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/6.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "UIImage+CircleImage.h"

@implementation UIImage (CircleImage)

-(UIImage *)circleImage
{
        //1.0 开启图形上下文
        /*
         第一个参数:图形上下文的大小
         第二个参数:不透明度
         第三个参数:scale比例因素 点:像素 传0表示自动识别像素比
         */
        UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
        
        //2.0 描述裁剪路径
        UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width , self.size.height)];
        
        //3.0 设置为裁剪区域
        [clipPath addClip];
        
        //4.0 画图片
        [self drawAtPoint:CGPointZero];
        
        //5.0 从图形上下文中获取图片
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        //6.0 关闭图形上下文
        UIGraphicsEndImageContext();
        
        return image;
}

+(UIImage *)hmx_circleImageWithImageName:(NSString *)imageName;
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image circleImage];
}

@end
