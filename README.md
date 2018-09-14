# HWGuideMaskView

[![CI Status](https://img.shields.io/travis/571100944@qq.com/HWGuideMaskView.svg?style=flat)](https://travis-ci.org/571100944@qq.com/HWGuideMaskView)
[![Version](https://img.shields.io/cocoapods/v/HWGuideMaskView.svg?style=flat)](https://cocoapods.org/pods/HWGuideMaskView)
[![License](https://img.shields.io/cocoapods/l/HWGuideMaskView.svg?style=flat)](https://cocoapods.org/pods/HWGuideMaskView)
[![Platform](https://img.shields.io/cocoapods/p/HWGuideMaskView.svg?style=flat)](https://cocoapods.org/pods/HWGuideMaskView)

## 简介
一个显示用户引导的工具类，可以在一个页面添加多个用户引导。

## 安装

```ruby
pod 'HWGuideMaskView'
```

## Demo

```objc
NSMutableArray *models = [[NSMutableArray alloc] init];
    
    CGRect topRect = [self.view convertRect:self.topBtn.frame toView:nil];
    
    HWGuideInfoModel *topModel = [[HWGuideInfoModel alloc] init];
    topModel.text = @"实时查看每月预计市场补贴";
    topModel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
    topModel.arrowImageName = @"pic_indicator strip_1";
    topModel.frameBaseWindow = topRect;
    topModel.insetEdge = UIEdgeInsetsMake(-8, -8, -8, -8);
    topModel.space = 15;
    topModel.itemRegion = HWGuideMaskItemRegion_top;
    [models addObject:topModel];
    
    HWGuideMaskView *guideMaskView = [[HWGuideMaskView alloc] initWithFrame:self.view.bounds];
    [guideMaskView showMaskWithDatas:models];

```


## License

HWGuideMaskView is available under the MIT license. See the LICENSE file for more info.
