//
//  UITButton.m
//  QiCaiHongBao
//
//  Created by This on 2018/1/26.
//  Copyright © 2018年 This. All rights reserved.
//

#import "UITButton.h"

/*
 UIControlStateNormal       = 0,
 UIControlStateHighlighted  = 1
 UIControlStateDisabled     = 2
 UIControlStateSelected     = 3
 UIControlStateFocused NS_ENUM_AVAILABLE_IOS(9_0) = 4
 UIControlStateApplication  = 5
 UIControlStateReserved     = 6
 */
#define Index_UIControlStateNormal 0
#define Index_UIControlStateHighlighted 1
#define Index_UIControlStateDisabled 2
#define Index_UIControlStateSelected 3
#define Index_UIControlStateFocused 4
#define Index_UIControlStateApplication 5
#define Index_UIControlStateReserved 6

static NSInteger StateCount = 7;//!<7个状态，不排除以后有增加的可能。

/**定义一个结构体，用来在计算过尺寸之后返回计算完成的值*/
struct TitleButtonSize {
    CGSize titleSize;
    CGSize imageSize;
};//
typedef struct CG_BOXABLE TitleButtonSize TitleButtonSize;

@interface UITButton()

@property (nonatomic, strong) NSMutableArray *imagesArray;//!<图片对应的数组
@property (nonatomic, strong) NSMutableArray *titleStrArray;//!<title对应的标题的数组
@property (nonatomic, strong) NSMutableArray *titleColorArray;//!<title的颜色的数组
@property (nonatomic, strong) NSMutableArray *backgroundColorArray;//!<背景颜色数组

@end

@implementation UITButton


- (void)dealloc{
    NSLog(@"UITButton dealloc");
}

- (instancetype)init{
    self = [super init];
    if(self){
        NSLog(@"UITButton init");

        [self initDatas];
        [self initLayoutParams];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        NSLog(@"UITButton initWithFrame");

        [self initDatas];
        [self initLayoutParams];
    }
    return self;
}


- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    [self displayState];
}

- (void)initDatas{
    
    /*创建数组，数组我们按照uontrolstate的方式进行索引，state在定义时的位置，代表着对应的元素在数组中的索引。ios9之前的不适用。
     UIControlStateNormal       = 0,
     UIControlStateHighlighted  = 1
     UIControlStateDisabled     = 2
     UIControlStateSelected     = 3
     UIControlStateFocused NS_ENUM_AVAILABLE_IOS(9_0) = 4
     UIControlStateApplication  = 5
     UIControlStateReserved     = 6
     
     */
    self.imagesArray = [[NSMutableArray alloc] initWithCapacity:7];
    self.titleStrArray = [[NSMutableArray alloc] initWithCapacity:7];
    self.titleColorArray = [[NSMutableArray alloc] initWithCapacity:7];
    self.backgroundColorArray = [[NSMutableArray alloc] initWithCapacity:7];
    
    //循环填充元素
    for(int index = 0 ; index < StateCount ; index++){
        [self.imagesArray addObject:@0];
        [self.titleStrArray addObject:@0];
        [self.titleColorArray addObject:@0];
        [self.backgroundColorArray addObject:@0];
    }
    
    
}

- (void)initLayoutParams{
    
    _padding = 5.0;
    _marginInsets = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    
    self.layoutType = UITButtonLayoutTypeUpDown;
    self.imageLocation = UITButtonImageLocationFront;
    
    //默认横竖都居中显示
    self.horizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.verticalAlignment = UIControlContentVerticalAlignmentCenter;//
    self.autoResizeTitle = YES;
    self.titleFill = NO;
}

#pragma mark - set display for state

