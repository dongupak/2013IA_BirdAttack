//
//  HelloWorldLayer.h
//  Fly
//
//  Created by EUNJI KIM on 13. 6. 17..
//  Copyright __MyCompanyName__ 2013년. All rights reserved.
//


#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "Enemy.h"
#import "Player.h"
#import "Bullet.h"
#import "SimpleAudioEngine.h"
// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    Enemy *enemy;
    Player *player;
    Bullet *bullet;
    float bgSpeed;
    CCSprite *bg1;
    CCSprite *bg2;
    NSMutableArray *bulletArr;
    NSMutableArray *enemyArr;
    int distroyNum;
    CCLabelTTF *distroyNumLable;
    SimpleAudioEngine *sae;
    BOOL Pause;
    
}



@end

