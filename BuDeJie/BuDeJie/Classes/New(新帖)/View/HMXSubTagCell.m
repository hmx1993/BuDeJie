//
//  HMXSubTagCell.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/6.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXSubTagCell.h"
#import <UIImageView+WebCache.h>
#import "HMXSubTagItem.h"
@interface HMXSubTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end

@implementation HMXSubTagCell

-(void)setSubTagItem:(HMXSubTagItem *)subTagItem
{
    _subTagItem = subTagItem;
    
    //设置图像
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:subTagItem.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //完成后的回调传过来的是一张从网络上下载好的图片
        //将图片进行裁剪
        
        //如果图片为空,就直接返回
        if (image == nil) return;

        //设置裁剪后的图片
        self.iconView.image = [image circleImage];
    }];
    
    //设置用户名
    self.nameLabel.text = subTagItem.theme_name;
    
    //设置订阅量
    NSString *numStr = [NSString stringWithFormat:@"%@人订阅",subTagItem.sub_number];
    //将numStr中的数字转换为整数,字符不管
    NSInteger num = numStr.integerValue;
    
    if (num > 10000) {
        
        CGFloat numF = num / 10000.0;
        //保留一位小数
        numStr = [NSString stringWithFormat:@"%.1f万人订阅",numF];
        //替换10.0这种类型的数字
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    
    self.numLabel.text = numStr;
}

////裁剪图片
//-(void)awakeFromNib
//{
//    //设置圆角半径
//    self.iconView.layer.cornerRadius = self.iconView.width * 0.5 ;
//    //超过裁剪区域的都会被裁剪掉
//    self.iconView.layer.masksToBounds = YES;
//}

//调整cell的frame
-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    //给cell 的frame 赋值
    [super setFrame:frame];
}

@end