//设置状态相关的参数，当其他不设置的时候，就会默认使用normal的
- (void)setImage:(UIImage *)image forState:(UIControlState)state{
    
    NSInteger stateIndex = [self getIndexWithState:state];
    
    if(image && [image isKindOfClass:[UIImage class]]){
        
        if(state == UIControlStateNormal){
            //normal状态下，把没有设置的图片都设置为normal
            
            for(NSInteger index = 0 ; index < self.imagesArray.count ; index++){
                if([self.imagesArray[index] isKindOfClass:[NSNumber class]]){
                    
                    if(index == Index_UIControlStateHighlighted){
                        [self.imagesArray replaceObjectAtIndex:index withObject:[self highlightImage:image]];
                    }
                    else{
                        [self.imagesArray replaceObjectAtIndex:index withObject:image];
                    }
                }
            }// end of for
            
        }
        else{
            //其他状态下直接替换
            [self.imagesArray replaceObjectAtIndex:stateIndex withObject:image];
        }
    }// end of image validate
    else if(!image){
        //图片不存在时，直接把对应位置的图片设置为@0
        [self.imagesArray replaceObjectAtIndex:stateIndex withObject:@0];
    }
    else{
        //报错
    }
    
    //
    if(!self.imageView){
        self.imageView = [[UIImageView alloc]initWithImage:image];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.layer.masksToBounds = YES;
        [self addSubview:self.imageView];
    }
    
//    [self reDisplayElements];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    
    NSInteger stateIndex = [self getIndexWithState:state];
    
    if(title && [title isKindOfClass:[NSString class]]){
        
        if(state == UIControlStateNormal){
            //normal状态下，把没有设置的图片都设置为normal
            
            for(NSInteger index = 0 ; index < self.titleStrArray.count ; index++){
                if([self.titleStrArray[index] isKindOfClass:[NSNumber class]]){
                    [self.titleStrArray replaceObjectAtIndex:index withObject:title];
                }
            }// end of for
            
        }
        else{
            //其他状态下直接替换
            [self.titleStrArray replaceObjectAtIndex:stateIndex withObject:title];
        }
    }// end of image validate
    else if(!title){
        //图片不存在时，直接把对应位置的图片设置为@0
        [self.titleStrArray replaceObjectAtIndex:stateIndex withObject:@0];
    }
    else{
        //报错
    }
    
    if(!self.titleLabel){
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.text = title;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        if(self.font){
            self.titleLabel.font = self.font;
        }
        
        [self addSubview:self.titleLabel];
    }
    
    //如果字符串中有换行，那么调用label的sizetofit，label计算的尺寸就会是换行后的尺寸。
    [self.titleLabel sizeToFit];
//    [self reDisplayElements];
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state{
    
    NSInteger stateIndex = [self getIndexWithState:state];
    
    if(color && [color isKindOfClass:[UIColor class]]){
        
        if(state == UIControlStateNormal){
            //normal状态下，把没有设置的图片都设置为normal
            
            for(NSInteger index = 0 ; index < self.titleColorArray.count ; index++){
                if([self.titleColorArray[index] isKindOfClass:[NSNumber class]]){
                    [self.titleColorArray replaceObjectAtIndex:index withObject:color];
                }
            }// end of for
            
        }
        else{
            //其他状态下直接替换
            [self.titleColorArray replaceObjectAtIndex:stateIndex withObject:color];
        }
        
        if(self.state == state){
            self.titleLabel.textColor = color;
        }
        
    }// end of image validate
    else if(!color){
        //颜色不存在时，直接把对应位置的颜色设置为@0
        [self.titleColorArray replaceObjectAtIndex:stateIndex withObject:@0];
    }
    else{
        //报错
    }
    
}

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state{
    NSInteger stateIndex = [self getIndexWithState:state];
    
    if(color && [color isKindOfClass:[UIColor class]]){
        
        if(state == UIControlStateNormal){
            //normal状态下，把没有设置的都设置为normal
            
            for(NSInteger index = 0 ; index < self.backgroundColorArray.count ; index++){
                if([self.backgroundColorArray[index] isKindOfClass:[NSNumber class]]){
                    
                    if(index == Index_UIControlStateHighlighted){
                        [self.backgroundColorArray replaceObjectAtIndex:index withObject:[self highlightColor:color]];
                    }
                    else{
                        [self.backgroundColorArray replaceObjectAtIndex:index withObject:color];
                    }
                    
                }
            }// end of for
            
        }
        else{
            //其他状态下直接替换
            [self.backgroundColorArray replaceObjectAtIndex:stateIndex withObject:color];
        }
        
        if(self.state == state){
            self.backgroundColor = color;
        }
        
    }// end of image validate
    else if(!color){
        //图片不存在时，直接把对应位置的图片设置为@0
        [self.backgroundColorArray replaceObjectAtIndex:stateIndex withObject:@0];
    }
    else{
        //报错
    }
}


#pragma mark - set
- (void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    
    //设置对应的显示
    [self displayState];
}

/**高亮是只在点击的时候才会出现的状态。点击结束了，uicontrol会自动把高亮给结束掉*/
- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    
    //设置对应的显示
    [self displayState];
    NSLog(@"self setHighlighted:%lu",(unsigned long)self.state);
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    //设置对应的显示
    [self displayState];
    NSLog(@"self setSelected:%lu",(unsigned long)self.state);

}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self displayState];
}

- (void)setFont:(UIFont *)font{
    _font = [font copy];
    self.titleLabel.font = font;
}

#pragma mark - layout and display


/**根据状态取索引值，索引用来去数组中取出对应的状态。*/
- (NSInteger)getIndexWithState:(UIControlState)state{
    
    /*
     UIControlStateNormal       = 0,
     UIControlStateHighlighted  = 1
     UIControlStateDisabled     = 2
     UIControlStateSelected     = 3
     UIControlStateFocused NS_ENUM_AVAILABLE_IOS(9_0) = 4
     UIControlStateApplication  = 5
     UIControlStateReserved     = 6
     */
    NSLog(@"begin ---------------- ");
    if(state == 0){
        NSLog(@"UIControlStateNormal");
        return Index_UIControlStateNormal;
    }
    
    if(state & UIControlStateHighlighted){
        NSLog(@"UIControlStateHighlighted");
        return Index_UIControlStateHighlighted;
    }
    
    if(state & UIControlStateDisabled){
        NSLog(@"UIControlStateDisabled");
        return Index_UIControlStateDisabled;
    }
    
    if(state & UIControlStateSelected){
        NSLog(@"UIControlStateSelected");
        return Index_UIControlStateSelected;
    }
    
    if(state & UIControlStateFocused){
        NSLog(@"UIControlStateFocused");
        return Index_UIControlStateFocused;
    }
    
    if(state & UIControlStateApplication){
        NSLog(@"UIControlStateApplication");
        return Index_UIControlStateApplication;
    }
    
    if(state & UIControlStateReserved){
        NSLog(@"UIControlStateReserved");
        return Index_UIControlStateReserved;
    }
    NSLog(@"end --------------- ");
    
    
    return 0;
}

