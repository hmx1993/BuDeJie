//
//  HMXTopicPictureView.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/15.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXTopicPictureView.h"
#import "HMXSeeBigPictureController.h"
@interface HMXTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;

@property (weak, nonatomic) IBOutlet UIButton *seeBigImage;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation HMXTopicPictureView

//给ImageView添加点击手势
-(void)awakeFromNib
{
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeOriginalImage)]];
}

//当点击图片的时候调用
-(void)seeOriginalImage
{
    HMXSeeBigPictureController *bigPictureVc = [[HMXSeeBigPictureController alloc] init];
    //传模型
    bigPictureVc.topics = self.topics;
    
    [self.window.rootViewController presentViewController:bigPictureVc animated:YES completion:nil];
}

-(void)setTopics:(HMXTipicsItem *)topics
{
    _topics = topics;
    
    //如果是gif,就将gif图片显示,并且将seeBigImage隐藏
    self.gifImageView.hidden = !topics.is_gif;
    self.seeBigImage.hidden = !topics.isLong;
    
    //占位图片
    UIImage *placeHodlerImage = nil;
    
    [self.imageView hmx_setImageWithOriginalImageUrl:topics.image1 thumbnailImageUrl:topics.image0 placeHodlerImage:placeHodlerImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        //图片下载完成后会来到这个block
        //下载失败.直接返回
        if (!image) return;
        //如果不是长图,直接返回
        if(!topics.isLong) return;
        
        //重绘获取图片
        //开启图形上下文
        UIGraphicsBeginImageContext(topics.middelViewframe.size);
        
        //draw
        CGRect rect = CGRectMake(0, 0, topics.middelViewframe.size.width, topics.middelViewframe.size.width * topics.height / topics.width);
        [image drawInRect:rect];
        //从当前上下文中获取图片
        UIImage *shortImage = UIGraphicsGetImageFromCurrentImageContext();
        
        //关闭图形上下文
        UIGraphicsEndImageContext();
        
        //重新设置图片
        self.imageView.image = shortImage;
        
    }] ;
}
@end
