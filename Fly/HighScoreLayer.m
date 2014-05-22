//
//  HighScoreLayer.m
//  Fly
//
//  Created by EUNJI KIM on 13. 6. 17..
//  Copyright __MyCompanyName__ 2013년. All rights reserved.
//

#import "HighScoreLayer.h"
#import "HighScore.h"
#import "SceneManager.h"

@implementation HighScoreLayer

+ (CCScene*)scene{
  //씬을 만들고 레이어를 자식으로 추가하여 반환
  CCScene *scene = [CCScene node];
  HighScoreLayer *layer = [HighScoreLayer node];
  [scene addChild:layer];
  
  return scene;
  
}

-(void)initBackground {
    CGSize size = [[CCDirector sharedDirector] winSize];
    //배경에 사용할 1번 이미지를 생성 후, 화면에 꽉 차게 이동 시킨다.
    CCSprite *highScoreBackground = [CCSprite spriteWithFile:@"bg_main.gif"];
    highScoreBackground.anchorPoint = ccp(0.5, 0.5);
    highScoreBackground.position = ccp(size.width/2, size.height/2);
    [self addChild:highScoreBackground z:-1];
}

- (id)init {
  self = [super init];
  if (self) {
    [self initBackground];
      //화면에 점수를 보여준다
    [self displayScore];
  }
  return self;
}

- (void)displayScore{
  //점수를 파일로 부터 불러온다.
  HighScore *highscore = [HighScore new];
  [highscore loadHighScores];
  
  NSArray *scoreArray = [highscore scoresArray];
  
  CGFloat startYPosition = 400;
  
  CGSize size = [[CCDirector sharedDirector] winSize];
  
  //배열에서 이름과 점수를 불러서 화면에 표시한다.
  for (NSInteger i = 0; i < [scoreArray count]; i++) {
    NSString *record = [scoreArray objectAtIndex:i];
    
    NSString *name = [highscore nameFromRecord:record];
    NSString *score = [highscore scoreFromRecord:record];
    
    CCLabelBMFont *label = [CCLabelBMFont labelWithString:@"High Score!" fntFile:@"font.fnt"];
    label.position = CGPointMake(size.width / 2, size.height - 50);
    [self addChild:label];
    
    CCLabelBMFont *nameLabel = [CCLabelBMFont labelWithString:name fntFile:@"font.fnt"];
    nameLabel.scale = 0.5;
    nameLabel.anchorPoint = CGPointMake(0, 1); 
    nameLabel.position = CGPointMake(20, startYPosition - 30 * i);
    [self addChild:nameLabel];
    
    CCLabelBMFont *scoreLabel = [CCLabelBMFont labelWithString:score fntFile:@"font.fnt"];
      scoreLabel.scale = 0.5;
    scoreLabel.anchorPoint = CGPointMake(0, 1);
    scoreLabel.position = CGPointMake(250, startYPosition - 30 * i);
    [self addChild:scoreLabel];
    
    //종료 메뉴
      CCMenuItem *item = [CCMenuItemImage itemWithNormalImage:@"btn_back.gif" selectedImage:@"btn_back.gif" target:self selector:@selector(exit)];
    CCMenu *menu = [CCMenu menuWithItems:item, nil];
    [menu alignItemsVertically];
    menu.position = ccp(size.width / 2, 50);
    [self addChild:menu];
  }
}

- (void)exit{
    [SceneManager goMenu];
}

@end
