//
//  UIImage+CircleImage.h
//  BuDeJie
//
//  Created by hemengxiang on 16/4/6.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CircleImage)

//生成一张圆角图片
-(UIImage *)circleImage;
//生成一张圆角图片
+(UIImage *)hmx_circleImageWithImageName:(NSString *)imageName;

@end
