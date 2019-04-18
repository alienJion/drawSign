//
//  DrawSignViewController.h
//  OAProject
//
//  Created by Alien on 2019/4/18.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
NS_ASSUME_NONNULL_BEGIN

@interface DrawSignViewController : UIViewController
typedef void(^DrawSignViewBlock)(UIImage *drawSignImage);
@property(nonatomic,copy)DrawSignViewBlock drawSignViewBlock;
@end

NS_ASSUME_NONNULL_END
