//
//  INNJDateView.m
//  innjiaios
//
//  Created by wl on 14-11-10.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJDateView.h"

@interface INNJDateView () <UITextFieldDelegate>
@end
@implementation INNJDateView
{
    UIGestureRecognizer * _gesture;
    UIGestureRecognizer * _resigngesture;
}
-(void) awakeFromNib
{
    _nametext.background = SCBGIMAGEOFF;
    
    [_datetextbtn setBackgroundImage:SCBGIMAGEOFF forState:UIControlStateNormal];
    [_timetextbtn setBackgroundImage:SCBGIMAGEOFF forState:UIControlStateNormal];
    [_submitbtn setBackgroundImage:SCBGIMAGEON forState:UIControlStateNormal];
    
    PADDINGDEFAULT(_nametext);
    
    //date
  
    _nametext.delegate = self;
    _resigngesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAction:)];
    [self addGestureRecognizer:_resigngesture];
    
    NSArray * sexchoices = @[@"男",@"女"];
    _sex = @"男";
    CGFloat space = 10;
    CGFloat width = (CGRectGetWidth(_sexarea.bounds) -([sexchoices count]-1)*space)/[sexchoices count];
    CGFloat height = CGRectGetHeight(_sexarea.bounds);
    for(int roomi = 0;roomi<[sexchoices count];roomi++)
    {
        UIButton *btn= [[UIButton alloc] initWithFrame:CGRectMake(roomi*(width+space), 0, width, height)];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:sexchoices[roomi] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:SCBGIMAGEOFF forState:UIControlStateNormal];
        [btn setBackgroundImage:SCBGIMAGEON forState:UIControlStateSelected];
        if(0 == roomi)
        {
            btn.selected = YES;
        }
        
        [_sexarea addSubview:btn];
        btn.tag = 1000+roomi;
        [btn addTarget:self action:@selector(sexSelect:) forControlEvents:UIControlEventTouchUpInside];
    }

    
}
-(void) sexSelect:(id)sender
{
    for(int i=0;i<2;i++)
    {
        [(UIButton*)[_sexarea viewWithTag:1000+i] setSelected:NO];
    }
    
    [sender setSelected:YES];
    if(((UIView*)sender).tag ==1000)
        self.sex = @"男";
    else
        self.sex = @"女";
    
    
}
-(void) resignAction:(UIGestureRecognizer*)tap
{
    [_nametext resignFirstResponder];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
