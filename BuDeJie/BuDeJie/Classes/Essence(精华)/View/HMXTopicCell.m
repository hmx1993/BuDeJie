//
//  HMXTopicCell.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/14.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXTopicCell.h"
#import "HMXTipicsItem.h"
#import <UIImageView+WebCache.h>
@interface HMXTopicCell();

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;

@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;

@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (weak, nonatomic) IBOutlet UILabel *top_cmtLabel;
@property (weak, nonatomic) IBOutlet UIView *topCmtView;

@end

@implementation HMXTopicCell
//点击更多按钮时调用
- (IBAction)more:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {//点击了相应的按钮时调用
        NSLog(@"点击了[收藏]按钮");
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {//点击了相应的按钮时调用
        NSLog(@"点击了[举报]按钮");
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {//点击了相应的按钮时调用
        NSLog(@"点击了[取消]按钮");
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

//设置cell的背景图片
-(void)awakeFromNib
{
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

//给cell内部控件设置数据
-(void)setTopics:(HMXTipicsItem *)topics
{
    _topics = topics;
    //头像
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topics.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //昵称
    self.nameLabel.text = topics.name;
    //发布时间
    self.passtimeLabel.text = topics.passtime;
    //正文
    self.text_label.text = topics.text;
    
    //踩
    [self setButtonTitleWith:self.caiButton number:topics.cai placeHolder:@"踩"];
    //顶
    [self setButtonTitleWith:self.dingButton number:topics.ding placeHolder:@"顶"];
    //转发数
    [self setButtonTitleWith:self.repostButton number:topics.repost placeHolder:@"转发"];
    //评论数
    [self setButtonTitleWith:self.commentButton number:topics.comment placeHolder:@"评论"];
    
    //最热评论
    if (topics.top_cmt.count)// 有最热评论
    {
        self.topCmtView.hidden = NO;
        
        //评论者的昵称
        NSString *name = topics.top_cmt.firstObject[@"user"][@"username"];
        //评论的内容
        NSString *content = topics.top_cmt.firstObject[@"content"];
        NSString *topCmt = [NSString stringWithFormat:@"%@:%@",name,content];
        if (content.length == 0)
        {//如果没有内容,就是个语音评论
            topCmt = [NSString stringWithFormat:@"%@:[语音评论]",name];
        }
        self.top_cmtLabel.text = topCmt;
        
    }else//没有最热评论
    {
        self.topCmtView.hidden = YES;
    }
}
//封装的方法
-(void)setButtonTitleWith:(UIButton *)button number:(NSInteger)number placeHolder:(NSString *)placeHoder
{
    //踩
    NSString *str = [NSString stringWithFormat:@"%zd",number];
    if (number >= 10000) {
        CGFloat numberF = number / 10000.0;
        str = [NSString stringWithFormat:@"%.1f万",numberF];
    }
    if (number == 0) {
        str = placeHoder;
    }
    [button setTitle:str forState:UIControlStateNormal];
}
//给cell设置10的间距
-(void)setFrame:(CGRect)frame
{
    frame.size.height -= HMXMargin;
    [super setFrame:frame];
}

@end
