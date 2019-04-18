//
//  DrawView.m
//  OAProject
//
//  Created by Alien on 2019/4/18.
//  Copyright © 2019 ouwen. All rights reserved.
//

#import "DrawView.h"
#import "SignBezierPath.h"
#define StrWidth 210
#define StrHeight 20
@interface DrawView()
/**当前绘制的路径*/
@property (nonatomic,strong)SignBezierPath *path;
/**保存当前绘制的所有路径*/
@property (nonatomic,strong)NSMutableArray *allPathArray;
/**当前路径线条宽度*/
@property (nonatomic,assign)CGFloat pathLienWidth;
/**当前路径线条颜色*/
@property (nonatomic,strong)UIColor *pathLienColor;
@end

@implementation DrawView
-(NSMutableArray *)allPathArray{
    if (_allPathArray == nil) {
        _allPathArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _allPathArray;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addPan];
    }
    return self;
}
/**
 xib加载完成后添加手势
 */
-(void)awakeFromNib{
    [super awakeFromNib];
    [self addPan];
}
//给当前view添加手势
-(void)addPan{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    self.pathLienWidth = 2;
    self.pathLienColor = [UIColor blackColor];
}
-(void)pan:(UIPanGestureRecognizer *)pan{
    //    获取当前手指的点
    CGPoint curP = [pan locationInView:self];
    //    判断手势状态
    if (pan.state == UIGestureRecognizerStateBegan) {//开始
        //        创建路径
        SignBezierPath *path = [[SignBezierPath alloc]init];
        //        设置线条宽度
        path.lineWidth = self.pathLienWidth;
        //        设置颜色
        path.color = self.pathLienColor;
        //        设置起点
        [path moveToPoint:curP];
        self.path = path;
        [self.allPathArray addObject:path];
    }else if(pan.state == UIGestureRecognizerStateChanged){//发生改变
        //        绘制一根线到当前手指所在的点
        [self.path addLineToPoint:curP];
        //        绘制
        [self setNeedsDisplay];
    }
}
//清屏
-(void)clear{
    //    清空所有路径
    [self.allPathArray removeAllObjects];
    [self setNeedsDisplay];
}
//撤销
-(void)undo{
    //    删除最后一个并重新绘制
    [self.allPathArray removeLastObject];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    if(self.allPathArray.count == 0){
        [self stringDraw];
    }
    //    绘制所有的路径
    for (SignBezierPath *path in self.allPathArray) {
        [path.color set];
        [path stroke];
        
    }
}

-(void)stringDraw{
    NSString *str = @"此处手写签名: 正楷, 工整书写";
    //        设置文字显示位置
    CGRect rect1 = CGRectMake((self.bounds.size.width - StrWidth)/2, self.bounds.size.height * (1 - 0.618)  ,StrWidth, StrHeight);
    UIFont  *font = [UIFont systemFontOfSize:15];//设置字体
    UIColor *whiteColor = [UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1];
    //        开始把NSString写到画布上
    [str drawInRect:rect1 withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:whiteColor}];
}


@end
