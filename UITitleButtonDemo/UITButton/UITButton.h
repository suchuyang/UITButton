//
//  UITButton.h
//  QiCaiHongBao
//
//  Created by This on 2018/1/26.
//  Copyright © 2018年 This. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UITButton_WidthRatio 0.382 //!<图片和文本尺寸在需要自适应尺寸时的宽度比例，黄金分割。
#define UITButton_HeightRatio 0.618 //!<图片和文本尺寸在需要自适应尺寸时的高度比例

/**按钮的布局方式*/
typedef NS_ENUM(NSInteger, UITButtonLayoutType) {
    UITButtonLayoutTypeUpDown,//!<上下式布局，默认
    UITButtonLayoutTypeLeftRight,//!<左右式布局
};

/**按钮中图片的位置*/
typedef NS_ENUM(NSInteger, UITButtonImageLocation) {
    UITButtonImageLocationFront,//!<图片在前面或者上面，默认
    UITButtonImageLocationLast,//!<图片在后面或者下面
};


/**图片的位置可以任意指定的按钮
 *  
 */
@interface UITButton : UIControl

#pragma mark - view property

@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UIImageView *imageView;

/**文本的字体*/
@property (nonatomic, copy) UIFont *font;

#pragma mark - layout property

/**布局方向，横向或纵向。默认上下布局*/
@property (nonatomic, assign) UITButtonLayoutType layoutType;

/**图片的位置，默认是图片在上文本在下。*/
@property (nonatomic, assign) UITButtonImageLocation imageLocation;

@property (nonatomic, assign) UIControlContentVerticalAlignment verticalAlignment;
@property (nonatomic, assign) UIControlContentHorizontalAlignment horizontalAlignment;

/**边距的设定。默认四个值都是5.0*/
@property (nonatomic, assign) UIEdgeInsets marginInsets;

/**图片和文本之间的间距,默认也是5.0*/
@property (nonatomic, assign) CGFloat padding;

/**默认为NO，在许多情况下，我们的按钮在各种状态下图片和文本的显示frame是一样的，只有颜色不一样，这种情况下可以让高亮和选中时不计算布局。*/
@property (nonatomic, assign) BOOL allNormalFrame;

#pragma mark - special property

/**默认是zero。图片的frame，如果指定了这个，那图片的展示将会完全由这个属性指定。给出这个属性，是为了在有自定义图片frame的需要时，不至于被原有的frame计算干扰。*/
@property (nonatomic, assign) CGRect specifyImageRect;

/**默认是zero。图片的尺寸。因为有时我们选择的图片的尺寸显示在按钮上不合适，为了控制图片的大下，就需要手动设置，而不是修改图片素材的尺寸。如果只给了一个宽高属性，另一个不给，那么就会按照图片的宽高比进行计算，并自动修正。*/
@property (nonatomic, assign) CGSize specifyImageSize;

/**默认为NO，填充title。当指定了图片的frame活size的时候，就会出现让文本填充剩余的全部空间的需求。*/
@property (nonatomic, assign) BOOL titleFill;//!<

/**默认为YES，是否自动重新设置title的尺寸，让title的frame不超出容器。如果将这个属性设置为NO，那么title的尺寸将不会被修改从而可能超出容器。我想这个属性一般是用不到的。
 在配合clickstobounds的时候（即子视图的超出部分是否不显示）会用得上。*/
@property (nonatomic, assign) BOOL autoResizeTitle;//!<

#pragma mark - set functions

//设置状态相关的参数，当其他不设置的时候，就会默认使用normal的
- (void)setImage:(UIImage *)image forState:(UIControlState)state;

- (void)setTitle:(NSString *)title forState:(UIControlState)state;

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state;

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

/**设置富文本*/



#pragma mark -

@end
