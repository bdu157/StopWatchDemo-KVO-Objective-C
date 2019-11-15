//
//  ViewController.m
//  StopWatchDemo
//
//  Created by Dongwoo Pae on 11/15/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

#import "ViewController.h"
#import "LSIStopWatch.h"


//c pointer
void *KVOContext = &KVOContext;


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *startStopButton;

@property (nonatomic) LSIStopWatch *stopWatch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.stopWatch = [[LSIStopWatch alloc] init];
}

- (IBAction)resetStopWatch:(id)sender {
    [self.stopWatch reset];
}

- (IBAction)toggleStopWatch:(id)sender {
    if (self.stopWatch.isRunning) {
        [self.stopWatch stop];
    } else {
        [self.stopWatch start];
    }
}

-(void)updateViews
{
    if (self.stopWatch.isRunning) {
        [self.startStopButton setTitle:@"stop" forState:UIControlStateNormal];
    } else {
        [self.startStopButton setTitle:@"start" forState:UIControlStateNormal];
    }
    
    self.resetButton.enabled = (self.stopWatch.elapsedTime > 0);
    
    self.timeLabel.text = [self stringFromTimeInterval:self.stopWatch.elapsedTime];
}

- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval
{
    NSInteger timeIntervalAsInt = interval;
    NSInteger tenths = (interval - floor(interval)) * 10;
    NSInteger seconds = timeIntervalAsInt % 60;
    NSInteger minutes = (timeIntervalAsInt / 60) % 60;
    NSInteger hours = timeIntervalAsInt/ 3600;
    
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld.%ld", (long)hours,
            (long)minutes, (long)seconds, (long)tenths];
}


//KVO part
- (void)setStopWatch:(LSIStopWatch *)stopWatch
{
    if (stopWatch != _stopWatch) { //comparing old one(_stopWatch) to new one(stopWatch) if new one is not same as old one then do below
        
        //removing these below to get rid of observer for previously updated (property)
        [_stopWatch removeObserver:self forKeyPath:@"running" context:KVOContext];
        [_stopWatch removeObserver:self forKeyPath:@"elapsedTime" context:KVOContext];
        
        //willSet
        //old one is assigned to new one since old one (original one) should show new one now since new one has updated contents
        _stopWatch = stopWatch;
        
        //didSet
        //after making old one to have new one's contents you give addObserver so they can get called by a method below
        [_stopWatch addObserver:self forKeyPath:@"running" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_stopWatch addObserver:self forKeyPath:@"elapsedTime" options:NSKeyValueObservingOptionInitial context:KVOContext];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == KVOContext) {
        //do our stuff
        [self updateViews];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
    
}

- (void)dealloc
{
    self.stopWatch = nil;
}

@end
