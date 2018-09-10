//
//  HWViewController.m
//  HWGuideMaskView
//
//  Created by 571100944@qq.com on 09/10/2018.
//  Copyright (c) 2018 571100944@qq.com. All rights reserved.
//

#import "HWViewController.h"
#import <HWGuideMaskView/HWGuideMaskView.h>

@interface HWViewController ()

@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@property (weak, nonatomic) IBOutlet UIButton *topBtn;

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;

@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;

@end

@implementation HWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
}

- (IBAction)startBtnClick:(id)sender {
    
    NSMutableArray *models = [[NSMutableArray alloc] init];
    
    CGRect topRect = [self.view convertRect:self.topBtn.frame toView:nil];
    CGRect leftRect = [self.view convertRect:self.leftBtn.frame toView:nil];
    CGRect rightRect = [self.view convertRect:self.rightBtn.frame toView:nil];
    CGRect bottomRect = [self.view convertRect:self.bottomBtn.frame toView:nil];
    
    HWGuideInfoModel *topModel = [[HWGuideInfoModel alloc] init];
    topModel.text = @"实时查看每月预计市场补贴";
    topModel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
    topModel.arrowImageName = @"pic_indicator strip_1";
    topModel.frameBaseWindow = topRect;
    topModel.insetEdge = UIEdgeInsetsMake(-8, -8, -8, -8);
    topModel.space = 15;
    topModel.itemRegion = HWGuideMaskItemRegion_top;
    [models addObject:topModel];
    
    HWGuideInfoModel *leftModel = [[HWGuideInfoModel alloc] init];
    leftModel.text = @"实时查看每月预计市场补贴";
    leftModel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
    leftModel.arrowImageName = @"pic_indicator strip_3";
    leftModel.frameBaseWindow = leftRect;
    leftModel.insetEdge = UIEdgeInsetsMake(-8, -8, -8, -8);
    leftModel.space = 15;
    leftModel.itemRegion = HWGuideMaskItemRegion_left;
    [models addObject:leftModel];
    
    HWGuideInfoModel *rightModel = [[HWGuideInfoModel alloc] init];
    rightModel.text = @"实时查看每月预计市场补贴";
    rightModel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
    rightModel.arrowImageName = @"pic_indicator strip_3";
    rightModel.frameBaseWindow = rightRect;
    rightModel.insetEdge = UIEdgeInsetsMake(-8, -8, -8, -8);
    rightModel.space = 15;
    rightModel.itemRegion = HWGuideMaskItemRegion_right;
    [models addObject:rightModel];
    
    HWGuideInfoModel *bottomModel = [[HWGuideInfoModel alloc] init];
    bottomModel.text = @"实时查看每月预计市场补贴";
    bottomModel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
    bottomModel.arrowImageName = @"pic_indicator strip_1";
    bottomModel.frameBaseWindow = bottomRect;
    bottomModel.insetEdge = UIEdgeInsetsMake(-8, -8, -8, -8);
    bottomModel.space = 15;
    bottomModel.itemRegion = HWGuideMaskItemRegion_bottom;
    [models addObject:bottomModel];
    
    HWGuideMaskView *guideMaskView = [[HWGuideMaskView alloc] initWithFrame:self.view.bounds];
    [guideMaskView showMaskWithDatas:models];
}

- (IBAction)topBtnClick:(id)sender {
    
    
}

- (IBAction)leftBtnClick:(id)sender {
    
    
}

- (IBAction)rightBtnClick:(id)sender {
    
    
}

- (IBAction)bottomBtnClick:(id)sender {
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
