//
//  DrawSignViewController.m
//  OAProject
//
//  Created by Alien on 2019/4/18.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "DrawSignViewController.h"//手绘签名
#import "DrawView.h"
#define IS_IPHONE_X ([[UIScreen mainScreen] bounds].size.height > 736 ? YES : NO)
#define YBottomDangerArea (IS_IPHONE_X ? 34 : 0)
//使用16进制颜色值
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 主题颜色
#define YThemeColor UIColorFromRGB(0X1890FF)
@interface DrawSignViewController ()
@property(nonatomic,strong)UIButton *closeSignButton;// 关闭
@property(nonatomic,strong)UIButton *clearSignButton;// 清屏
@property(nonatomic,strong)UIButton *cancelSignButton;// 撤销
@property(nonatomic,strong)UIButton *submitSignButton;// 保存
@property(nonatomic,strong)DrawView *drawView;//绘制签名
@end

@implementation DrawSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self closeSignButton];
    [self clearSignButton];
    [self cancelSignButton];
    [self drawView];
    [self submitSignButton];
}

#pragma mark-----------Request-------------
#pragma mark-----------Delegate------------
#pragma mark-----------UI------------------
-(UIButton *)closeSignButton{
    if (_closeSignButton == nil) {
        _closeSignButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeSignButton.backgroundColor = [UIColor clearColor];
        [_closeSignButton addTarget:self action:@selector(closeSignViewController:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_closeSignButton];
        [_closeSignButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.offset(0);
            make.bottom.equalTo(self.clearSignButton.mas_top);
        }];
     }
    return _closeSignButton;
}
-(UIButton *)clearSignButton{
    if (_clearSignButton == nil) {
        _clearSignButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearSignButton setTitle:@"重签" forState:UIControlStateNormal];
        [_clearSignButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _clearSignButton.backgroundColor = YThemeColor;
        [_clearSignButton addTarget:self action:@selector(clearSignEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_clearSignButton];
        [_clearSignButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.bottom.equalTo(self.drawView.mas_top).offset(0);
            make.height.offset(44);
            make.width.offset([UIScreen mainScreen].bounds.size.width / 2 - 0.5);
        }];
    }
    return _clearSignButton;
}
-(UIButton *)cancelSignButton{
    if (_cancelSignButton == nil) {
        _cancelSignButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelSignButton setTitle:@"撤销" forState:UIControlStateNormal];
        [_cancelSignButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancelSignButton.backgroundColor = YThemeColor;
        [_cancelSignButton addTarget:self action:@selector(cancelSignEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_cancelSignButton];
        [_cancelSignButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.clearSignButton.mas_right).offset(1);
            make.bottom.equalTo(self.drawView.mas_top).offset(0);
            make.height.offset(44);
            make.width.offset([UIScreen mainScreen].bounds.size.width/2);
        }];
    }
    return _cancelSignButton;
}
-(DrawView *)drawView{
    if (_drawView == nil) {
        _drawView = [[DrawView alloc]init];
        _drawView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_drawView];
        [_drawView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.bottom.equalTo(self.submitSignButton.mas_top).offset(0);
            make.height.equalTo(self.view.mas_width).multipliedBy(0.618);;
        }];
    }
    return _drawView;
}
-(UIButton *)submitSignButton{
    if (_submitSignButton == nil) {
        _submitSignButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitSignButton setTitle:@"确定" forState:UIControlStateNormal];
        [_submitSignButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitSignButton.backgroundColor = YThemeColor;
        [_submitSignButton addTarget:self action:@selector(submitSignSignDraw:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_submitSignButton];
        [_submitSignButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.offset(0);
            make.bottom.offset(YBottomDangerArea);
            make.height.offset(44);
        }];
    }
    return _submitSignButton;
}

#pragma mark-----------Action--------------
-(void)closeSignViewController:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)clearSignEvent:(UIButton *)btn{
    [self.drawView clear];
}
-(void)cancelSignEvent:(UIButton *)btn{
    [self.drawView undo];
}
-(void)submitSignSignDraw:(UIButton *)btn{
    //    为保证签名可以放到任何背景颜色的view上，需要给签名view设置成透明色
    UIColor *color = self.drawView.backgroundColor;//获取签名view的原背景颜色
    self.drawView.backgroundColor = [UIColor clearColor];//修改背景颜色为透明色
    //    1、创建位图上下文
    UIGraphicsBeginImageContextWithOptions(self.drawView.bounds.size, NO, 0);
    //    2、把画板上的内容渲染到上下文当中
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.drawView.layer renderInContext:ctx];
    //    3、从上下文中取出一张图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    if (self.drawSignViewBlock) {
        self.drawSignViewBlock(image);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    //    4、关闭上下文
    UIGraphicsEndImageContext();
    self.drawView.backgroundColor = color;//还原背景颜色
}

#pragma mark-----------Func--------------

@end
