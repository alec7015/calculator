//
//  ViewController.m
//  Calculator
//
//  Created by srdz on 15/11/2.
//  Copyright © 2015年 srdz. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#define buttonMargin 10

@interface ViewController ()
//@property (nonatomic, strong) NSArray *buttonList;
@end

@implementation ViewController

-(void)sounds
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //1.获得音效文件的全路径
    NSURL *url=[[NSBundle mainBundle]URLForResource:@"tap.aif" withExtension:nil];
    
    //2.加载音效文件，创建音效ID（SoundID,一个ID对应一个音效文件）
    SystemSoundID soundID=0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    
    //把需要销毁的音效文件的ID传递给它既可销毁
    //AudioServicesDisposeSystemSoundID(soundID);
    
    //3.播放音效文件
    //下面的两个函数都可以用来播放音效文件，第一个函数伴随有震动效果
    AudioServicesPlayAlertSound(soundID);
    //AudioServicesPlaySystemSound(<#SystemSoundID inSystemSoundID#>)
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor blackColor];

    UIView *numberButtonView =[[UIView alloc]initWithFrame:CGRectMake(0.0,200.0,self.view.frame.size.width,self.view.frame.size.height-200)];
    numberButtonView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:numberButtonView];
    
    //创建标签，答案区
    [self creatlabel];
    //功能转换键
    [self creatsegment];
    //数字键
    [self createButtons];
   }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIView *)numberButtonView
{
    if (_numberButtonView == nil) {
        _numberButtonView = [[UIView alloc] initWithFrame:self.view.bounds];
 
        
        [self.view addSubview:_numberButtonView];
    }
    return _numberButtonView;
}

//创建显示区
-(void)creatlabel
{
    //创建标签
    self.label1=[[UILabel alloc]initWithFrame:CGRectMake(10, 110, self.view.frame.size.width-20, 80)];
    [self.label1.layer setMasksToBounds:YES];
    //设置矩形四个圆角半径
    [self.label1.layer setCornerRadius:10.0];
    self.label1.backgroundColor=[UIColor grayColor];
    self.label1.textColor=[UIColor  orangeColor];//字体颜色
    self.label1.textAlignment=NSTextAlignmentRight;//字体居右
    self.label1.font=[UIFont systemFontOfSize:60.0];
    self.label1.text=@"0";
    [self.view addSubview:_label1];
    
     self.label2=[[UILabel alloc]initWithFrame:CGRectMake(10, 70, self.view.frame.size.width-20, 55)];
    [self.label2.layer setMasksToBounds:YES];
    //设置矩形四个圆角半径
    [self.label2.layer setCornerRadius:10.0];
    self.label2.backgroundColor=[UIColor grayColor];
    self.label2.textColor=[UIColor  orangeColor];//字体颜色
    self.label2.textAlignment=NSTextAlignmentRight;//字体居右
    self.label2.font=[UIFont systemFontOfSize:35.0];
    [self.view addSubview:_label2];

}

//功能转换键segmentedcontrol
-(void)creatsegment
{
    NSArray *array=@[@"标准",@"科学"];
    UISegmentedControl *segmentControl=[[UISegmentedControl alloc]initWithItems:array];
    segmentControl.frame=CGRectMake(10, 25, 100, 40);
    //默认选择
    segmentControl.selectedSegmentIndex=0;
    //设置背景色
    segmentControl.tintColor=[UIColor grayColor];
    //设置监听事件
    //[segmentControl addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentControl];
    
}



