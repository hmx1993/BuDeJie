//
//  HMXADItem.h
//  BuDeJie
//
//  Created by hemengxiang on 16/4/6.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

//w = 480;
// "w_picurl" = "http://ubmcmm.baidustatic.com/media/v1/0f0000vSCsipFdmkFprLk6.jpg";
//"ori_curl" = "http://qmqj2.xy.com/idf/uMAU5P";
//h = 800;
@interface HMXADItem : NSObject
/** 宽度 */
@property(nonatomic,strong)NSString *w;
/** 高度 */
@property(nonatomic,strong)NSString *h;
/** 广告图片路径 */
@property(nonatomic,strong)NSString *w_picurl;
/** 点击广告后跳转的url */
@property(nonatomic,strong)NSString *ori_curl;

@end
