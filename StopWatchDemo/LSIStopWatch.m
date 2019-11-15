//
//  LSIStopWatch.m
//  StopWatchDemo
//
//  Created by Dongwoo Pae on 11/15/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

#import "LSIStopWatch.h"

@interface LSIStopWatch ()

//we will be using KVC to access and save
@property (nonatomic, readwrite, getter=isRunning) BOOL running;
@property (nonatomic, readwrite) NSTimeInterval elapsedTime; //fractional second

@property (nonatomic) NSDate *startDate;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSTimeInterval previouslyAccumulatedTime;

@end


@implementation LSIStopWatch

-(void)start
{
    
    self.startDate = NSDate.date;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerDidFire:) userInfo:nil repeats:YES];
    
    self.running = YES;
}

-(void)stop
{
    self.previouslyAccumulatedTime = self.elapsedTime;
    [self.timer invalidate];
    self.timer = nil;
    self.startDate = nil;
    self.running = NO;
}

-(void)reset
{
    [self stop];
    
    self.elapsedTime = 0;
    self.previouslyAccumulatedTime = 0;
}

-(void)timerDidFire:(NSTimer *)sender
{
    self.elapsedTime = [NSDate.date timeIntervalSinceDate:self.startDate] + self.previouslyAccumulatedTime;
}

-(void)setTimer:(NSTimer *)timer
{
    if (timer != _timer) {
        [_timer invalidate];
        _timer = timer;
    }
}

@end
