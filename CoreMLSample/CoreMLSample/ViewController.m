//
//  ViewController.m
//  CoreMLSample
//
//  Created by Stone.Yu on 2017/12/31.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "ViewController.h"
#import "VideoCapture.h"

@interface ViewController ()

@property (nonatomic, strong) VideoCapture *videoCapture;

@property (nonatomic, strong) UIView *videoView;
@property (nonatomic, strong) UILabel *resultLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.videoView];
    [self.view addSubview:self.resultLabel];
    
    [self.videoCapture startVideoCapture];
    
    __weak typeof(self) weakself = self;
    self.videoCapture.completeBlock = ^(NSString *result) {
        weakself.resultLabel.text = result;
    };
}

- (VideoCapture *)videoCapture
{
    if (!_videoCapture) {
        _videoCapture = [VideoCapture new];
    }
    
    return _videoCapture;
}

- (UIView *)videoView
{
    if (!_videoView) {
        _videoView = [[UIView alloc] initWithFrame:self.view.bounds];
        self.videoCapture.previewLayer.frame = _videoView.frame;
        [_videoView.layer addSublayer:self.videoCapture.previewLayer];
    }
    
    return _videoView;
}

- (UILabel *)resultLabel
{
    if (!_resultLabel) {
        _resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 50, self.view.bounds.size.width, 50)];
        _resultLabel.textColor = [UIColor greenColor];
        _resultLabel.textAlignment = NSTextAlignmentCenter;
        _resultLabel.font = [UIFont systemFontOfSize:20];
        _resultLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        _resultLabel.text = @"RESULT";
    }
    
    return _resultLabel;
}

@end
