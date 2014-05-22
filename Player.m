//
//  Player.m
//  Fly
//
//  Created by EUNJI KIM on 13. 6. 17..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "Player.h"


@implementation Player

- (id) init
{
    if (self = [super init]) {
        
    }
    return self;
}

+ (Player *)creatplayer
{
    Player *player = nil;
    player = [CCSprite spriteWithFile:@"player.png"];
    player.anchorPoint = ccp(0.5, 0.5);
    player.position = ccp(0, 0);
    return player;
}


@end
