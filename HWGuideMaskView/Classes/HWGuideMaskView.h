//
//  HWGuideMaskView.h
//  newhwmc
//
//  Created by sunbinhua on 2018/9/3.
//  Copyright © 2018年 paidian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    HWGuideMaskItemRegion_top = 0,
    HWGuideMaskItemRegion_left,
    HWGuideMaskItemRegion_bottom,
    HWGuideMaskItemRegion_right,
    HWGuideMaskItemRegion_leftTop,
    HWGuideMaskItemRegion_leftBottom,
    HWGuideMaskItemRegion_rightTop,
    HWGuideMaskItemRegion_rightBottom,
} HWGuideMaskItemRegion;



@interface HWGuideInfoModel : NSObject

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) NSAttributedString *attributeText;

@property (nonatomic, strong) UIFont *font;

//图片名字
@property (nonatomic, copy) NSString *arrowImageName;

//每个 item 的 view 蒙板的圆角：默认为 5
@property (nonatomic, assign) CGFloat maskCornerRadius;

//每个 item 的 view 与蒙板的边距：默认 (-8, -8, -8, -8)
@property (nonatomic, assign) UIEdgeInsets insetEdge;

//每个 item 的子视图（当前介绍的子视图、箭头、描述文字）之间的间距：默认为 20
@property (nonatomic, assign) CGFloat space;

//每个 item 的文字与左右边框间的距离：默认为 50
@property (nonatomic, assign) CGFloat horizontalInset;

//相对window的frame
@property (nonatomic, assign) CGRect frameBaseWindow;

//arrow相对windowd的frame
@property (nonatomic, assign) CGRect arrowFrameBaseWindow;

//text相对window的frame
@property (nonatomic, assign) CGRect textFrameBaseWindow;

@property (nonatomic, assign) HWGuideMaskItemRegion itemRegion;

@end


@interface HWGuideMaskView : UIView

- (void)showMaskWithDatas:(NSMutableArray *)showDatas;

@end

NS_ASSUME_NONNULL_END
