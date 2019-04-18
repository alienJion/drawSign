//
//  SignBezierPath.h
//  OAProject
//
//  Created by Alien on 2019/4/18.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignBezierPath : UIBezierPath
/**
 设置当前签名轨迹路径颜色
 */
@property(nonatomic,strong)UIColor *color;
@end

NS_ASSUME_NONNULL_END
