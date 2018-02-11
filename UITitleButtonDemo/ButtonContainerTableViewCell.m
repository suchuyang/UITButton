//
//  ButtonContainerTableViewCell.m
//  UITButtonDemo
//
//  Created by This on 2018/1/31.
//  Copyright © 2018年 This. All rights reserved.
//

#import "ButtonContainerTableViewCell.h"

@implementation ButtonContainerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.descriptionLabel = [[UILabel alloc]init];
        self.descriptionLabel.textColor = [UIColor lightGrayColor];
        self.descriptionLabel.font = [UIFont systemFontOfSize:13.0];
        self.descriptionLabel.numberOfLines = 0;
        [self.contentView addSubview:self.descriptionLabel];
    }
    return self;
}

- (void)layoutSubviews{
    
    CGRect buttonrect = CGRectZero;
    
    if(self.button){
        buttonrect = self.button.frame;
    }
    
    CGRect frame;
    frame.origin.x = CGRectGetMaxX(buttonrect) + 13.0;
    frame.origin.y =  5.0;
    frame.size.width = self.bounds.size.width - frame.origin.x;
    frame.size.height = self.bounds.size.height - 10.0;
    self.descriptionLabel.frame = frame;
    
    
    //下面的代码添加一个边框
    if(!self.border){
        self.border = [UIView new];
        self.border.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:self.border];
    }
    
    CGRect borderFrame;
    borderFrame.origin.x = 0.0;
    borderFrame.origin.y = self.bounds.size.height - 1.0;
    borderFrame.size.width = self.bounds.size.width;
    borderFrame.size.height = 1.0;
    self.border.frame = borderFrame;
    
    self.border.hidden = !self.showBorder;
}

- (void)setButton:(UIControl *)button{
    
    [_button removeFromSuperview];
    _button = button;
    [self.contentView addSubview:_button];
}

@end
