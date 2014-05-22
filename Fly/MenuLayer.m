//
//  MenuLayer.m
//  dragon
//
//  Created by EUNJI KIM on 13. 5. 30..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "MenuLayer.h"
#import "SceneManager.h"
#import "IntroLayer.h"


@implementation MenuLayer

+(CCScene *)scene {

    CCScene *scene = [CCScene node];
    MenuLayer *layer = [MenuLayer node];
    [scene addChild:layer];
    return  scene;
}

-(void)initBackground {
    CGSize size = [[CCDirector sharedDirector] winSize];
    //배경에 사용할 1번 이미지를 생성 후, 화면에 꽉 차게 이동 시킨다.
    CCSprite *menuBackground = [CCSprite spriteWithFile:@"bg_main.gif"];
    menuBackground.anchorPoint = ccp(0.5, 0.5);
    menuBackground.position = ccp(size.width/2, size.height/2);
    [self addChild:menuBackground z:-1];
}


-(id) init
{
    if (self = [super init]) {
        if (self) {
            //다이렉터에서 화면의 크기를 알아본다.
            CGSize size = [[CCDirector sharedDirector] winSize];
            [self initBackground];
            
            //제목으로 만들 레이블을 시스템 폰트를 사용해서 만든다.
            CCSprite *title = [CCSprite spriteWithFile:@"bg_sub.gif"];
            //레이블의 위치를 지정한다.
            title.position = ccp(size.width/2, size.height/2+100);
            //레이블을 자식으로 추가한다.
            [self addChild:title];
            
            //메뉴 아이템
            //Start 메뉴 버튼이 눌렀을 경우, GameScene을 화면 전환과 함께 호출한다.
            CCMenuItem *startItem = [CCMenuItemImage itemWithNormalImage:@"btn_start.gif" selectedImage:@"btn_start_s.gif" target:self selector:@selector(gogame)];
            
            CCMenuItem *howItem = [CCMenuItemImage itemWithNormalImage:@"btn_how.gif" selectedImage:@"btn_how_s.gif" target:self selector:@selector(gohow)];
            
            CCMenuItem *prodItem = [CCMenuItemImage itemWithNormalImage:@"btn_pro.gif" selectedImage:@"btn_pro_s.gif" target:self selector:@selector(goproducer)];
            
            
            
            //메뉴 버튼을 메뉴에 추가한다.
            CCMenu *menu = [CCMenu menuWithItems:startItem, howItem, prodItem, nil];
            //세로 정렬로 각 메뉴의 사잇값으로 20을 준다.
            [menu alignItemsVerticallyWithPadding:20];
            //메뉴의 위치를 지정한다.
            menu.position = ccp(size.width/2, size.height/2 - 50);
            //메뉴를 자식으로 추가한다.
            [self addChild:menu];

        }
    }
    return self;
}

-(void)gogame {
    [SceneManager goGame];
}

-(void)gohow {
    [SceneManager goHow];
}

-(void)goproducer {
    [SceneManager goProducer];
}

@end
