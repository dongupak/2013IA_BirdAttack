//
//  HighScoreInputViewController.h
//  Fly
//
//  Created by EUNJI KIM on 13. 6. 17..
//  Copyright __MyCompanyName__ 2013년. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighScoreInputViewController : UIViewController <UITextFieldDelegate>

//게임 점수를 받는다.
@property NSInteger gamePoint;
//사용자 이름 입력을 받는다.
@property (nonatomic, strong) UITextField *userName;

@end
