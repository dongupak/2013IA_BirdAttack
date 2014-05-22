//
//  Enemy.h
//  Fly
//
//  Created by EUNJI KIM on 13. 6. 17..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef  enum {
    kRed = 0,
    kWhite
} EnemyType;


@interface Enemy : CCSprite {
    
}
@property (nonatomic, assign) int hp;
@property (nonatomic) EnemyType enemyType;

@end
