//
//  HMXTipicsItem.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/12.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXTipicsItem.h"

@implementation HMXTipicsItem

-(CGFloat)cellHeight
{
    //如果已经经过计算,就直接返回
    if (_cellHeight) return _cellHeight;
    
    //计算cell中固定内容的高度
    //文字的Y值
    _cellHeight += 55;
    
    //文字的高度
    CGSize textMaxSize = CGSizeMake(HMXScreenW - 2 * HMXMargin, MAXFLOAT);
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height + HMXMargin;
    
    //计算cell中间View的高度(只要不是段子,就得增加相应图片的高度)
    if (self.type != HMXTopTypeWord) {
        
        //根据服务器返回的图片的宽高比来显示图片
        CGFloat hmx_middelViewH = textMaxSize.width * self.height/self.width;
        CGFloat hmx_middelViewW = textMaxSize.width;
        
        //如果图片的高度超过一个屏幕
        if (hmx_middelViewH >= HMXScreenH) {
            hmx_middelViewH = HMXScreenH * 0.3;
            self.isLong = YES;
        }
        
        CGFloat hmx_middelViewX = HMXMargin;
        CGFloat hmx_middelViewY = _cellHeight;
        
        self.middelViewframe = CGRectMake(hmx_middelViewX, hmx_middelViewY, hmx_middelViewW, hmx_middelViewH);
        
        _cellHeight += hmx_middelViewH + HMXMargin;
    }
    
    //计算最热评论的高度
    //最热评论
    if (self.top_cmt.count)// 有最热评论
    {
        //"最热评论"标签的高度
        _cellHeight += 21;
        
        //评论
        NSString *name = self.top_cmt.firstObject[@"user"][@"username"];
        NSString *content = self.top_cmt.firstObject[@"content"];
        NSString *topCmt = [NSString stringWithFormat:@"%@:%@",name,content];
        if (content.length == 0)
        {//如果没有内容,就是个语音评论
            topCmt = [NSString stringWithFormat:@"%@:[语音评论]",name];
        }
        
        //评论的高度
        _cellHeight += [topCmt boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height + HMXMargin;
    }
    //工具条的高度
    _cellHeight += 35 + HMXMargin;
    return _cellHeight;
}

@end
