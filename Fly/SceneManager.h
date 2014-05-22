//
//  SceneManager.h
//  touchPong
//
//  Created by EUNJI KIM on 13. 5. 21..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuLayer.h"
#import "HighScoreLayer.h"
#import "HelloWorldLayer.h"
#import "HowtoLayer.h"
#import "ProducerLayer.h"



@interface SceneManager : NSObject {
    
}

// 각 레이어로 이동하는 정적 메소드임
+(void)goGame;
+(void) goHow;
+(void) goProducer;
+(void) goMenu;


// 레이어간 이동에서 사용되는 트랜지션 효과와 효과에 사용되는 시간
+(void) go:(CCLayer *)layer withTransition:(NSString *)transitionString ofDelay:(float)t;
//+(void) go:(CCLayer *)layer withTransition:(NSString *)transitionString;
//+(void) go:(CCLayer *)layer;

@end
