//
//  HWGuideMaskView.m
//  newhwmc
//
//  Created by sunbinhua on 2018/9/3.
//  Copyright © 2018年 paidian. All rights reserved.
//

#import "HWGuideMaskView.h"

@implementation HWGuideInfoModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _font = [UIFont systemFontOfSize:13];
        _textColor = [UIColor whiteColor];
        _maskCornerRadius = 5;
        _insetEdge = UIEdgeInsetsMake(-8, -8, -8, -8);
        _space = 20;
        _horizontalInset = 50;
        _frameBaseWindow = CGRectZero;
        _itemRegion = HWGuideMaskItemRegion_top;
        _arrowFrameBaseWindow = CGRectZero;
        _textFrameBaseWindow = CGRectZero;
    }
    return self;
}

@end

#pragma mark ---

@interface HWGuideMaskView ()

@property (nonatomic, strong) NSMutableArray<HWGuideInfoModel*> *showDatas;

@property (nonatomic, strong) UIView *maskLayerView;
@property (nonatomic, strong) CAShapeLayer *maskLayer;

@property (nonatomic, strong) UILabel *textLab;
@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, assign) CGFloat maskAlpha;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation HWGuideMaskView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self initParameters];
        [self setUpUI];
    }
    return self;
}

- (void)initParameters {
    _maskAlpha = 0.7;
}

#pragma mark - public

- (void)showMaskWithDatas:(NSMutableArray *)showDatas{
    
    if (showDatas.count == 0) {
        return;
    }
    
    self.showDatas = showDatas;
    self.currentIndex = 0;
    
    UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
    [keyWindow addSubview:self];
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    }];
}

#pragma mark - private

- (void)showItemWithData:(HWGuideInfoModel *)guideInfoModel {
    
//    CGPathRef fromPath = self.maskLayer.path;
    self.maskLayer.fillColor = [UIColor blackColor].CGColor;
    
    //可见区域路径
    UIBezierPath *visualPath = [UIBezierPath bezierPathWithRoundedRect:[self fetchVisualFrame] cornerRadius:guideInfoModel.maskCornerRadius];
    
    //终点路径
    UIBezierPath *toPath = [UIBezierPath bezierPathWithRect:self.bounds];
    [toPath appendPath:visualPath];
    
    //遮罩的路径
    self.maskLayer.path = toPath.CGPath;
    self.maskLayer.fillRule = kCAFillRuleEvenOdd;
    self.layer.mask = self.maskLayer;
    
    //开始移动动画
    CABasicAnimation *anim = [[CABasicAnimation alloc] init];
    anim.duration = 0.3;
    anim.fromValue = [NSNumber numberWithFloat:0];
    anim.toValue = [NSNumber numberWithFloat:1];

    [self.maskLayer addAnimation:anim forKey:nil];
}

- (CGRect)fetchVisualFrame {
    
    if (self.currentIndex >= self.showDatas.count) {
        return CGRectZero;
    }
    HWGuideInfoModel *guideInfoModel = self.showDatas[self.currentIndex];
    
    CGRect visualRect = guideInfoModel.frameBaseWindow;
    visualRect.origin.x += guideInfoModel.insetEdge.left;
    visualRect.origin.y += guideInfoModel.insetEdge.top;
    visualRect.size.width -= (guideInfoModel.insetEdge.left + guideInfoModel.insetEdge.right);
    visualRect.size.height -= (guideInfoModel.insetEdge.top + guideInfoModel.insetEdge.bottom);
    
    return visualRect;
}

