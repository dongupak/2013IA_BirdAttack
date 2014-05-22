//
//  SceneManager.m
//  touchPong
//
//  Created by EUNJI KIM on 13. 5. 21..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "SceneManager.h"

// Scene간 Transtion에 경과되는 디폴트 시간
#define TRANSITION_DURATION (1.0f)

@interface FadeWhiteTransition : CCTransitionFade
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s;
@end

@interface FadeBlackTransition : CCTransitionFade
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s;
@end

@implementation FadeWhiteTransition
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s {
	return [self transitionWithDuration:t scene:s withColor:ccWHITE];
}
@end

@implementation FadeBlackTransition
+(id) transitionWithDuration:(ccTime) t scene:(CCScene*)s {
	return [self transitionWithDuration:t scene:s withColor:ccBLACK];
}
@end


@implementation SceneManager

+(void) goGame{
    CCLayer *layer = [HelloWorldLayer node];
    [SceneManager go:layer withTransition:@"FadeWhiteTransition" ofDelay:.2f];
}

+(void) goHow{
    CCLayer *layer = [HowtoLayer node];
    [SceneManager go:layer withTransition:@"FadeWhiteTransition" ofDelay:.2f];
}

+(void) goProducer{
    CCLayer *layer = [ProducerLayer node];
    [SceneManager go:layer withTransition:@"FadeWhiteTransition" ofDelay:.2f];
}

+(void) goMenu{
    CCLayer *layer = [MenuLayer node];
    [SceneManager go:layer withTransition:@"FadeWhiteTransition" ofDelay:.2f];
}


+(void) go:(CCLayer *)layer withTransition:(NSString *)transitionString ofDelay:(float)t{
    CCDirector *director = [CCDirector sharedDirector];
	CCScene *newScene = [SceneManager wrap:layer];
    
	Class transition = NSClassFromString(transitionString);
	
	// 이미 실행중인 Scene이 있을 경우 replaceScene을 호출
	if ([director runningScene]) {
		[director replaceScene:[transition transitionWithDuration:t
															scene:newScene]];
	} // 최초의 Scene은 runWithScene으로 구동시킴
	else {
		[director runWithScene:newScene];
	}
}

+(CCScene *) wrap:(CCLayer *)layer{
	CCScene *newScene = [CCScene node];
	[newScene addChild: layer];
	return newScene;
}


@end
