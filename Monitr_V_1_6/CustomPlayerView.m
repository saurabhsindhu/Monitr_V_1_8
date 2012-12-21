//
//  CustomPlayerView.m
//  VideoStreamDemo2
//
//  Created by 刘 大兵 on 12-5-17.
//  Copyright (c) 2012年 中华中等专业学校. All rights reserved.
//

#import "CustomPlayerView.h"

@implementation CustomPlayerView
+(Class)layerClass{
    return [AVPlayerLayer class];
}

-(AVPlayer*)player{
    return [(AVPlayerLayer*)[self layer]player];
}

-(void)setPlayer:(AVPlayer *)thePlayer{
  
    return [(AVPlayerLayer*)[self layer]setPlayer:thePlayer];
}

/* Specifies how the video is displayed within a player layer’s bounds. 
 
 (AVLayerVideoGravityResizeAspect is default) */

- (void)setVideoFillMode:(NSString *)fillMode

{
    
    AVPlayerLayer *playerLayer = (AVPlayerLayer*)[self layer];
    
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
}

-(void)dealloc
{
    [super dealloc];
}

@end