- (void)configItemsFrameWithData:(HWGuideInfoModel *)guideInfoModel {
    
    self.textLab.text = guideInfoModel.text;
    self.textLab.textColor = guideInfoModel.textColor;
    self.textLab.font = guideInfoModel.font;
    if (guideInfoModel.attributeText != nil) {
        self.textLab.attributedText = guideInfoModel.attributeText;
    }
    
    if (guideInfoModel.arrowImageName) {
        self.arrowImageView.image = [UIImage imageNamed:guideInfoModel.arrowImageName];
    }
    
    // 设置 文字 与 箭头的位置
    CGRect textRect = CGRectZero;
    CGRect arrowRect = CGRectZero;
    CGSize imgSize = self.arrowImageView.image? self.arrowImageView.image.size: CGSizeZero;
    CGFloat maxWidth = self.bounds.size.width - guideInfoModel.horizontalInset*2;
    
    CGSize textSize = CGSizeZero;
    if (guideInfoModel.text && guideInfoModel.text.length > 0) {
        textSize = [guideInfoModel.text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: guideInfoModel.font} context:nil].size;
    }
    
    CGRect visualFrame = [self fetchVisualFrame];
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    if ([[NSValue valueWithCGRect: guideInfoModel.arrowFrameBaseWindow ] isEqualToValue:[NSValue valueWithCGRect:CGRectZero]]) {
        
        CGFloat x = 0;
        
        // 获取item的方位
        switch (guideInfoModel.itemRegion) {
            case HWGuideMaskItemRegion_top:
            {
                transform = CGAffineTransformScale(transform, -1, 1);
                CGFloat img_x = (CGRectGetWidth(self.bounds) - (textSize.width + guideInfoModel.space + imgSize.width))*0.5;
                arrowRect = CGRectMake(img_x, CGRectGetMaxY(visualFrame) + imgSize.height, imgSize.width, imgSize.height);
                textRect = CGRectMake(CGRectGetMaxX(arrowRect) + guideInfoModel.space, CGRectGetMinY(arrowRect) - 5.0, textSize.width, textSize.height);
            }
                break;
            case HWGuideMaskItemRegion_left:
            {
                arrowRect = CGRectMake(CGRectGetMaxX(visualFrame), CGRectGetMinY(visualFrame) + 18, imgSize.width, imgSize.height);
                textRect = CGRectMake(CGRectGetMaxX(arrowRect) + guideInfoModel.space, CGRectGetMinY(arrowRect) - 5.0, textSize.width, textSize.height);
            }
                break;
            case HWGuideMaskItemRegion_bottom:
            {
                CGFloat img_x = (CGRectGetWidth(self.bounds) - (textSize.width + guideInfoModel.space + imgSize.width))*0.5;
                arrowRect = CGRectMake(img_x, CGRectGetMinY(visualFrame) - imgSize.height, imgSize.width, imgSize.height);
                textRect = CGRectMake(CGRectGetMaxX(arrowRect) + guideInfoModel.space, CGRectGetMinY(arrowRect) - 5.0, textSize.width, textSize.height);
            }
                break;
            case HWGuideMaskItemRegion_right:
            {
                transform = CGAffineTransformScale(transform, 1, -1);
                arrowRect = CGRectMake(CGRectGetMinX(visualFrame) - imgSize.width, CGRectGetMinY(visualFrame) + 18, imgSize.width, imgSize.height);
                textRect = CGRectMake(CGRectGetMinX(arrowRect) - guideInfoModel.space - textSize.width, CGRectGetMinY(arrowRect) - 5.0, textSize.width, textSize.height);
            }
                break;
            case HWGuideMaskItemRegion_leftTop:
                
                arrowRect = CGRectMake(CGRectGetMidX(visualFrame) - imgSize.width * 0.5, CGRectGetMaxY(visualFrame) + guideInfoModel.space, imgSize.width, imgSize.height);
                if (textSize.width < visualFrame.size.width) {
                    x = CGRectGetMaxX(arrowRect) - textSize.width*0.5;
                }else{
                    x = guideInfoModel.horizontalInset;
                }
                textRect = CGRectMake(x, CGRectGetMaxY(arrowRect), textSize.width, textSize.height);
                
                break;
            case HWGuideMaskItemRegion_leftBottom:
                
                arrowRect = CGRectMake(CGRectGetMidX(visualFrame) - imgSize.width * 0.5, CGRectGetMinY(visualFrame) - guideInfoModel.space - imgSize.height, imgSize.width, imgSize.height);
                if (textSize.width < visualFrame.size.width) {
                    x = CGRectGetMaxX(arrowRect) - textSize.width * 0.5;
                }else{
                    x = guideInfoModel.horizontalInset;
                }
                textRect = CGRectMake(x, CGRectGetMinY(arrowRect) - guideInfoModel.space - textSize.height, textSize.width, textSize.height);
                
                break;
            case HWGuideMaskItemRegion_rightTop:
                
                arrowRect = CGRectMake(CGRectGetMidX(visualFrame) - imgSize.width * 0.5, CGRectGetMaxY(visualFrame) + guideInfoModel.space, imgSize.width, imgSize.height);
                if (textSize.width < visualFrame.size.width) {
                    x = CGRectGetMinX(arrowRect) - textSize.width * 0.5;
                }else{
                    x = guideInfoModel.horizontalInset + maxWidth - textSize.width;
                }
                textRect = CGRectMake(x, CGRectGetMaxY(arrowRect), textSize.width, textSize.height);
                
                break;
            case HWGuideMaskItemRegion_rightBottom:
                
                arrowRect = CGRectMake(CGRectGetMidX(visualFrame) - imgSize.width * 0.5, CGRectGetMaxY(visualFrame) - guideInfoModel.space - imgSize.height, imgSize.width, imgSize.height);
                if (textSize.width < visualFrame.size.width) {
                    x = CGRectGetMinX(arrowRect) - textSize.width * 0.5;
                }else{
                    x = guideInfoModel.horizontalInset + maxWidth - textSize.width;
                }
                textRect = CGRectMake(x, CGRectGetMinY(arrowRect) - guideInfoModel.space - imgSize.height, textSize.width, textSize.height);
                
                break;
                
            default:
                break;
        }
    }else{
        arrowRect = guideInfoModel.arrowFrameBaseWindow;
        textRect = guideInfoModel.textFrameBaseWindow;
    }
    
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.arrowImageView.frame = arrowRect;
        self.textLab.frame = textRect;
    }];
    
}

