//
//  LsPracticeViewController.m
//  lss
//
//  Created by apple on 2017/7/25.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsPracticeViewController.h"
#import "LsChooseView.h"

@interface LsPracticeViewController ()<chooseViewDelegate>

@property (nonatomic,strong)  LsChooseView *chooseView;

@end

@implementation LsPracticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    superView.backgroundColor =[UIColor redColor];
    self.navView.navTitle =@"练课";
    [self.navView.rightButton setImage:[UIImage imageNamed:@"sl"] forState:UIControlStateNormal];
    [self.navView.rightButton setImage:[UIImage imageNamed:@"xl"] forState:UIControlStateSelected];
    [self.navView.rightButton addTarget:self action:@selector(didClickNavViewRightBtn:) forControlEvents:UIControlEventTouchUpInside];

    [superView addSubview:self.chooseView];
}

-(void)didClickNavViewRightBtn:(UIButton *)btn{
    if (btn.selected) {
        btn.selected=NO;
        self.chooseView.hidden=YES;
    }else{
        btn.selected=YES;
        self.chooseView.hidden=NO;
    }
}

- (void)chooseBtn:(LsButton*)button{
    [LsMethod alertMessage:button.videoID WithTime:1.5];
    [self performSelector:@selector(hiddenChooseView) withObject:nil afterDelay:0.25];
//    [self hiddenChooseView];
}

-(LsChooseView *)chooseView{
    if (!_chooseView) {
        _chooseView           =[[LsChooseView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), LSMainScreenW, 70*LSScale)];
        _chooseView.dataArray =@[@{@"title":@"全部",@"ID":@"10"},
                                 @{@"title":@"说课",@"ID":@"11"},
                                 @{@"title":@"试讲",@"ID":@"12"},
                                 @{@"title":@"结构化",@"ID":@"13"},
                                 @{@"title":@"答辩",@"ID":@"14"}];
        _chooseView.hidden    =YES;
        _chooseView.delegate  =self;
    }
    return _chooseView;
}

-(void)hiddenChooseView{
    self.chooseView.hidden              =YES;
    self.navView.rightButton.selected   =NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self hiddenChooseView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