/**设置对应状态下的显示*/
- (void)displayState{
    NSInteger stateIndex = [self getIndexWithState:self.state];
    
    UIImage *stateImage = self.imagesArray[stateIndex];
    NSString *stateTitle = self.titleStrArray[stateIndex];
    UIColor *titleColor = self.titleColorArray[stateIndex];
    UIColor *backgroundColor = self.backgroundColorArray[stateIndex];
    
    BOOL hasTitle = [stateTitle isKindOfClass:[NSString class]];//!<是否有title
    BOOL hasImage = [stateImage isKindOfClass:[UIImage class]];
    
    if(hasTitle){
        self.titleLabel.text = stateTitle;
        self.titleLabel.hidden = NO;
        
        /*
         *  iOS中，如果字符串中有换行符号，那么使用sizeToFit会自动按照换行的来计算。如果没有换行符号，设置了行数为0后，文本会根据宽度自动换行。
         *  在开发中，如果需要在特定位置换行，那么就应该自己插入换行符，否则换行的位置就无法保证。
         */
        [self.titleLabel sizeToFit];
    }
    else{
        self.titleLabel.text = @"";
        self.titleLabel.hidden = YES;
    }
    
    if(hasImage){
        self.imageView.image = stateImage;
        self.imageView.hidden = NO;
    }
    else{
        self.imageView.image = nil;
        self.imageView.hidden = YES;
    }
    
    if([titleColor isKindOfClass:[UIColor class]]){
        self.titleLabel.textColor = titleColor;
    }
    
    if([backgroundColor isKindOfClass:[UIColor class]]){
        self.backgroundColor = backgroundColor;
    }
    
    if(self.selected){
        NSLog(@"select");
    }
    
    [self distributeLayoutHasTitle:hasTitle hasImage:hasImage];
}

/**分发布局计算
 * @param hasTitle 是否有标题
 * @param hasImage 是否有图片
 **/
- (void)distributeLayoutHasTitle:(BOOL)hasTitle hasImage:(BOOL)hasImage{
    
    
    
    //1、看两个元素是否都存在，只存在一个的时候就简单了，直接考虑布局和大小
    //2、两个元素都存在的时候，计算的就会多一些
    
    if(!hasTitle && !hasImage){
        //两个都不存在，直接返回
    }
    else if(hasImage && !hasTitle){
        //只有图片
        [self displayOnlyImage];
    }
    else if(hasTitle && !hasImage){
        //只有标题
        [self displayOnlyTitle];
    }
    else{
        //两个都存在
        [self displayBothImageAndTitle];
    }
    
    
}//end of distributeLayout

#pragma mark - display only image

/**只有图片时候的布局*/
- (void)displayOnlyImage{
    /*1、判断是否有指定的frame和size
     2、计算frame*/
    
    CGRect imageFrame = CGRectZero;
    
    BOOL hasSpecifyImageFrame = !CGRectEqualToRect(self.specifyImageRect, CGRectZero);//!<是否指定了图片的frame
    BOOL hasSpecifyImageSize = !CGSizeEqualToSize(self.specifyImageSize, CGSizeZero);//!<是否指定了图片的size
    
    CGSize originalSize = self.imageView.image.size;
    
    //首先计算size
    if(hasSpecifyImageFrame == NO && hasSpecifyImageSize == NO){
        
        //根据margin和宽高来计算。
        imageFrame.size.width = self.bounds.size.width - _marginInsets.left - _marginInsets.right;
        
        imageFrame.size.height = imageFrame.size.width * originalSize.height / originalSize.width;
        
        //判断溢出
        if(imageFrame.size.height > self.bounds.size.height - _marginInsets.top - _marginInsets.bottom){
            imageFrame.size.height = self.bounds.size.height - _marginInsets.top - _marginInsets.bottom;
            imageFrame.size.width = imageFrame.size.height * originalSize.width / originalSize.height;
        }
        
    }// end of 没有指定图片的frame 和size
    else{
        if(hasSpecifyImageFrame){
            imageFrame.size = _specifyImageRect.size;
        }
        else if(hasSpecifyImageSize){
            //指定图片size的情况下，允许只指定一个边，另一个边将会按照源图片的尺寸比例进行计算。
            CGSize originalImageSize = self.imageView.image.size;
            
            //直接修正指定的size
            if(self.specifyImageSize.width == 0){
                _specifyImageSize.width = self.specifyImageSize.height * originalImageSize.width / originalImageSize.height;
            }
            else if(self.specifyImageSize.height == 0){
                _specifyImageSize.height = self.specifyImageSize.width * originalImageSize.height / originalImageSize.width;
            }
            
            imageFrame.size = self.specifyImageSize;
        }
    }
    
    //然后计算位置
    if(hasSpecifyImageFrame){
        imageFrame.origin = _specifyImageRect.origin;
    }
    else{
        //判断水平和竖直方向的位置.
        //x坐标
        if(self.horizontalAlignment == UIControlContentHorizontalAlignmentLeft){
            
            imageFrame.origin.x = _marginInsets.left;
        }
        else if(self.horizontalAlignment == UIControlContentHorizontalAlignmentRight){
            imageFrame.origin.x = self.bounds.size.width - imageFrame.size.width - _marginInsets.right;
        }
        //其他情况都按照if(self.horizontalAlignment == UIControlContentHorizontalAlignmentCenter)处理
        else{
            imageFrame.origin.x = (self.bounds.size.width - imageFrame.size.width) / 2;
        }
        //end of x
        
        //y坐标
        if(self.verticalAlignment == UIControlContentVerticalAlignmentTop){
            
            imageFrame.origin.y = _marginInsets.top;
        }
        else if(self.verticalAlignment == UIControlContentVerticalAlignmentBottom){
            imageFrame.origin.y = self.bounds.size.height - imageFrame.size.height - _marginInsets.bottom;
        }
        //其他情况都按照居中处理
        else{
            imageFrame.origin.y = (self.bounds.size.height - imageFrame.size.height) / 2;
        }
        //end of y
    }// end of 没有指定frame
    
    self.imageView.frame = imageFrame;
    
}//end of displayOnlyImage