- (void)createButtons
{       //数字区宽度 及按钮宽度
      CGFloat numberButtonW=self.numberButtonView.bounds.size.width;
      CGFloat buttonWidth=(numberButtonW -5*10)*0.25;

    //添加键盘前三排
    NSArray *array=[NSArray arrayWithObjects:@"C",@"7",@"4",@"1",@"DEL",@"8",@"5",@"2",@"÷",@"9",@"6",@"3",@"x",@"-",@"+",nil];
    
    int n=0;
    for (int i=0; i<4 ; i++)
    {
        for (int j=0; j<4 && n<15; j++)
        {
           UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            
            [btn.layer setMasksToBounds:YES];
            //设置矩形四个圆角半径
            [btn.layer setCornerRadius:10.0];

           CGFloat x =(i+1) *buttonMargin+i*buttonWidth;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
           CGFloat y=(j+1) *buttonMargin + j*buttonWidth + 200;
           btn.frame=CGRectMake(x, y, buttonWidth, buttonWidth);
           
           
           [btn setTitle:array[n++] forState:UIControlStateNormal];
           [self.view addSubview:btn];
            
            //字体大小颜色
           btn.titleLabel.font = [UIFont systemFontOfSize:40.0f];
           [btn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
           
            if ((n-1)<15) {
            if ([array[n-1] isEqualToString: @"DEL"]) {
                btn.backgroundColor =[UIColor grayColor];
                [btn addTarget:self action:@selector(dele:) forControlEvents:UIControlEventTouchUpInside];
            }else if([array[n-1] isEqualToString: @"C" ]){
                btn.backgroundColor =[UIColor orangeColor];
                 [btn addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
            }else if( [array[n-1] isEqualToString: @"÷"] || [array[n-1] isEqualToString: @"x"] || [array[n-1] isEqualToString: @"-"] || [array[n-1] isEqualToString: @"+"] ){
                btn.backgroundColor =[UIColor grayColor];
                [btn addTarget:self action:@selector(calcular:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                btn.backgroundColor =[UIColor lightGrayColor];
                [btn addTarget:self action:@selector(number:) forControlEvents:UIControlEventTouchUpInside];
            }
          }
        }
    }
    
    
    //添加 =
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn1.frame=CGRectMake(4*buttonMargin+3*buttonWidth,4*buttonMargin + 3*buttonWidth + 200, buttonWidth, 2*buttonWidth+buttonMargin);
    [btn1.layer setMasksToBounds:YES];
    //设置矩形四个圆角半径
    [btn1.layer setCornerRadius:10.0];
    btn1.backgroundColor =[UIColor orangeColor];
    [btn1 setTitle:@"=" forState:UIControlStateNormal];
     [self.view addSubview:btn1];
    [self.view addSubview:btn1];
    btn1.titleLabel.font = [UIFont systemFontOfSize:40.0f];
    [btn1 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(result) forControlEvents:UIControlEventTouchUpInside];
    
    //添加 0
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.frame=CGRectMake(buttonMargin,5*buttonMargin + 4*buttonWidth + 200, 2*buttonWidth+buttonMargin, buttonWidth);
    [btn2.layer setMasksToBounds:YES];
    //设置矩形四个圆角半径
    [btn2.layer setCornerRadius:10.0];
    btn2.backgroundColor =[UIColor lightGrayColor];
    [btn2 setTitle:@"0" forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    btn2.titleLabel.font = [UIFont systemFontOfSize:40.0f];
    [btn2 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(zero) forControlEvents:UIControlEventTouchUpInside];
    
    //添加 .
    UIButton *btn3=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn3.frame=CGRectMake(3*buttonMargin+2*buttonWidth,5*buttonMargin + 4*buttonWidth + 200, buttonWidth, buttonWidth);
    [btn3.layer setMasksToBounds:YES];
    //设置矩形四个圆角半径
    [btn3.layer setCornerRadius:10.0];
    btn3.backgroundColor =[UIColor lightGrayColor];
    [btn3 setTitle:@"." forState:UIControlStateNormal];
    [self.view addSubview:btn3];
    btn3.titleLabel.font = [UIFont systemFontOfSize:40.0f];
    [btn3 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(point) forControlEvents:UIControlEventTouchUpInside];
    
    //初始化可变字符串，分配内存
    self.string=[[NSMutableString alloc]init];
    self.string1=[[NSMutableString alloc]init];
    //存放符号
    self.sign = [[NSString alloc]init];
    

 }



//清屏
-(void) clear
{
    [self sounds];
    [self.string setString:@""];//清空字符串
    [self.string1 setString:@""];
    _num1=0;
    _num2=0;
    _num3=0;
    self.label1.text=@"0";
    self.label2.text=@"";

}

//删除键
-(void)dele:(UIButton *)sender
{
    [self sounds];
    if([self.string isEqualToString:@""]==YES)
    {
        [self clear];
    }
    
    if ([self.label1.text isEqualToString:@""]==NO)//判断不是空
    {
        if(self.label1.text.length == 1){
            //只有一个字符，删去后显示为0
            [self clear];
       }else{
           [self.string deleteCharactersInRange:NSMakeRange([self.string length]-1,1)];//删除最后一个字符
           [self.string1 deleteCharactersInRange:NSMakeRange([self.string1 length]-1,1)];
           self.label1.text=[NSString stringWithString:_string];//显示结果
           self.num1=[self.label1.text doubleValue];
        }
    }else{
        return;
    }
    
}

//数字1-9
-(void)number:(UIButton *)sender
{
    [self sounds];
    [self.string appendString:[sender currentTitle]];//数字连续输入
    [self.string1 appendString:[sender currentTitle]];
    self.label1.text=[NSString stringWithString:_string];//显示数值
    self.num1=[self.label1.text doubleValue];//保存输入的数值
}

//运算符号的传入
-(void)calcular:(UIButton *)sender
{
    [self sounds];
   //保存前一个运算参数
    self.num2 =_num1;
    //清空
    [self.string setString:@""];
    //存放运算符号
    self.sign=[sender currentTitle];
    [self.string1 appendString:[sender currentTitle]];
}

//小数点
-(void)point
{
    [self sounds];
    NSRange range=[self.string rangeOfString:@"."];
    //是不是第一次就按了小数点
    if(self.string.length == 0)
    {
        //内存中字符串里保存0
        [self.string setString:@"0."];
        [self.string1 appendString:@"0."];
        //标签显示
        self.label1.text =_string;
    }else if (range.location == NSNotFound){
        //且当前数字中没有小数点
        [self.string appendString:@"."];
        [self.string1 appendString:@"."];
        self.label1.text =_string;
    }
}

//数字0
-(void)zero
{
    [self sounds];
    if (self.string.length==0) {
      //   [self.string1 appendString:@"0"];   注释掉解决除以0.小数 后，label2显示00.的结果
        self.num1=0;
        
    }else{
        ////判断是否已经有小数点
        NSRange range=[self.string rangeOfString:@"."];
        if (range.location == NSNotFound) {
            //没有小数点
            //把数字放到字符串的尾部 连接字符串
            [self.string appendString:@"0"];
            [self.string1 appendString:@"0"];
        }else{
            //有小数点
            [self.string appendString:@"0"];
            [self.string1 appendString:@"0"];
        }
        
        self.label1.text =_string;
    }
    

}
//计算结果
-(void)result
{
    [self sounds];
    self.label2.text = _string1;
    if ([self.sign isEqualToString: @"+"]==YES) {
        _num3=_num2+_num1;
        self.label1.text=[NSString stringWithFormat:@"%g",self.num3];//显示结果
    }else if([self.sign isEqualToString: @"-"]==YES){
        _num3=_num2-_num1;
        self.label1.text=[NSString stringWithFormat:@"%g",self.num3];//显示结果
    }else if([self.sign isEqualToString: @"x"]==YES){
       _num3=_num2*_num1;
       self.label1.text=[NSString stringWithFormat:@"%g",self.num3];//显示结果
    }else if([self.sign isEqualToString: @"÷"]==YES){
        
        if( _num1 == 0){
         self.label1.text = @"0不能为除数";
            
        }else{
             _num3=_num2/_num1;
            self.label1.text=[NSString stringWithFormat:@"%g",self.num3];//显示结果
        }
    }
    //保存结果
    self.num1=[self.label1.text doubleValue];
    
    [self.string1 setString:@""];
    [self.string1 appendString:self.label1.text];
    
    //清空
    [self.string setString:@""];
    
}




@end
