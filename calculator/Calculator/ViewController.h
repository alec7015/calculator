//
//  ViewController.h
//  Calculator
//
//  Created by srdz on 15/11/2.
//  Copyright © 2015年 srdz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) UILabel *label1,*label2;
@property(retain,nonatomic)NSMutableString *string,*string1;
@property(assign,nonatomic)double num1,num2,num3;
@property(nonatomic,strong)NSString *sign;
@property(nonatomic,strong)UIWindow *window;
@property(nonatomic,strong)UISwitch *switchView;
@property (nonatomic,strong) IBOutlet UIView *numberButtonView;


@end

