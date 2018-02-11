//
//  ViewController+createButton.h
//  UITButtonDemo
//
//  Created by This on 2018/1/31.
//  Copyright © 2018年 This. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (createButton)



/**带图片和标题的按钮*/
- (void)buttonsWithImageAndTitle;

/**只有图片的按钮*/
-(void)buttonsUpDown;

/**只有标题的按钮*/
- (void)buttonsWithOnlyTitle;

/**不同渲染方式的按钮*/
- (void)buttonOfRenderingMode;
@end
