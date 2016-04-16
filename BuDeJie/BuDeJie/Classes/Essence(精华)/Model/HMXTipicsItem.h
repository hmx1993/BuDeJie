//
//  HMXTipicsItem.h
//  BuDeJie
//
//  Created by hemengxiang on 16/4/12.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface HMXTipicsItem : NSObject

/** 用户的名字 */
@property (nonatomic, strong) NSString *name;
/** 用户的头像 */
@property (nonatomic, strong) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, strong) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, strong) NSString *passtime;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
/** 最热评论 */
@property (nonatomic, strong) NSArray *top_cmt;
/** 帖子的类型 */
@property(nonatomic,assign)NSInteger type;

//声音
/** 播放次数 */
@property(nonatomic,assign)NSInteger playcount;
/** 时长 */
@property(nonatomic,assign)NSInteger voicetime;
/** 小图  */
@property (nonatomic, strong) NSString *image0;
/** 大图  */
@property (nonatomic, strong) NSString *image1;
/** 中图  */
@property (nonatomic, strong) NSString *image2;


//cell相关
/** cell的高度 */
@property(nonatomic,assign)CGFloat cellHeight;
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;
/** 中间view的frame */
@property(nonatomic,assign)CGRect middelViewframe;



@end
