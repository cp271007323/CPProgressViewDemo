//
//  ViewController.m
//  CPProgressView
//
//  Created by lk03 on 2017/8/24.
//  Copyright © 2017年 chenp. All rights reserved.
//

#import "ViewController.h"
#import "CPProgressView.h"

@interface ViewController ()
@property (nonatomic , strong) CPProgressView *progressView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.progressView = [CPProgressView progressViewWithSuperView:self.view radius:30];
    self.progressView.progressColor = [UIColor whiteColor];
    self.progressView.progressBackgroundColor = [[UIColor blueColor] colorWithAlphaComponent:.7];
    [self.view addSubview:self.progressView];
    
    self.view.backgroundColor = [UIColor yellowColor];
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(test)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)test{

    static CGFloat progress = 0.0;
    
    
    [self.progressView setProgress:progress type:CPProgressSizeType_zero2Hundred complete:^{
        //最好设置成局部变量，用完就抛弃，不会发生内存泄露
        NSLog(@"完成后会自动移除视图");
    }];
    progress += 0.5;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
