//
//  HMXTopicVideoView.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/15.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXTopicVideoView.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@interface HMXTopicVideoView ()

@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;

@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

//播放控制器
@property(nonatomic,strong)AVPlayerViewController *playerVC;

//播放器
@property(nonatomic,strong)AVPlayer *player;

@end

@implementation HMXTopicVideoView
#pragma mark - 懒加载
-(AVPlayerViewController *)playerVC
{
    if (_playerVC == nil) {
        
        AVPlayerViewController * playerVC = [[AVPlayerViewController alloc] init];
        _playerVC = playerVC;
    }
    return _playerVC;
}

//给ImageView添加点击手势
-(void)awakeFromNib
{
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeOriginalImage)]];
}


//当点击视频图片的时候调用:播放视频
-(void)seeOriginalImage
{
    
    if (_player == nil) {
        
        //根据url创建一个播放器
        AVPlayer* player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:self.topics.videouri]];
        self.playerVC.player = player;
        self.player = player;
    }
    [self.window.rootViewController presentViewController:self.playerVC animated:YES completion:nil];
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