#pragma mark - display only title
/**只有title时候的布局*/
- (void)displayOnlyTitle{
    
    CGRect titleFrame = self.titleLabel.frame;
    
    if(_titleFill == YES){
        //设置了填充，且只有标题，那直接填充就可以了。
        titleFrame = CGRectMake(_marginInsets.left, _marginInsets.top, self.bounds.size.width - _marginInsets.left - _marginInsets.right, self.bounds.size.height - _marginInsets.top - _marginInsets.bottom);
        self.titleLabel.frame = titleFrame;
        return;
    }
    
    if(_autoResizeTitle == NO){
        //设置了不修改title的frame，那就直接计算布局。
    }
    else{
        //判断title的宽高是否溢出
        if(titleFrame.size.width > self.bounds.size.width - _marginInsets.left - _marginInsets.right){
            titleFrame.size.width = self.bounds.size.width-_marginInsets.left - _marginInsets.right;
        }
        
        if(titleFrame.size.height > self.bounds.size.height-_marginInsets.top - _marginInsets.bottom){
            titleFrame.size.height = self.bounds.size.height - _marginInsets.top-_marginInsets.bottom;
        }
    }
    
    //计算布局
    //x坐标
    if(self.horizontalAlignment == UIControlContentHorizontalAlignmentLeft){
        
        titleFrame.origin.x = _marginInsets.left;
    }
    else if(self.horizontalAlignment == UIControlContentHorizontalAlignmentRight){
        titleFrame.origin.x = self.bounds.size.width - titleFrame.size.width - _marginInsets.right;
    }
    //其他情况都按照if(self.horizontalAlignment == UIControlContentHorizontalAlignmentCenter)处理
    else{
        titleFrame.origin.x = (self.bounds.size.width - titleFrame.size.width) / 2;
    }
    //end of x
    
    //y坐标
    if(self.verticalAlignment == UIControlContentVerticalAlignmentTop){
        
        titleFrame.origin.y = _marginInsets.top;
    }
    else if(self.verticalAlignment == UIControlContentVerticalAlignmentBottom){
        titleFrame.origin.y = self.bounds.size.height - titleFrame.size.height - _marginInsets.bottom;
    }
    //其他情况都按照居中处理
    else{
        titleFrame.origin.y = (self.bounds.size.height - titleFrame.size.height) / 2;
    }
    //end of y
    
    self.titleLabel.frame = titleFrame;
    
}//end of displayOnlyTitle


#pragma mark - display both image and title

/**图片和文本都存在的布局*/
-(void)displayBothImageAndTitle{
    
    CGRect imageFrame = CGRectZero;
    CGRect titleFrame = self.titleLabel.frame;
    
    BOOL hasSpecifyImageFrame = !CGRectEqualToRect(self.specifyImageRect, CGRectZero);//!<是否指定了图片的frame
    BOOL hasSpecifyImageSize = !CGSizeEqualToSize(self.specifyImageSize, CGSizeZero);//!<是否指定了图片的size
    
    if(hasSpecifyImageFrame == NO && hasSpecifyImageSize == NO){
        
        TitleButtonSize finalsize = [self calculateImageAndTitleSize];
        imageFrame.size = finalsize.imageSize;
        titleFrame.size = finalsize.titleSize;
        
        self.imageView.frame = imageFrame;
        self.titleLabel.frame = titleFrame;
        
    }// end of 没有指定图片的frame 和size
    else{
        //以指定的frame为最高优先级，size次之。
        if(hasSpecifyImageFrame){
            imageFrame = self.specifyImageRect;
        }
        else{
            //指定图片size的情况下，我们允许只指定一个边，另一个边将会按照源图片的尺寸比例进行计算。
            CGSize originalImageSize = self.imageView.image.size;
            
            //直接修正指定的size
            if(self.specifyImageSize.width == 0){
                _specifyImageSize.width = self.specifyImageSize.height * originalImageSize.width / originalImageSize.height;
            }
            else if(self.specifyImageSize.height == 0){
                _specifyImageSize.height = self.specifyImageSize.width * originalImageSize.height / originalImageSize.width;
            }
            
            imageFrame.size = self.specifyImageSize;
        }
        
        self.imageView.frame = imageFrame;
        
        //指定了图片的frame或size的情况下，就需要对title进行修正了。
        titleFrame.size = [self correntTitleSize:YES hasTitle:YES];
        
        self.titleLabel.frame = titleFrame;
        
    }// end of 指定了图片的frame或size
    
    if(hasSpecifyImageFrame){
        NSLog(@"finaltitleframe before layout:%@",NSStringFromCGRect(self.titleLabel.frame));
    }
    //计算布局
    [self calculateLayout];
    
    if(hasSpecifyImageFrame){
        NSLog(@"finaltitleframe is:%@",NSStringFromCGRect(self.titleLabel.frame));
    }
}// end of displayBothImageAndTitle




