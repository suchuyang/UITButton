//
//  ButtonContainerTableViewCell.h
//  UITButtonDemo
//
//  Created by This on 2018/1/31.
//  Copyright © 2018年 This. All rights reserved.
//

#import <UIKit/UIKit.h>

/**按钮的容器单元格*/
@interface ButtonContainerTableViewCell : UITableViewCell

@property (nonatomic ,strong) UILabel *descriptionLabel;//!<描述
@property (nonatomic, strong) UIControl *button;//!<按钮
@property (nonatomic, strong) UIView *border;
@property (nonatomic, assign) BOOL showBorder;//!<显示边框

@end
