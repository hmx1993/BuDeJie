//
//  HMXTopicVoiceView.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/15.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXTopicVoiceView.h"
#import "HMXSeeBigPictureController.h"
@interface HMXTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;

@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picture;

@end

@implementation HMXTopicVoiceView

//给ImageView添加点击手势
-(void)awakeFromNib
{
    
    self.picture.userInteractionEnabled = YES;
    [self.picture addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeOriginalImage)]];
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
    
    //声音时长
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",topics.voicetime / 60,topics.voicetime % 60];
    
    //图片
    UIImage *placeHodlerImage = nil;
    [self.picture hmx_setImageWithOriginalImageUrl:self.topics.image1 thumbnailImageUrl:self.topics.image0 placeHodlerImage:placeHodlerImage completed:nil];
}

@end
