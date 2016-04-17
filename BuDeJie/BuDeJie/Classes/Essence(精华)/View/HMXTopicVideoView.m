//
//  HMXTopicVideoView.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/15.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXTopicVideoView.h"

#import "HMXSeeBigPictureController.h"
@interface HMXTopicVideoView ()

@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;

@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation HMXTopicVideoView

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
    
    //播放次数
    NSString *playCountStr = [NSString stringWithFormat:@"%zd次播放",topics.playcount];
    if (topics.playcount >= 10000) {
        CGFloat playCountF = topics.playcount / 10000.0;
        playCountStr = [NSString stringWithFormat:@"%.1f万次播放",playCountF];
    }
    self.playcountLabel.text = playCountStr ;
    
    //视频时长
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",topics.videotime / 60,topics.videotime % 60];
    
    //图片
    UIImage *placeHodlerImage = nil;
    [self.imageView hmx_setImageWithOriginalImageUrl:self.topics.image1 thumbnailImageUrl:self.topics.image0 placeHodlerImage:placeHodlerImage completed:nil];
}

@end
