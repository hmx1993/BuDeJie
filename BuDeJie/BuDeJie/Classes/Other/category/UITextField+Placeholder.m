//
//  UITextField+Placeholder.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/7.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "UITextField+Placeholder.h"
#import <objc/message.h>
@implementation UITextField (Placeholder)

// 最佳方案:
/*
 //实现setter和getter方法
 -(void)setPlaceholderColor:(UIColor *)placeholderColor
 {
 //文本框是懒加载的,只有存在占位文字的时候才会加载控件,如果外界先设置文本框文字的颜色,再去设置占位文字,那么,这时候文本框的文字标签是为空的,所以设置会无效
 if (self.placeholder == nil) {
 self.placeholder = @" ";
 }
 UILabel *place = [self valueForKey:@"placeholderLabel"];
 place.textColor = placeholderColor;
 
 }
 
 -(UIColor *)placeholderColor
 {
 UILabel *place = [self valueForKey:@"placeholderLabel"];
 return place.textColor;
 }
 */

//方案二:使用runtime

//交换方法
+(void)load
{
    
    Method M1 = class_getInstanceMethod(self, @selector(setHMX_placeholder:));
    Method M2 = class_getInstanceMethod(self, @selector(setPlaceholder:));
    method_exchangeImplementations(M1, M2);
}

//设置占位文字
-(void)setHMX_placeholder:(NSString *)placeholder
{
    //设置占位文字
    [self setHMX_placeholder:placeholder];
    
    //设置占位文字颜色
    [self setPlaceholderColor:self.placeholderColor];
    
}

//设置占位文字颜色
-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    //1.把文字颜色先保存起来
    objc_setAssociatedObject(self, @"placeholderColor",placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //2.等真正设置文字的时候再去设置文字颜色
    //获取文字控件
    UILabel *place = [self valueForKey:@"placeholderLabel"];
    place.textColor = placeholderColor;
    
}

//获取文字颜色
-(UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, @"placeholderColor");
}

@end
