//
//  HMXLoginTextField.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/7.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXLoginTextField.h"
#import "UITextField+Placeholder.h"
@implementation HMXLoginTextField

/*
 1.设置文本框的占位文字颜色为灰色
 2.光标所在的文本框占位文字颜色设置为白色
 */

-(void)awakeFromNib
{
    //设置文本框的占位颜色
    //1.设置光标的颜色
    self.tintColor = [UIColor whiteColor];
    
    //2.设置占位文字的颜色(第一个参数表示要给哪个文字设置富文本属性)
//    NSMutableDictionary *attri = [NSMutableDictionary dictionary];
//    attri[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attri];
    
    
//    UILabel *placeLabel = [self valueForKey:@"placeholderLabel"];
//    placeLabel.textColor = [UIColor lightGrayColor];
    
    //利用自己定义的分类
    self.placeholderColor = [UIColor lightGrayColor];
    
    //3.光标所在的文本框占位文字颜色设置为白色
    //3.1监听文本框的点击 1.代理 2.通知 3.target (在开发中一定不要让自己成为自己的代理)
    [self addTarget:self action:@selector(beginEditing) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(endEditing) forControlEvents:UIControlEventEditingDidEnd];
}

//开始编辑时调用
-(void)beginEditing
{
//    UILabel *placeLabel = [self valueForKey:@"placeholderLabel"];
//    placeLabel.textColor = [UIColor whiteColor];
    
    //利用自己定义的分类
    self.placeholderColor = [UIColor whiteColor];
}

//结束编辑时调用
-(void)endEditing
{
//    UILabel *placeLabel = [self valueForKey:@"placeholderLabel"];
//    placeLabel.textColor = [UIColor lightGrayColor];
   
    //利用自己定义的分类
    self.placeholderColor = [UIColor lightGrayColor];
}
@end