/**根据图片的size，修正title的最大尺寸.
 *  根据两个参数判断是否需要考虑对应的尺寸。
*/
- (CGSize)correntTitleSize:(BOOL)hasImage hasTitle:(BOOL)hasTitle{
    
    CGRect titleFrame = self.titleLabel.frame;
    CGRect imageFrame = self.imageView.frame;
    CGSize containerSize = self.bounds.size;
    
    //注意一定要在imageview存在的前提下再来调用这个方法。
    if(self.layoutType == UITButtonLayoutTypeUpDown){
        //上下布局的情况下，宽度不能超过容器，高度要考虑图片。
        if(titleFrame.size.width > containerSize.width - _marginInsets.left - _marginInsets.right){
            titleFrame.size.width = containerSize.width - _marginInsets.left - _marginInsets.right;
        }
        
        //高度
        if(self.imageLocation == UITButtonImageLocationFront){
            //图片在上
            if(titleFrame.size.height > (containerSize.height - CGRectGetMaxY(imageFrame) - _marginInsets.bottom - _padding)){
                
                titleFrame.size.height =containerSize.height - CGRectGetMaxY(imageFrame) - _marginInsets.bottom - _padding;
            }
        }
        else{
            //图片在下
            if(titleFrame.size.height > imageFrame.origin.y - _marginInsets.top - _padding){
                titleFrame.size.height = imageFrame.origin.y - _marginInsets.top - _padding;
            }
        }
    }//end of UITButtonLayoutTypeUpDown
    else if(self.layoutType == UITButtonLayoutTypeLeftRight){
        //左右布局，宽度要考虑图片，高度不能超过容器
        if(titleFrame.size.height > containerSize.height - _marginInsets.top - _marginInsets.bottom){
            titleFrame.size.height = containerSize.height - _marginInsets.top - _marginInsets.bottom;
        }
        
        if(self.imageLocation == UITButtonImageLocationFront){
            //图片在左
            if(titleFrame.size.width > (containerSize.width - CGRectGetMaxX(imageFrame) - _marginInsets.right - _padding)){
                
                titleFrame.size.width =containerSize.width - CGRectGetMaxX(imageFrame) - _marginInsets.right - _padding;
            }
        }
        else{
            //图片在右
            if(titleFrame.size.width > imageFrame.origin.x - _marginInsets.left - _padding){
                titleFrame.size.width = imageFrame.origin.x - _marginInsets.left - _padding;
            }
        }
    }//UITButtonLayoutTypeLeftRight
    
    return titleFrame.size;
    
}

/**计算图片和文本的尺寸
 *注意
 1、这个方法调用的前提是title的尺寸已经根据设定的属性计算出来
 2、如果指定了图片的frame和size，那么这里是不需要调用的。
 */
