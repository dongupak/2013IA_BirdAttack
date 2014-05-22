//
//  Bullet.m
//  Fly
//
//  Created by EUNJI KIM on 13. 6. 17..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "Bullet.h"


@implementation Bullet

- (id) init
{
    if (self = [super init]) {
        
    }
    return self;
}

+ (Bullet *)creatBullet
{
    Bullet *bullet = [CCSprite spriteWithFile:@"bullet.png"];
    return bullet;
}

@end
