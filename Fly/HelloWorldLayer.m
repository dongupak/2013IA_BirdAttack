//
//  HelloWorldLayer.m
//  Fly
//
//  Created by EUNJI KIM on 13. 6. 17..
//  Copyright __MyCompanyName__ 2013년. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import "HighScore.h"
#import "HighScoreLayer.h"
#import "HighScoreInputViewController.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer
#define WINSIZE [[CCDirector sharedDirector] winSize]

-(id) init
{
	if( (self=[super init]) ) {
        
        sae = [SimpleAudioEngine sharedEngine];
		[sae preloadEffect:@"background_music.mp3"];
		[sae preloadEffect:@"explosion.wav"];
		[sae preloadEffect:@"bullet.wav"];
        
        CCMenuItem *PauseItem = [CCMenuItemImage itemWithNormalImage:@"btn_pause.png" selectedImage:@"btn_pause_s.png" target:self selector:@selector(pauseGame:)];
		CCMenu *menu = [CCMenu menuWithItems:PauseItem,nil];
        menu.position = ccp(WINSIZE.width - 50, 50);
		[self addChild:menu z:8 tag:8];
		Pause = NO;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"monsterSheet.plist"];
        
        bulletArr = [[NSMutableArray alloc] init];
        enemyArr = [[NSMutableArray alloc] init];
        
        player = [Player creatplayer];
        player.position = ccp(WINSIZE.width * .5, WINSIZE.height * .2);
        [self addChild:player z:100];
        
        bg1 = [CCSprite spriteWithFile:@"bg_game2.gif"];
        bg1.position = ccp(WINSIZE.width * .5, 0);
        bg1.anchorPoint = ccp(.5, 0);
        float coef = WINSIZE.height / bg1.contentSize.height;
        bg1.scaleY *= coef;
        [self addChild:bg1 z:-1];
        
        bg2 = [CCSprite spriteWithFile:@"bg_game2.gif"];
        bg2.position = ccp(WINSIZE.width * .5, WINSIZE.height);
        bg2.anchorPoint = ccp(.5, 0);
        bg2.scaleY *= coef;
        [self addChild:bg2 z:-1];
        
        bgSpeed = 1;
        distroyNum = 0;
        distroyNumLable = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",distroyNum] fontName:@"Marker Felt" fontSize:16];
        CCLayerColor *disLayer = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 168) width:60 height:40];
        [self addChild:disLayer z:10];
        disLayer.position = ccp(WINSIZE.width - disLayer.contentSize.width, WINSIZE.height - disLayer.contentSize.height);
        [disLayer addChild:distroyNumLable];
        distroyNumLable.position = ccp(disLayer.contentSize.width * .5, disLayer.contentSize.height * .5);
        distroyNumLable.color = ccBLACK;
        
        [self scheduleUpdate];
        [self schedule:@selector(addEnemy) interval:4];
        [self schedule:@selector(addBullet) interval:0.2];
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        
        [sae playBackgroundMusic:@"background_music.mp3" loop:YES];
	}
	return self;
}

//일시정지
- (void)pauseGame:(id)sender {
	if (Pause == NO) {
		[[CCDirector sharedDirector] stopAnimation];
		Pause = YES;
		self.isTouchEnabled = NO;
	}else {
		[[CCDirector sharedDirector] startAnimation];
		Pause = NO;
		self.isTouchEnabled = YES;
	}
}

#define kMaxMonster 5 
- (void) addEnemy
{
    float width = WINSIZE.width / kMaxMonster;
    for ( int i = 0; i < kMaxMonster ; i++ ) {
        enemy = [Enemy node];
        [self addChild:enemy];
        
        enemy.position = ccp( i * width + width / 2, WINSIZE.height + enemy.boundingBox.size.height / 2);
        [enemy runAction:[CCSequence actions:[CCMoveTo actionWithDuration:2 position:ccp(enemy.position.x, -200)], [CCCallFuncN actionWithTarget:self selector:@selector(outSceneDistroy:)],nil]];
        [enemyArr addObject:enemy];
    }
}

- (void) outSceneDistroy:(id) sender
{
    CCSprite *sprite = (id) sender;
    if (sprite.tag == 1) {
        [enemyArr removeObject:sprite];
        [self removeChild:sprite cleanup:YES];
    } else if (sprite.tag == 2) {
        [bulletArr removeObject:sprite];
        [self removeChild:sprite cleanup:YES];
    }
}

- (void) addBullet
{
    bullet = [Bullet creatBullet];
    bullet.position = ccp(player.position.x, player.position.y + player.contentSize.height / 4);
    [self addChild:bullet z:1];
    [bulletArr addObject:bullet];
    bullet.tag = 2;
    [sae playEffect:@"bullet.wav"];

    bullet.opacity = 0;
    [bullet runAction:[CCFadeTo actionWithDuration:.1 opacity:192]];
    [bullet runAction:[CCSequence actions:[CCMoveTo actionWithDuration:1 position:ccp(bullet.position.x, WINSIZE.height)],[CCCallFuncN actionWithTarget:self selector:@selector(outSceneDistroy:)], nil]];
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}

- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint curTouchLocation = [touch locationInView:[touch view]];
    CGPoint preTouchLocation = [touch previousLocationInView:[touch view]];
    curTouchLocation = [[CCDirector sharedDirector ]convertToGL:curTouchLocation];
    preTouchLocation = [[CCDirector sharedDirector] convertToGL:preTouchLocation];
    CGPoint vector = ccp(curTouchLocation.x - preTouchLocation.x, preTouchLocation.y);
    CGPoint curMovePos = player.position;
    if (curMovePos.x + vector.x - player.contentSize.width * .5 >= 0 && curMovePos.x + vector.x + player.contentSize.width * .5 <= 320){
        [player setPosition:ccp(curMovePos.x + vector.x, curMovePos.y)];
    }
}

- (void) update:(ccTime)delta
{
    CGPoint pos1 = bg1.position;
    pos1.y -= bgSpeed;
    if (pos1.y < -WINSIZE.height) {
        pos1.y += WINSIZE.height * 2;
    }
    bg1.position = pos1;
    CGPoint pos2 = bg2.position;
    pos2.y -= bgSpeed;
    if (pos2.y < -WINSIZE.height) {
        pos2.y += WINSIZE.height * 2;
    }
    bg2.position = pos2;
    
    
    BOOL enemeyDragonHit = FALSE;
    NSMutableArray *bulletToDelete = [[NSMutableArray alloc] init];
    for (Bullet *abullet in bulletArr) {
        CGRect bulletRect = CGRectMake(abullet.position.x - abullet.contentSize.width * .5,
                                       abullet.position.y - abullet.contentSize.height * .5,
                                       abullet.contentSize.width,
                                       abullet.contentSize.height);
        NSMutableArray *enemiesToDelete = [[NSMutableArray alloc] init];
        for (Enemy *aenemyDragon in enemyArr) {
            CGRect enemyDragonRect = CGRectMake(aenemyDragon.position.x - aenemyDragon.contentSize.width * .5,
                                                aenemyDragon.position.y - aenemyDragon.contentSize.height * .5,
                                                aenemyDragon.contentSize.width, aenemyDragon.contentSize.height);
            if (CGRectIntersectsRect(bulletRect, enemyDragonRect)) {
                //                [enemiesToDelete addObject:aenemyDragon];
                enemeyDragonHit = TRUE;
                Enemy *enDragon = (Enemy *)aenemyDragon;
                enDragon.hp--;
                if (enDragon.hp <= 0) {
                    [enemiesToDelete addObject:aenemyDragon];
                }
                [sae playEffect:@"explosion.wav"];

                break;
            }
        }
        
        for (Enemy *aenemyDragon in enemiesToDelete) {
            [enemyArr removeObject:aenemyDragon];
            [self removeChild:aenemyDragon cleanup:YES];
            distroyNum++;
        }
        
        if (enemeyDragonHit) {
            [bulletToDelete addObject:abullet];
        }
        [enemiesToDelete release];
    }
    for (Bullet *abullet in bulletToDelete){
        [bulletArr removeObject:abullet];
        [self removeChild:abullet cleanup:YES];
    }
    [bulletToDelete release];
    
    NSMutableArray *enemiesToDelete = [[NSMutableArray alloc] init];
    for (Enemy *aenemyDragon in enemyArr) {
        CGRect enemyDragonRect = CGRectMake(aenemyDragon.position.x - aenemyDragon.contentSize.width * .5,
                                            aenemyDragon.position.y - aenemyDragon.contentSize.height * .5,
                                            aenemyDragon.contentSize.width,
                                            aenemyDragon.contentSize.height);
        CGRect playerRect = CGRectMake(player.position.x - player.contentSize.width * .5,
                                             player.position.y - player.contentSize.height * .5,
                                             player.contentSize.width,
                                             player.contentSize.height);
        if (CGRectIntersectsRect(playerRect, enemyDragonRect)) {
            [enemiesToDelete addObject:aenemyDragon];
        }
    }
    for (Enemy *aenemyDragon in enemiesToDelete) {
        [enemyArr removeObject:aenemyDragon];
        [self removeChild:aenemyDragon cleanup:YES];
        CCCallBlock *allStop = [CCCallBlock actionWithBlock:^{
            [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
            [sae stopBackgroundMusic];
        }];

        CCDelayTime *delay = [CCDelayTime actionWithDuration:2.0f];
        CCCallBlock *block = [CCCallBlock actionWithBlock:^{
            HighScore *highScore = [HighScore new];
            if ([highScore isHighScore:distroyNum - 1] == YES) {
                
                //입력값을 받을 수 있는 뷰 콘트롤러 생성
                HighScoreInputViewController *viewController = [HighScoreInputViewController new];
                viewController.gamePoint = distroyNum - 1;
                AppController *app = (AppController *)[[UIApplication sharedApplication] delegate];
                //현재 네비게이션 콘트롤러에 푸쉬로 뷰 콘트롤러를 호출한다.
                [app.navController pushViewController:viewController animated:YES];
            }else{
                //점수 레이어로 돌아간다.
                [[CCDirector sharedDirector] replaceScene:[HighScoreLayer scene]];
            }
        }];
        //엑션을 순서대로 준비.
        CCSequence *seq = [CCSequence actions:allStop, delay, block, nil];
        //엑션 실행
        [self runAction:seq];
    }
    [enemiesToDelete release];
    [distroyNumLable setString:[NSString stringWithFormat:@"%d", distroyNum]];
}



- (void) dealloc
{
    [bulletArr release];
    bulletArr = nil;
    [enemyArr release];
    enemyArr = nil;
	[super dealloc];
}

@end
