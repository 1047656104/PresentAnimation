//
//  ViewController.m
//  PresentAnimation
//
//  Created by 刘璐 on 2017/7/7.
//  Copyright © 2017年 刘璐. All rights reserved.
//

#import "ViewController.h"
static NSString *const kbReusableCellIdentifier = @"kbReusableCellIdentifier";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) UIControl *coverView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}
- (void)removeAnimation {
    [UIView animateWithDuration:0.45 animations:^{
        self.tableView.frame                        = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
        self.coverView.backgroundColor             = [UIColor colorWithWhite:0 alpha:0.0];
    } completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.coverView];
    [UIView animateWithDuration:0.5 animations:^{
        self.coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.35];
        self.tableView.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds)- 70 *3 ,CGRectGetWidth([UIScreen mainScreen].bounds),70 *3);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kbReusableCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self removeAnimation];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 70;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kbReusableCellIdentifier];
    }
    return _tableView;
}
- (UIControl *)coverView {
    if (!_coverView) {
        _coverView = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))];
        _coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        [_coverView addTarget:self action:@selector(removeAnimation) forControlEvents:UIControlEventTouchUpInside];
        [_coverView addSubview:self.tableView];
    }
    return _coverView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
