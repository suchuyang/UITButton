//
//  ViewController.m
//  UITButtonDemo
//
//  Created by This on 2018/1/31.
//  Copyright © 2018年 This. All rights reserved.
//

#import "ViewController.h"

#import "ButtonContainerTableViewCell.h"
#import "ViewController+createButton.h"

#import "UITButton/UITButton.h"
#import "UICellButton.h"


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIButton *refreshButton;//!<重新定位的按钮

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.buttonArray = [NSMutableArray new];
    self.sectionTitleArray = [NSMutableArray new];
    
    self.tableview = [[UITableView alloc]init];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:self.tableview];
    
//    self.refreshButton = [[UIButton alloc]initWithFrame:CGRectMake(20.0, 200.0, 40.0, 40.0)];
//    self.refreshButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.refreshButton.layer.cornerRadius = 5.0;
//    self.refreshButton.layer.borderWidth = 0.5;
//    self.refreshButton.layer.masksToBounds = YES;
//    [self.refreshButton setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
//    [self.refreshButton addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.refreshButton];
    
    [self buttonsWithImageAndTitle];
    
    [self buttonsUpDown];
}

- (void)viewDidAppear:(BOOL)animated{
    self.tableview.frame = self.view.bounds;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - actions
/** 刷新定位和红包
 */
- (void)refreshAction:(UIButton *)sender{
    
    CABasicAnimation *caani = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    caani.toValue = [NSNumber numberWithFloat:M_PI *2];
    caani.removedOnCompletion = NO;
    caani.repeatCount = HUGE_VALF;
    caani.fillMode = kCAFillModeForwards;
    caani.duration = 1.0;
    [self.refreshButton.imageView.layer addAnimation:caani forKey:caani.keyPath];
}

#pragma mark - UITableViewDataSource<NSObject>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.buttonArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *buttons = self.buttonArray[section];
    return buttons.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifierString = @"reuseIdentifierString";
    
    ButtonContainerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierString];
    if(cell == nil){
        cell = [[ButtonContainerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifierString];
    }
    
    NSArray *sectionArray = self.buttonArray[indexPath.section];
    
    UICellButton *button = sectionArray[indexPath.row];
    
    cell.button = button;
    cell.descriptionLabel.text = button.descriptionStr;
    
    if(indexPath.row == sectionArray.count - 1){
        cell.showBorder = NO;
    }
    else{
        cell.showBorder = YES;
    }
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *sectionArray = self.buttonArray[indexPath.section];
    
    UITButton *button = sectionArray[indexPath.row];
    
    return button.frame.size.height + 20.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.sectionTitleArray[section];
}


@end
