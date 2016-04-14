//
//  HMXWordController.m
//  BuDeJie
//
//  Created by hemengxiang on 16/4/9.
//  Copyright © 2016年 hemengxiang. All rights reserved.
//

#import "HMXWordController.h"

@interface HMXWordController ()

@end

@implementation HMXWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(HMXNavMaxY + HMXTitlesViewHeight , 0, HMXTabBarHeight, 0);
    //设置滚动条的边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    NSLog(@"%@",[self class]);
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSString *text = [NSString stringWithFormat:@"%@---%zd",[self class],indexPath.row];
    
    cell.textLabel.text = text;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

@end
