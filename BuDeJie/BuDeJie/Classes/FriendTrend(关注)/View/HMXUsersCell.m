//
//  HMXUsersCell.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/25.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXUsersCell.h"
#import "UserItem.h"
@interface HMXUsersCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screen_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fans_countLabel;

@end


@implementation HMXUsersCell



-(void)setUserItem:(UserItem *)userItem
{
    _userItem = userItem;
    //昵称
    self.screen_nameLabel.text = userItem.screen_name;

    //粉丝数
    NSInteger fans_count = userItem.fans_count.integerValue;
    if (fans_count >= 10000) {
        
        CGFloat fans_countF = fans_count / 10000.0;
        
        self.fans_countLabel.text = [NSString stringWithFormat:@"%.1f万人关注",fans_countF];
    }else{
        self.fans_countLabel.text = [NSString stringWithFormat:@"%zd人关注",fans_count];
    }
    
    //头像
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:userItem.header] placeholderImage:[UIImage hmx_circleImageWithImageName:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        //将图片裁剪成圆形
        self.headerImageView.image = [image circleImage];
    }];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
