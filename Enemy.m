//
//  Enemy.m
//  Fly
//
//  Created by EUNJI KIM on 13. 6. 17..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"


@implementation Enemy

@synthesize hp;

-(void)onEnter{
    [super onEnter];
    //스케쥴러 호출
    [self schedule:@selector(update:)];
}

- (id)init
{
    if (self = [super init]) {
        
        Enemy *enemy = [CCSprite spriteWithFile:@"bird1.gif"];
        [self addChild:enemy];
        
    }
    return self;
}

-(void)update:(ccTime)dt {
    //적의 움직임 가속도 값
    CGPoint enemyScrollVel = ccp(0, -250);
    //현재 적의 위치 값
    CGPoint enemyPos = [self position];
    //화면 아래로 벗어나는지 체크
    if (enemyPos.y + self.boundingBox.size.height / 2 <= 0) {
        //벗어나면 리셋 한다.
//        [self reset];
        //아닐 경우
    } else{
        //움직이게 위치값을 아래로 이동
        enemyPos = ccpAdd(ccpMult(enemyScrollVel, dt), enemyPos);
        //위치 시킨다.
        [self setPosition:enemyPos];
    }
}

#define kMaxEnemyType 2

//-(void)reset{
//    CGSize winSize = [[CCDirector sharedDirector] winSize];
//    //적의 위치를 화면 상단으로 부터 시작한다.
//    self.position = ccp( self.position.x, winSize.height + self.boundingBox.size.height / 2 - 1 );
//    //적의 이미지를 바꿔주기 위해 랜덤 값 생성
//    int random = ( (float)arc4random() / (float)0xffffffff ) * kMaxEnemyType;
//    
//    switch (random) {
//        case kWhite:
//            //적의 타입설정
//            _enemyType = kWhite;
//            //이미지 변경을위해 프레임에 파일이름으로 스프라이트 프레임 케쉬로 부터 찾아서 할당
//            [self set setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"Monster1_00.png"]];
//            break;
//        case kRed:
//            //적의 타입설정
//            _enemyType = kRed;
//            //프레임에 파일이름으로 스프라이트 프레임 케쉬로 부터 찾아서 할당
//            [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"Monster2_00.png"]];
//            break;
//        default:
//            break;
//    }
//    
//}
@end
