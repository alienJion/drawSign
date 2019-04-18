//
//  DrawView.h
//  OAProject
//
//  Created by Alien on 2019/4/18.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DrawView : UIView
//清屏
-(void)clear;
//撤销
-(void)undo;
@end

NS_ASSUME_NONNULL_END