- (TitleButtonSize)calculateImageAndTitleSize{
    
    CGSize imageSize = CGSizeZero;
    
    CGSize titleSize = self.titleLabel.bounds.size;//!<文本尺寸
    
    CGSize containerSize = self.bounds.size;//!<容器尺寸
    
    CGSize originalImageSize = self.imageView.image.size;
    
    if(self.layoutType == UITButtonLayoutTypeLeftRight){
        //左右布局
        imageSize.width = containerSize.width - titleSize.width - _padding - _marginInsets.left - _marginInsets.right;
        
        if(imageSize.width > 0){
            if(imageSize.width >= originalImageSize.width){
                imageSize = originalImageSize;
            }
            else{
                //按照比例计算图片的另一边长度
                imageSize.height = originalImageSize.height / originalImageSize.width * imageSize.width;
            }
            
            //如果图片的高度超过容器
            if(imageSize.height > containerSize.height - _marginInsets.top - _marginInsets.bottom){
                imageSize.height = containerSize.height - _marginInsets.top - _marginInsets.bottom;
                imageSize.width = imageSize.height * originalImageSize.width / originalImageSize.height;
            }
            
            //执行到这里，说明宽度合适，要把高度适配
            if(self.autoResizeTitle && titleSize.height > containerSize.height - _marginInsets.top - _marginInsets.bottom){
                titleSize.height = containerSize.height - _marginInsets.top - _marginInsets.bottom;
            }
            
            
        }//end of if(imageSize.width > 0)
        else{
            //图片宽度小于等于0 ，那就得按照高度重新计算
            imageSize.height = containerSize.height - _marginInsets.top - _marginInsets.bottom;
            
            //高度大于源图片尺寸，取源图片尺寸。
            if(imageSize.height > originalImageSize.height){
                imageSize = originalImageSize;
            }
            else{
                imageSize.width = imageSize.height * originalImageSize.width / originalImageSize.height;
            }
            
            //按照黄金比例0.382来分配宽度
            if(imageSize.width <= (containerSize.width - _marginInsets.left - _marginInsets.right - _padding) * UITButton_WidthRatio){
                //宽度满足预期，只重新计算title的宽度
            }
            else{
                //宽度超出预期，按照预期重新计算。
                imageSize.width = (containerSize.width - _marginInsets.left - _marginInsets.right - _padding) * UITButton_WidthRatio;
                imageSize.height = imageSize.width * originalImageSize.height / originalImageSize.width;
                
            }
            
            //修正title的宽度
            titleSize.width = (containerSize.width - _marginInsets.left - _marginInsets.right - _padding) - imageSize.width;
        }// end of 图片宽度小于等于0
    }// end of 左右布局
    
    else if(self.layoutType == UITButtonLayoutTypeUpDown){
        //上下布局
        imageSize.height = containerSize.height - _marginInsets.top - _marginInsets.bottom - _padding - titleSize.height;
        
        if(imageSize.height > 0){
            //文本布局了之后，图片有高度，那么就按照这个高度来计算>
            if(imageSize.height > originalImageSize.height){
                imageSize = originalImageSize;
            }
            else{
                //计算宽度
                imageSize.width = imageSize.height * originalImageSize.width / originalImageSize.height;
            }
            
            //判断宽度是否超出
            if(imageSize.width > containerSize.width - _marginInsets.left - _marginInsets.right){
                //超出，按照宽度再次重新计算.
                imageSize.width = containerSize.width - _marginInsets.left - _marginInsets.right;
                imageSize.height = imageSize.width * originalImageSize.height / originalImageSize.width;
            }
            
            //执行到这里，图片的高度已经确定，适配文本的宽度
            if(self.autoResizeTitle && titleSize.width > containerSize.width - _marginInsets.left - _marginInsets.right){
                titleSize.width = containerSize.width - _marginInsets.left - _marginInsets.right;
            }
            
        }//end of if图片高度大于0
        else{
            //图片高度小于0 了，那就按照黄金比例再次全部分配,注意高度上使用0.618
            imageSize.width = containerSize.width - _marginInsets.left - _marginInsets.right;
            
            imageSize.height = imageSize.width * originalImageSize.height / originalImageSize.width;
            
            //判断溢出，给title留出一定的空间
            if(imageSize.height > (containerSize.height - _marginInsets.top - _marginInsets.bottom - _padding)*UITButton_HeightRatio){
                
                imageSize.height = (containerSize.height - _marginInsets.top - _marginInsets.bottom - _padding)*UITButton_HeightRatio;
                imageSize.width = imageSize.height * originalImageSize.width / originalImageSize.height;
                
            }
            
            //同时修正title的高度
            titleSize.height = (containerSize.height - _marginInsets.top - _marginInsets.bottom - _padding) - imageSize.height;
            
        }// end of 图片高度小于等于0
    }// end of 上下布局
    
    TitleButtonSize finalSize;
    finalSize.imageSize = imageSize;
    finalSize.titleSize = titleSize;
    
    return finalSize;
}// end of calculateImageSize

