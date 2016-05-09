//
//  HMXTopicVoiceView.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/15.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXTopicVoiceView.h"
#import "HMXSeeBigPictureController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "PlayAndPuaseBtn.h"
@interface HMXTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;

@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picture;

//播放器
@property(nonatomic,strong)AVPlayer *player;

//播放和暂停按钮
@property (weak, nonatomic) IBOutlet PlayAndPuaseBtn *playAndPuaseBtn;

@end

@implementation HMXTopicVoiceView


-(AVPlayer *)player
{
    if (_player == nil) {
        
        //根据url创建一个item
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.topics.voiceuri]];
        
        AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
        
        _player = player;
        
    }
    return _player;
}

- (IBAction)playAndPuaseBtn:(PlayAndPuaseBtn *)sender {
    
    self.playAndPuaseBtn.selected = !sender.selected;
    
    if (self.playAndPuaseBtn.selected) {
        
        [self.player play];
        
        [self.playAndPuaseBtn setImage:[UIImage imageNamed:@"playButtonPause"] forState:UIControlStateSelected];
    }else{
        
        [self.player pause];
        
        [self.playAndPuaseBtn setImage:[UIImage imageNamed:@"playButtonPlay"] forState:UIControlStateNormal];
    }
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
