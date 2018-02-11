//
//  ViewController+createButton.m
//  UITButtonDemo
//
//  Created by This on 2018/1/31.
//  Copyright © 2018年 This. All rights reserved.
//

#import "ViewController+createButton.h"
#import "ViewController.h"

#import "UITButton.h"
#import "UICellButton.h"

@implementation ViewController (createButton)

static CGFloat leftpadding = 10.0;

/**带图片和标题的按钮*/
- (void)buttonsWithImageAndTitle{
    NSMutableArray *sectionarray = [NSMutableArray new];
    
    //获取程序包内图片根路径
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    
    //图像路径
    NSString *path = [resourcePath stringByAppendingPathComponent:@"facebook.png"];
    //创建图片
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    
    //-----------------facebook
    UICellButton *facebookButton = [[UICellButton alloc]initWithFrame:CGRectMake(leftpadding, 10.0, 180.0, 40.0)];
    [facebookButton setImage:image forState:UIControlStateNormal];
    [facebookButton setTitle:@"FACEBOOK" forState:UIControlStateNormal];
    [facebookButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [facebookButton setBackgroundColor:[UIColor colorWithRed:249.0/255.0 green:211.0/255.0 blue:138.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [facebookButton setBackgroundColor:[UIColor colorWithRed:213.0/255.0 green:178.0/255.0 blue:114.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    facebookButton.padding = 15.0;
    facebookButton.marginInsets = UIEdgeInsetsMake(10.0, 15.0, 10.0, 15.0);
    facebookButton.layoutType = UITButtonLayoutTypeLeftRight;
    facebookButton.layer.cornerRadius = 20.0;
    facebookButton.layer.masksToBounds = YES;
    
    facebookButton.descriptionStr = @"facebook 登录按钮，间隔大，自定义背景颜色";
    [sectionarray addObject:facebookButton];
    
    
    //-----------------删除按钮
    UICellButton *deletebadge = [[UICellButton alloc]initWithFrame:CGRectMake(leftpadding, 10.0, 80.0, 35.0)];
    //图像路径
    path = [resourcePath stringByAppendingPathComponent:@"delete.png"];
    //创建图片
    image = [UIImage imageWithContentsOfFile:path];
    [deletebadge setImage:image forState:UIControlStateNormal];
    [deletebadge setTitle:@"支付宝" forState:UIControlStateNormal];
    deletebadge.titleLabel.textAlignment = NSTextAlignmentRight;
    deletebadge.layoutType = UITButtonLayoutTypeLeftRight;
    deletebadge.imageLocation = UITButtonImageLocationLast;
    deletebadge.specifyImageRect = CGRectMake(68.0, -4.0, 16.0, 16.0);
    deletebadge.titleFill = YES;
    deletebadge.marginInsets = UIEdgeInsetsMake(5.0, 0.0, 5.0, 0.0);
    deletebadge.padding = 0;
    
    //这里弄上边框之后，图片会被边框覆盖
    deletebadge.layer.borderColor = [UIColor lightGrayColor].CGColor;
    deletebadge.layer.cornerRadius = 5.0;
    deletebadge.layer.borderWidth = 1.0;
    deletebadge.layer.masksToBounds = YES;
    
    deletebadge.descriptionStr = @"带一个删除角标";
    [sectionarray addObject:deletebadge];
    
    
    //-----------------一个普通的蓝色背景的按钮
    UICellButton *bluebutton = [[UICellButton alloc]initWithFrame:CGRectMake(leftpadding, 10.0, 200, 40.0)];
    //图像路径
    path = [resourcePath stringByAppendingPathComponent:@"teacter.png"];
    //创建图片
    image = [UIImage imageWithContentsOfFile:path];
    [bluebutton setImage:image forState:UIControlStateNormal];
    [bluebutton setTitle:@"名师辅导" forState:UIControlStateNormal];
    [bluebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bluebutton setBackgroundColor:[UIColor colorWithRed:30.0/255.0 green:144.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    bluebutton.layoutType = UITButtonLayoutTypeLeftRight;
    
    bluebutton.layer.borderColor = [UIColor colorWithRed:1.0 green:182.0/255.0 blue:193.0/255.0 alpha:1.0].CGColor;
    bluebutton.layer.cornerRadius = 5.0;
    bluebutton.layer.borderWidth = 3.0;
    
    
    bluebutton.descriptionStr = @"一个普通的蓝色背景带边框的按钮";
    [sectionarray addObject:bluebutton];
    
    //-----------------普通的不带边框，调整间距
    UICellButton *bluebutton2 = [[UICellButton alloc]initWithFrame:CGRectMake(leftpadding, 10.0, 200, 40.0)];
    //图像路径
    path = [resourcePath stringByAppendingPathComponent:@"teacter.png"];
    //创建图片
    image = [UIImage imageWithContentsOfFile:path];
    [bluebutton2 setImage:image forState:UIControlStateNormal];
    [bluebutton2 setTitle:@"名师辅导" forState:UIControlStateNormal];
    [bluebutton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bluebutton2 setBackgroundColor:[UIColor colorWithRed:30.0/255.0 green:144.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    bluebutton2.layoutType = UITButtonLayoutTypeLeftRight;
    bluebutton2.marginInsets = UIEdgeInsetsMake(8.0, 5.0, 8.0, 5.0);
    bluebutton2.padding = 13.0;
    
    bluebutton2.layer.cornerRadius = 5.0;
    
    
    bluebutton2.descriptionStr = @"普通蓝色按钮，不带边框，调整间距。";
    [sectionarray addObject:bluebutton2];
    
    
    //-----------------圆形图片顶头显示
    UICellButton *roundLeftImage = [[UICellButton alloc]initWithFrame:CGRectMake(leftpadding, 10.0, 200, 40.0)];
    //图像路径
    path = [resourcePath stringByAppendingPathComponent:@"lamp-2_128px.png"];
    //创建图片
    image = [UIImage imageWithContentsOfFile:path];
    [roundLeftImage setImage:image forState:UIControlStateNormal];
    [roundLeftImage setTitle:@"台灯物语" forState:UIControlStateNormal];
    [roundLeftImage setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [roundLeftImage setBackgroundColor:[UIColor colorWithRed:176.0/255.0 green:196.0/255.0 blue:222.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    roundLeftImage.horizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    roundLeftImage.layoutType = UITButtonLayoutTypeLeftRight;
    roundLeftImage.marginInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 40.0);
    roundLeftImage.titleFill = YES;
    
    roundLeftImage.layer.cornerRadius = 20.0;
    
    roundLeftImage.descriptionStr = @"图片放在最左边，顶头显示。";
    [sectionarray addObject:roundLeftImage];
    
    //-----------------圆形图片顶头显示，带点边框,边框是直接用margin实现的
    UICellButton *roundLeftBorderImage = [[UICellButton alloc]initWithFrame:CGRectMake(leftpadding, 10.0, 200, 40.0)];
    //图像路径
    path = [resourcePath stringByAppendingPathComponent:@"lamp-2_128px.png"];
    //创建图片
    image = [UIImage imageWithContentsOfFile:path];
    [roundLeftBorderImage setImage:image forState:UIControlStateNormal];
    [roundLeftBorderImage setTitle:@"台灯物语" forState:UIControlStateNormal];
    [roundLeftBorderImage setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [roundLeftBorderImage setBackgroundColor:[UIColor colorWithRed:176.0/255.0 green:196.0/255.0 blue:222.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    roundLeftBorderImage.horizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    roundLeftBorderImage.layoutType = UITButtonLayoutTypeLeftRight;
    roundLeftBorderImage.marginInsets = UIEdgeInsetsMake(3.0, 3.0, 3.0, 40.0);
    roundLeftBorderImage.titleFill = YES;
    
    roundLeftBorderImage.layer.cornerRadius = 20.0;
    
    roundLeftBorderImage.descriptionStr = @"图片放在最左边，边框用maring实现的。";
    [sectionarray addObject:roundLeftBorderImage];
    
    //-----------------图片在右边
    UICellButton *rightImageButton = [[UICellButton alloc]initWithFrame:CGRectMake(leftpadding, 10.0, 200, 40.0)];
    //图像路径
    path = [resourcePath stringByAppendingPathComponent:@"triangle_dark_up.png"];
    //创建图片
    image = [UIImage imageWithContentsOfFile:path];
    [rightImageButton setImage:image forState:UIControlStateNormal];
    [rightImageButton setTitle:@"Meetings" forState:UIControlStateNormal];
    rightImageButton.font = [UIFont boldSystemFontOfSize:18.0];
    rightImageButton.layoutType = UITButtonLayoutTypeLeftRight;
    rightImageButton.imageLocation = UITButtonImageLocationLast;
    
    rightImageButton.descriptionStr = @"图片放在右边，没有背景";
    [sectionarray addObject:rightImageButton];
    
    
    //-----------------加号和边框
    UICellButton *addButton = [[UICellButton alloc]initWithFrame:CGRectMake(leftpadding, 10.0, 120, 40.0)];
    //图像路径
    path = [resourcePath stringByAppendingPathComponent:@"add-box.png"];
    //创建图片
    image = [UIImage imageWithContentsOfFile:path];
    [addButton setImage:image forState:UIControlStateNormal];
    [addButton setTitle:@"1" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    addButton.font = [UIFont boldSystemFontOfSize:18.0];
    addButton.layoutType = UITButtonLayoutTypeLeftRight;
    addButton.imageLocation = UITButtonImageLocationLast;
    addButton.titleFill = YES;
    
    addButton.titleLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    addButton.titleLabel.layer.borderWidth = 1.0;
    addButton.titleLabel.layer.cornerRadius = 3.0;
    addButton.titleLabel.layer.masksToBounds = YES;
    
    addButton.descriptionStr = @"加号，数字带边框";
    [sectionarray addObject:addButton];
    
    
    //-----------------右边有一个小的箭头表示可以点击显示一些东西
    UICellButton *selectMore = [[UICellButton alloc]initWithFrame:CGRectMake(leftpadding, 10.0, 200, 40.0)];
    //图像路径
    path = [resourcePath stringByAppendingPathComponent:@"arrowup.png"];
    NSString *pathselect = [resourcePath stringByAppendingPathComponent:@"arrowdown.png"];
    //创建图片
    image = [UIImage imageWithContentsOfFile:path];
    UIImage *selectimage = [UIImage imageWithContentsOfFile:pathselect];
    [selectMore setImage:image forState:UIControlStateNormal];
    [selectMore setImage:selectimage forState:UIControlStateSelected];
    [selectMore setTitle:@"点击选择" forState:UIControlStateNormal];
    [selectMore setTitle:@"选中状态" forState:UIControlStateSelected];
    [selectMore setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    selectMore.layoutType = UITButtonLayoutTypeLeftRight;
    selectMore.imageLocation = UITButtonImageLocationLast;
    selectMore.horizontalAlignment = UIControlContentHorizontalAlignmentRight;
    selectMore.specifyImageSize = CGSizeMake(20.0, 0);
    selectMore.titleFill = YES;
    
    [selectMore addTarget:self action:@selector(actionSelect:) forControlEvents:UIControlEventTouchUpInside];
    
    selectMore.descriptionStr = @"右边有一个小的箭头表示可以点击显示一些东西，比方说actionsheet";
    [sectionarray addObject:selectMore];
    
    
    //-----------------图片与文字各一半
    UICellButton *halfBlack = [[UICellButton alloc]initWithFrame:CGRectMake(leftpadding, 10.0, 80, 40.0)];
    //图像路径
    path = [resourcePath stringByAppendingPathComponent:@"send_fill.png"];
    //创建图片
    image = [UIImage imageWithContentsOfFile:path];
    [halfBlack setImage:image forState:UIControlStateNormal];
    [halfBlack setTitle:@"send" forState:UIControlStateNormal];
    [halfBlack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    halfBlack.titleLabel.backgroundColor = [UIColor brownColor];
    halfBlack.imageView.backgroundColor = [UIColor purpleColor];
    //这里要设置右对齐，因为如果采用默认的居中，那么会先把图片居中，然后才把label在剩余的空间计算宽度。如果指定了specifyImageRect，就不会有这个问题了。
    halfBlack.horizontalAlignment = UIControlContentHorizontalAlignmentRight;
    halfBlack.layoutType = UITButtonLayoutTypeLeftRight;
    halfBlack.imageLocation = UITButtonImageLocationLast;
    halfBlack.marginInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    halfBlack.padding = 0.0;
    halfBlack.titleFill = YES;
    
    
    /**
     specifies an extension point identifier that is not supported on this version of iOS for the value of the NSExtensionPointIdentifier key in its Info.plist.*/
    
    halfBlack.descriptionStr = @"一半黑，一半白。";
    [sectionarray addObject:halfBlack];
    
    
    [self.buttonArray addObject:sectionarray];
    [self.sectionTitleArray addObject:@"图片和文本按钮,左右布局"];
}

/**只有图片的按钮*/
-(void)buttonsUpDown{
    NSMutableArray *sectionarray = [NSMutableArray new];
    
    //获取程序包内图片根路径
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    
    //图像路径
    NSString *path;
    UIImage *image;
    //创建图片
    
    //-----------------支付宝
    UICellButton *alibutton = [[UICellButton alloc]initWithFrame:CGRectMake(leftpadding, 10.0, 60.0, 80.0)];
    //图像路径
    path = [resourcePath stringByAppendingPathComponent:@"alipay.png"];
    //创建图片
    image = [UIImage imageWithContentsOfFile:path];
    [alibutton setImage:image forState:UIControlStateNormal];
    [alibutton setTitle:@"支付宝" forState:UIControlStateNormal];
    alibutton.font = [UIFont systemFontOfSize:13.0];
    
    alibutton.descriptionStr = @"支付宝，上下布局";
    [sectionarray addObject:alibutton];
    
    //-----------------支付宝
    UICellButton *alibutton2 = [[UICellButton alloc]initWithFrame:CGRectMake(leftpadding, 10.0, 60.0, 80.0)];
    //图像路径
    path = [resourcePath stringByAppendingPathComponent:@"alipay.png"];
    //创建图片
    image = [UIImage imageWithContentsOfFile:path];
    [alibutton2 setImage:image forState:UIControlStateNormal];
    [alibutton2 setTitle:@"支付宝" forState:UIControlStateNormal];
    alibutton2.font = [UIFont systemFontOfSize:13.0];
    alibutton2.marginInsets = UIEdgeInsetsMake(5.0, 10.0, 5.0, 10.0);
    
    alibutton2.descriptionStr = @"支付宝，稍微改变margin";
    [sectionarray addObject:alibutton2];
    
    //-----------------图像在下面
    UICellButton *titleButton = [[UICellButton alloc]initWithFrame:CGRectMake(leftpadding, 10.0, 100.0, 120.0)];
    //图像路径
    path = [resourcePath stringByAppendingPathComponent:@"rendaozhongnian.png"];
    //创建图片
    image = [UIImage imageWithContentsOfFile:path];
    [titleButton setImage:image forState:UIControlStateNormal];
    [titleButton setTitle:@"人到中年" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    titleButton.imageLocation = UITButtonImageLocationLast;
    titleButton.horizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    titleButton.specifyImageSize = CGSizeMake(90, 90);
    titleButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    titleButton.descriptionStr = @"文字在图片上方，居左,设置图片剪裁填充";
    [sectionarray addObject:titleButton];
    
    
    //-----------------下划线按钮
    UICellButton *underLineButton = [[UICellButton alloc]initWithFrame:CGRectMake(leftpadding, 10.0, 180.0, 30.0)];
    //图像路径
    path = [resourcePath stringByAppendingPathComponent:@"yellowSmall.png"];
    //创建图片
    image = [UIImage imageWithContentsOfFile:path];
    [underLineButton setImage:image forState:UIControlStateNormal];
    [underLineButton setTitle:@"this@this.com" forState:UIControlStateNormal];
    underLineButton.imageLocation = UITButtonImageLocationLast;
    underLineButton.specifyImageRect = CGRectMake(0.0, 27, 180.0, 3.0);
    underLineButton.imageView.contentMode = UIViewContentModeScaleToFill;
    
    underLineButton.descriptionStr = @"把图片弄成底部边框";
    [sectionarray addObject:underLineButton];
    
    //-----------------右下角箭头,左上角文字
    UICellButton *rightBottomArrow = [[UICellButton alloc]initWithFrame:CGRectMake(leftpadding, 10.0, 100.0, 60.0)];
    //图像路径
    path = [resourcePath stringByAppendingPathComponent:@"arrow-up-left.png"];
    //创建图片
    image = [UIImage imageWithContentsOfFile:path];
    [rightBottomArrow setImage:image forState:UIControlStateNormal];
    [rightBottomArrow setTitle:@"向右下看" forState:UIControlStateNormal];
    rightBottomArrow.imageLocation = UITButtonImageLocationLast;
    rightBottomArrow.horizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    rightBottomArrow.verticalAlignment = UIControlContentVerticalAlignmentTop;
    rightBottomArrow.marginInsets = UIEdgeInsetsMake(2.0, 2.0, 2.0, 2.0);
    rightBottomArrow.specifyImageRect = CGRectMake(80.0, 40.0, 20.0, 20.0);
    
    rightBottomArrow.layer.borderWidth = 1.0;
    rightBottomArrow.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    rightBottomArrow.descriptionStr = @"右下角箭头,左上角文字";
    [sectionarray addObject:rightBottomArrow];
    
    //-----------------下面长箭头,
    UICellButton *rightBottomLongArrow = [[UICellButton alloc]initWithFrame:CGRectMake(leftpadding, 10.0, 100.0, 60.0)];
    //图像路径
    path = [resourcePath stringByAppendingPathComponent:@"rightArrowLong.png"];
    //创建图片
    image = [UIImage imageWithContentsOfFile:path];
    [rightBottomLongArrow setImage:image forState:UIControlStateNormal];
    [rightBottomLongArrow setTitle:@"或者这样\n换个行" forState:UIControlStateNormal];
    rightBottomLongArrow.font = [UIFont systemFontOfSize:12.0];
    rightBottomLongArrow.imageLocation = UITButtonImageLocationLast;
    rightBottomLongArrow.marginInsets = UIEdgeInsetsMake(2.0, 2.0, 2.0, 2.0);
    rightBottomLongArrow.specifyImageRect = CGRectMake(30.0, 40.0, 70.0, 20.0);
    rightBottomLongArrow.titleLabel.numberOfLines = 0;
    rightBottomLongArrow.titleLabel.textAlignment = NSTextAlignmentRight;
    rightBottomLongArrow.titleFill = YES;

    rightBottomLongArrow.layer.borderWidth = 1.0;
    rightBottomLongArrow.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    rightBottomLongArrow.descriptionStr = @"右下角一个长的箭头,左上角文字";
    [sectionarray addObject:rightBottomLongArrow];
    
    //-----------------visa
    UICellButton *visa = [[UICellButton alloc]initWithFrame:CGRectMake(leftpadding, 10.0, 200.0, 120.0)];
    //图像路径
    path = [resourcePath stringByAppendingPathComponent:@"visa.png"];
    //创建图片
    image = [UIImage imageWithContentsOfFile:path];
    [visa setImage:image forState:UIControlStateNormal];
    [visa setTitle:@"XXXX XXXX XXXX XX90" forState:UIControlStateNormal];
    [visa setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [visa setBackgroundColor:[UIColor colorWithRed:66.0/255.0 green:87.0/255.0 blue:184.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    visa.titleLabel.adjustsFontSizeToFitWidth = YES;
    visa.imageLocation = UITButtonImageLocationLast;
    visa.titleFill = YES;
    //下面是用指定对齐的方式来实现的右下角小图标。把margin的top值加上图片的高度，就能让label居中对齐。
    visa.marginInsets = UIEdgeInsetsMake(35.0, 5.0, 5.0, 5.0);
    visa.horizontalAlignment = UIControlContentHorizontalAlignmentRight;
    visa.verticalAlignment = UIControlContentVerticalAlignmentBottom;
    visa.specifyImageSize = CGSizeMake(0, 30);
    
    visa.layer.cornerRadius = 8.0;
    
    visa.descriptionStr = @"visa 卡";
    [sectionarray addObject:visa];
    
    //-----------------bottom add
    UICellButton *bottomAdd = [[UICellButton alloc]initWithFrame:CGRectMake(leftpadding, 10.0, 60.0, 80.0)];
    //图像路径
    path = [resourcePath stringByAppendingPathComponent:@"add-2.png"];
    //创建图片
    image = [UIImage imageWithContentsOfFile:path];
    [bottomAdd setImage:image forState:UIControlStateNormal];
    [bottomAdd setTitle:@"11" forState:UIControlStateNormal];
    [bottomAdd setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    bottomAdd.imageLocation = UITButtonImageLocationLast;
    bottomAdd.titleFill = YES;
    bottomAdd.specifyImageRect = CGRectMake(0.0, 55, 60, 25);
    
    bottomAdd.imageView.backgroundColor = [UIColor lightGrayColor];
    bottomAdd.font = [UIFont boldSystemFontOfSize:20];
    
    //如果图片本身的加号周围没有留空，那就只能通过修改contentMode和图片本身的大小来实现效果。
    bottomAdd.imageView.contentMode = UIViewContentModeCenter;
    
    bottomAdd.layer.cornerRadius = 8.0;
    bottomAdd.layer.borderColor = [UIColor lightGrayColor].CGColor;
    bottomAdd.layer.borderWidth = 1.0;
    bottomAdd.layer.masksToBounds = YES;
    
    bottomAdd.descriptionStr = @"底部来一个加号\n如果图片本身的加号周围没有留空，那就只能通过修改contentMode来实现展示。";
    [sectionarray addObject:bottomAdd];
    
    //-----------------美女
    UICellButton *meinv = [[UICellButton alloc]initWithFrame:CGRectMake(leftpadding, 10.0, 200.0, 130.0)];
    //图像路径
    path = [resourcePath stringByAppendingPathComponent:@"beautify.png"];
    //创建图片
    image = [UIImage imageWithContentsOfFile:path];
    [meinv setImage:image forState:UIControlStateNormal];
    [meinv setTitle:@"桃花，美女" forState:UIControlStateNormal];
    [meinv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    meinv.titleFill = YES;
    meinv.marginInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    meinv.padding = 0;
    
    meinv.imageView.contentMode = UIViewContentModeScaleAspectFill;
    meinv.specifyImageRect = CGRectMake(0.0, 0.0, 200, 100);
    meinv.titleLabel.backgroundColor = [UIColor colorWithRed:103.0/255.0 green:114.0/255.0 blue:230.0/255.0 alpha:1.0];
    meinv.font = [UIFont boldSystemFontOfSize:13];
    
    meinv.layer.cornerRadius = 8.0;
    meinv.layer.masksToBounds = YES;
    
    meinv.descriptionStr = @"美女图片。因为计算图片frame的时候没有考虑contentmode，所以必须用specifyImageRect实现";
    [sectionarray addObject:meinv];
    
    [self.buttonArray addObject:sectionarray];
    [self.sectionTitleArray addObject:@"上下布局的按钮"];
}

/**只有标题的按钮*/
- (void)buttonsWithOnlyTitle{
    
}

/**不同渲染方式的按钮*/
- (void)buttonOfRenderingMode{
    
}

#pragma mark - action

-(void)actionSelect:(UIControl *)sender{
    NSLog(@"will set selected :%i",!sender.selected);
    sender.selected = !sender.selected;
    
}

@end