/*根据布局参数计算布局*/
- (void)calculateLayout{
    
    CGRect imageFrame = self.imageView.frame;
    CGRect titleFrame = self.titleLabel.frame;
    CGSize containerSize = self.bounds.size;
    
    BOOL specifyImageFrame = !CGRectEqualToRect(self.specifyImageRect, CGRectZero);
    
    if(specifyImageFrame){
        imageFrame.origin = self.specifyImageRect.origin;
        self.imageView.frame = imageFrame;
        
        if(_titleFill == NO){
            //第一级是布局的方式，上下和左右.
            if(self.layoutType == UITButtonLayoutTypeUpDown){
                //x坐标
                if(self.horizontalAlignment == UIControlContentHorizontalAlignmentLeft){
                    titleFrame.origin.x = _padding;
                }
                else if(self.horizontalAlignment == UIControlContentHorizontalAlignmentRight){
                    titleFrame.origin.x = (containerSize.width - titleFrame.size.width - _padding);
                }
                //其他情况都按照if(self.horizontalAlignment == UIControlContentHorizontalAlignmentCenter)处理
                else{
                    titleFrame.origin.x = (containerSize.width - titleFrame.size.width) / 2;
                }
                
                //y坐标
                if(self.imageLocation == UITButtonImageLocationFront){
                    //图片在上
                    
                    if(self.verticalAlignment == UIControlContentVerticalAlignmentTop){
                        titleFrame.origin.y = CGRectGetMaxY(imageFrame) + _padding;
                    }
                    else if(self.verticalAlignment == UIControlContentVerticalAlignmentBottom){
                        titleFrame.origin.y = containerSize.height - _padding - titleFrame.size.height;
                    }
                    else{
                        //其他情况都默认为居中
                        titleFrame.origin.y = CGRectGetMaxY(imageFrame) + _padding;
                    }
                }
                else{
                    //图片在下
                    if(self.verticalAlignment == UIControlContentVerticalAlignmentTop){
                        titleFrame.origin.y = _padding;
                    }
                    else if(self.verticalAlignment == UIControlContentVerticalAlignmentBottom){
                        titleFrame.origin.y = imageFrame.origin.y - _padding - titleFrame.size.height;
                    }
                    else{
                        //其他情况都默认为居中
                        titleFrame.origin.y = (containerSize.height - imageFrame.size.height - titleFrame.size.height - _padding) / 2;
                    }
                }// end of imagelocation
            }// end of if(self.layoutType == UITButtonLayoutTypeUpDown)
            else if (self.layoutType == UITButtonLayoutTypeLeftRight){
                //y坐标
                if(self.verticalAlignment == UIControlContentVerticalAlignmentTop){
                    titleFrame.origin.y = _padding;
                }
                else if(self.verticalAlignment == UIControlContentVerticalAlignmentBottom){
                    titleFrame.origin.y = (containerSize.height - titleFrame.size.height - _padding);
                }
                //其他情况都按照居中处理
                else{
                    titleFrame.origin.y = (containerSize.height - titleFrame.size.height) / 2;
                }
                
                //x坐标
                if(self.imageLocation == UITButtonImageLocationFront){
                    //图片在左
                    
                    if(self.horizontalAlignment == UIControlContentHorizontalAlignmentLeft){
                        titleFrame.origin.x = CGRectGetMaxX(imageFrame) + _padding;
                    }
                    else if(self.horizontalAlignment == UIControlContentHorizontalAlignmentRight){
                        //
                        titleFrame.origin.x = containerSize.width - _marginInsets.right - titleFrame.size.width;
                    }
                    else{
                        //其他情况都默认为居中
                        titleFrame.origin.x = CGRectGetMaxX(imageFrame) + _padding;
                    }
                }
                else{
                    //图片在右
                    
                    if(self.horizontalAlignment == UIControlContentHorizontalAlignmentLeft){
                        
                        titleFrame.origin.x = _padding;
                    }
                    else if(self.horizontalAlignment == UIControlContentHorizontalAlignmentRight){
                        titleFrame.origin.x = imageFrame.origin.x - _padding - titleFrame.size.width;
                    }
                    else{
                        //其他情况都默认为居中
                        titleFrame.origin.x = (containerSize.width - imageFrame.size.width - titleFrame.size.width - _padding) / 2;
                    }
                }// end of 图片在右
            }// end of (self.layoutType == 左右布局)
        }// end of if(_titleFill == NO)
    }// end of specifyImageFrame
    else{
        
        //第一级是布局的方式，上下和左右.
        if(self.layoutType == UITButtonLayoutTypeUpDown){
            
            //x坐标
            if(self.horizontalAlignment == UIControlContentHorizontalAlignmentLeft){
                imageFrame.origin.x = _padding;
                titleFrame.origin.x = _padding;
            }
            else if(self.horizontalAlignment == UIControlContentHorizontalAlignmentRight){
                imageFrame.origin.x = (containerSize.width - imageFrame.size.width - _padding);
                titleFrame.origin.x = (containerSize.width - titleFrame.size.width - _padding);
            }
            //其他情况都按照if(self.horizontalAlignment == UIControlContentHorizontalAlignmentCenter)处理
            else{
                imageFrame.origin.x = (containerSize.width - imageFrame.size.width) / 2;
                titleFrame.origin.x = (containerSize.width - titleFrame.size.width) / 2;
            }
            
            //y坐标
            if(self.imageLocation == UITButtonImageLocationFront){
                //图片在上
                
                if(self.verticalAlignment == UIControlContentVerticalAlignmentTop){
                    imageFrame.origin.y = _padding;
                    titleFrame.origin.y = CGRectGetMaxY(imageFrame) + _padding;
                }
                else if(self.verticalAlignment == UIControlContentVerticalAlignmentBottom){
                    titleFrame.origin.y = containerSize.height - _padding - titleFrame.size.height;
                    imageFrame.origin.y = titleFrame.origin.y - _padding - imageFrame.size.height;
                }
                else{
                    //其他情况都默认为居中
                    imageFrame.origin.y = (containerSize.height - imageFrame.size.height - titleFrame.size.height - _padding) / 2;
                    titleFrame.origin.y = CGRectGetMaxY(imageFrame) + _padding;
                }
            }
            else{
                //图片在下
                if(self.verticalAlignment == UIControlContentVerticalAlignmentTop){
                    
                    titleFrame.origin.y = _padding;
                    imageFrame.origin.y = CGRectGetMaxY(titleFrame) + _padding;
                }
                else if(self.verticalAlignment == UIControlContentVerticalAlignmentBottom){
                    imageFrame.origin.y = containerSize.height - _padding - imageFrame.size.height;
                    titleFrame.origin.y = imageFrame.origin.y - _padding - titleFrame.size.height;
                }
                else{
                    //其他情况都默认为居中
                    titleFrame.origin.y = (containerSize.height - imageFrame.size.height - titleFrame.size.height - _padding) / 2;
                    imageFrame.origin.y = CGRectGetMaxY(titleFrame) + _padding;
                }
            }// end of imagelocation
        }// end of if(self.layoutType == UITButtonLayoutTypeUpDown)
        else if (self.layoutType == UITButtonLayoutTypeLeftRight){
            //y坐标
            if(self.verticalAlignment == UIControlContentVerticalAlignmentTop){
                imageFrame.origin.y = _padding;
                titleFrame.origin.y = _padding;
            }
            else if(self.verticalAlignment == UIControlContentVerticalAlignmentBottom){
                imageFrame.origin.y = (containerSize.height - imageFrame.size.height - _padding);
                titleFrame.origin.y = (containerSize.height - titleFrame.size.height - _padding);
            }
            //其他情况都按照居中处理
            else{
                imageFrame.origin.y = (containerSize.height - imageFrame.size.height) / 2;
                titleFrame.origin.y = (containerSize.height - titleFrame.size.height) / 2;
            }
            
            //x坐标
            if(self.imageLocation == UITButtonImageLocationFront){
                //图片在左
                
                if(self.horizontalAlignment == UIControlContentHorizontalAlignmentLeft){
                    imageFrame.origin.x = _marginInsets.left;
                    titleFrame.origin.x = CGRectGetMaxX(imageFrame) + _padding;
                }
                else if(self.horizontalAlignment == UIControlContentHorizontalAlignmentRight){
                    //
                    titleFrame.origin.x = containerSize.width - _marginInsets.right - titleFrame.size.width;
                    imageFrame.origin.x = titleFrame.origin.x - _padding - imageFrame.size.width;
                }
                else{
                    //其他情况都默认为居中
                    imageFrame.origin.x = (containerSize.width - imageFrame.size.width - titleFrame.size.width - _padding) / 2;
                    titleFrame.origin.x = CGRectGetMaxX(imageFrame) + _padding;
                }
            }
            else{
                //图片在右
                
                if(self.horizontalAlignment == UIControlContentHorizontalAlignmentLeft){
                    
                    titleFrame.origin.x = _padding;
                    imageFrame.origin.x = CGRectGetMaxX(titleFrame) + _padding;
                }
                else if(self.horizontalAlignment == UIControlContentHorizontalAlignmentRight){
                    imageFrame.origin.x = containerSize.width - _padding - imageFrame.size.width;
                    titleFrame.origin.x = imageFrame.origin.x - _padding - titleFrame.size.width;
                }
                else{
                    //其他情况都默认为居中
                    titleFrame.origin.x = (containerSize.width - imageFrame.size.width - titleFrame.size.width - _padding) / 2;
                    imageFrame.origin.x = CGRectGetMaxX(titleFrame) + _padding;
                }
            }// end of 图片在右
        }// end of (self.layoutType == 左右布局)
        self.imageView.frame = imageFrame;
        
    }// end of 未指定图片的frame
    
    //如果设置了titleFill，那就把title在剩余的空间填充
    if(self.titleFill){
        titleFrame = [self fillTitleToRemaindSpace];
    }
    
    self.titleLabel.frame = titleFrame;
    
}//end of calculateLayout

