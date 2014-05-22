//
//  HowtoLayer.m
//  touchPong
//
//  Created by EUNJI KIM on 13. 5. 21..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "HowtoLayer.h"
#import "SceneManager.h"


@implementation HowtoLayer

-(void)initBackground {
    CGSize size = [[CCDirector sharedDirector] winSize];
    //배경에 사용할 1번 이미지를 생성 후, 화면에 꽉 차게 이동 시킨다.
    CCSprite *howBackground = [CCSprite spriteWithFile:@"bg_how.gif"];
    howBackground.anchorPoint = ccp(0.5, 0.5);
    howBackground.position = ccp(size.width/2, size.height/2);
    [self addChild:howBackground];
}

- (id) init {
	if( (self=[super init]) ) {
        self.isTouchEnabled = YES;
        [self initBackground];
        
    }
    return self;
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Touches Main View");
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Go Menu");
    [SceneManager goMenu];
}


@end
