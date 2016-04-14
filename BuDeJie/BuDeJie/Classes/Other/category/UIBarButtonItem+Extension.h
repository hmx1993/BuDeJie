//
//  UIBarButtonItem+Extension.h
//  BuDeJie
//
//  Created by hemengxiang on 16/3/27.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+(instancetype)itemWithImage:(NSString *)image heighLightImage:(NSString *)heighLightImage target:(id)target action:(SEL)action;
+(instancetype)itemWithImage:(NSString *)image selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action;
@end