/**在剩下了的空间里填充title*/
- (CGRect)fillTitleToRemaindSpace{
    
    CGRect imageFrame = self.imageView.frame;
    CGRect titleFrame = self.titleLabel.frame;
    CGSize containerSize = self.bounds.size;

    //上下
    if(self.layoutType == UITButtonLayoutTypeUpDown){
        if(self.imageLocation == UITButtonImageLocationFront){
            //图片在上
            titleFrame.origin.x = _marginInsets.left;
            titleFrame.origin.y = CGRectGetMaxY(imageFrame) + _padding;
            titleFrame.size.width = containerSize.width - _marginInsets.left - _marginInsets.right;
            titleFrame.size.height = containerSize.height - CGRectGetMaxY(imageFrame) - _padding - _marginInsets.bottom;
        }
        else{
            //图片在下
            titleFrame.origin.x = _marginInsets.left;
            titleFrame.origin.y = _marginInsets.top;
            titleFrame.size.width = containerSize.width - _marginInsets.left - _marginInsets.right;
            titleFrame.size.height = imageFrame.origin.y - _padding - _marginInsets.top;
        }
    }
    //左右
    else if(self.layoutType == UITButtonLayoutTypeLeftRight){
        if(self.imageLocation == UITButtonImageLocationFront){
            //图片在左
            titleFrame.origin.y = _marginInsets.top;
            titleFrame.origin.x = CGRectGetMaxX(imageFrame) + _padding;
            titleFrame.size.height = containerSize.height - _marginInsets.top - _marginInsets.bottom;
            titleFrame.size.width = containerSize.width - CGRectGetMaxX(imageFrame) - _padding - _marginInsets.right;
        }
        else{
            //图片在右
            titleFrame.origin.y = _marginInsets.top;
            titleFrame.origin.x = _marginInsets.left;
            titleFrame.size.height = containerSize.height - _marginInsets.top - _marginInsets.bottom;
            titleFrame.size.width = imageFrame.origin.x - _padding - _marginInsets.left;
        }
    }
    
    return titleFrame;
    
}// end of fillTitleToRemaindSpace


#pragma mark - image and color

/**把普通状态的图片渲染一下，用来点击是蒙一层灰*/
- (UIImage *)highlightImage:(UIImage *)normalImage{
    
    return [self image:normalImage withTintColor:[UIColor colorWithRed:95.0/255.0 green:95.0/255.0 blue:95.0/255.0 alpha:1.0] blendMode:kCGBlendModeOverlay];
}

- (UIImage *)image:(UIImage *)image withTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    [tintColor setFill];//填充颜⾊色
    CGRect bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    UIRectFill(bounds);
    //设置绘画透明混合模式和透明度
    [image drawInRect:bounds blendMode:blendMode alpha:1.0f];
    if (blendMode == kCGBlendModeOverlay) {
        //保留透明度信息
        [image drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tintedImage;
}

/**把普通状态下的背景颜色蒙一层灰度。*/
- (UIColor *)highlightColor:(UIColor *)normalColor{
    
    CGFloat R=0.0,G=0.0,B=0.0,A= 0.0;
    
    CGColorRef color = normalColor.CGColor;
    
    size_t numComponents = CGColorGetNumberOfComponents(color);
    
    if (numComponents==4){
        const CGFloat *components = CGColorGetComponents(color);
        
        R = components[0];
        
        G = components[1];
        
        B = components[2];
        
        A = components[3];
    }
    
    return [UIColor colorWithRed:R*0.618 green:G*0.618 blue:B*0.618 alpha:A];
}

@end