#pragma mark - touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.currentIndex < self.showDatas.count - 1) {
        self.currentIndex = self.currentIndex + 1;
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}


#pragma mark - UI

- (void)setUpUI {
    
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.maskLayerView];
    [self addSubview:self.textLab];
    [self addSubview:self.arrowImageView];
}

#pragma mark - setter

- (void)setMaskAlpha:(CGFloat)maskAlpha {
    if (_maskAlpha != maskAlpha) {
        _maskAlpha = maskAlpha;
        self.maskLayerView.alpha = _maskAlpha;
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    if (self.showDatas.count > currentIndex) {
        [self showItemWithData:self.showDatas[currentIndex]];
        [self configItemsFrameWithData:self.showDatas[currentIndex]];
    }
}

#pragma mark - getter

- (UIView *)maskLayerView {
    if (!_maskLayerView) {
        _maskLayerView = [[UIView alloc] initWithFrame:self.bounds];
        _maskLayerView.backgroundColor = UIColor.blackColor;
        _maskLayerView.alpha = self.maskAlpha;
    }
    return _maskLayerView;
}

- (CAShapeLayer *)maskLayer {
    if (!_maskLayer) {
        _maskLayer = [[CAShapeLayer alloc] init];
        _maskLayer.frame = self.bounds;
    }
    return _maskLayer;
}

- (UILabel *)textLab {
    if (!_textLab) {
        _textLab = [UILabel new];
        _textLab.textColor = [UIColor whiteColor];
        _textLab.font = [UIFont systemFontOfSize:13];
        _textLab.numberOfLines = 0;
    }
    return _textLab;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"pic_indicator strip_1"];
    }
    return _arrowImageView;
}

@end
