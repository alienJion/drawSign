//
//  ViewController.m
//  MyDrawSign
//
//  Created by Alien on 2019/4/18.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "ViewController.h"
#import "DrawSignViewController.h"//手绘签名
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)drawSignEvent:(id)sender {
    DrawSignViewController *drawSignVC = [[DrawSignViewController alloc]init];
    drawSignVC.view.backgroundColor = [UIColor clearColor];
    drawSignVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    drawSignVC.drawSignViewBlock = ^(UIImage * _Nonnull drawSignImage) {
        self.showImageView.image = drawSignImage;
    };
    [self presentViewController:drawSignVC animated:YES completion:nil];
}


@end
