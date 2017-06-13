//
//  MainViewController.m
//  Linear Algebra
//
//  Created by ml on 2017/6/12.
//  Copyright © 2017年 Noskthing. All rights reserved.
//

#import "MainViewController.h"
#import "LATextField.h"

static NSString * MainVCTableViewCellID = @"MainVCTableViewCellID";

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray * dataSource;

@property (nonatomic, strong)UITableView * tableView;

@property (nonatomic, strong)LATextField * textField;

@property (nonatomic, assign)BOOL keybordIsShow;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initVar];
    [self createUI];
    
}

- (void)initVar
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //监听当键将要退出时
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    self.dataSource = [NSMutableArray array];
    self.keybordIsShow = NO;
}

-(void)createUI
{
    self.view.backgroundColor = [UIColor grayColor];
//    
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50) style:UITableViewStylePlain];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MainVCTableViewCellID];
//    [self.view addSubview:self.tableView];
//    
//    self.textField = [[LATextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), self.view.frame.size.width, 50)];
//    [self.textField.okBtn addTarget:self action:@selector(okBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.textField];
    LATextFieldView * textView = [[LATextFieldView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height * 0.55, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.45)];
    [self.view addSubview:textView];
}

#pragma mark  textfield events
- (void)keyboardWillShow:(NSNotification *)notification
{
    if (self.keybordIsShow)
    {
        return;
    }
    CGRect kbRect = [notification.userInfo[@"UIKeyboardBoundsUserInfoKey"] CGRectValue];

    NSLog(@"--------%@",notification.userInfo);
    CGRect TVRect = self.tableView.frame;
    NSLog(@"---------%f",kbRect.size.height);
    TVRect.size.height -= kbRect.size.height;
    self.tableView.frame = TVRect;
    
    
    CGRect TFRext = self.textField.frame;
    TFRext.origin.y -= kbRect.size.height;
    self.textField.frame = TFRext;
    
    self.keybordIsShow = YES;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    CGRect TVRect = self.tableView.frame;
    TVRect.size.height = self.view.frame.size.height - 50;
    self.tableView.frame = TVRect;
    
    CGRect TFRext = self.textField.frame;
    TFRext.origin.y = CGRectGetMaxY(self.tableView.frame);
    self.textField.frame = TFRext;
    
    self.keybordIsShow = NO;
}

- (void)okBtnTouched:(UIButton *)btn
{
    [_dataSource addObject:self.textField.text];
    [self.tableView reloadData];
    [self.textField resignFirstResponder];
}

#pragma mark  tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:MainVCTableViewCellID forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}
@end
