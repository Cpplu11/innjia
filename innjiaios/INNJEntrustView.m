//
//  INNJEntrustView.m
//  innjiaios
//
//  Created by wl on 14-11-10.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJEntrustView.h"

@interface INNJEntrustView ()
@property (nonatomic,strong) UIGestureRecognizer *tap;
@end

@implementation INNJEntrustView

- (void)awakeFromNib
{
    // Initialization code
   
    _nametext.background = _teltext.background = _addresstext.background = _mintext.background = _maxtext.background = _datetext.background = _requirementstext.background = SCBGIMAGEOFF;
    
   
    PADDINGDEFAULT(_nametext);
    PADDINGDEFAULT(_teltext);
    PADDINGDEFAULT(_addresstext);
    PADDINGDEFAULT(_mintext);
    PADDINGDEFAULT(_maxtext);
    PADDINGDEFAULT(_requirementstext);
    
    [_submitbutton setBackgroundImage:SCBGIMAGEON forState:UIControlStateNormal];
    [_submitbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  
    NSArray *roomnumtexts = @[@"一室",@"二室",@"三室",@"四室"];
    CGFloat space = 10;
    CGFloat width = (CGRectGetWidth(_roomtextarea.bounds) -([roomnumtexts count]-1)*space)/[roomnumtexts count];
    CGFloat height = CGRectGetHeight(_roomtextarea.bounds);
    for(int roomi = 0;roomi<[roomnumtexts count];roomi++)
    {
        UIButton *btn= [[UIButton alloc] initWithFrame:CGRectMake(roomi*(width+space), 0, width, height)];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:roomnumtexts[roomi] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:SCBGIMAGEOFF forState:UIControlStateNormal];
        [btn setBackgroundImage:SCBGIMAGEON forState:UIControlStateSelected];
        if(0 == roomi)
        {
            btn.selected = YES;
        }
        
        [_roomtextarea addSubview:btn];
        btn.tag = 1000+roomi;
        [btn addTarget:self action:@selector(roomSelect:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAction:)];
    [self addGestureRecognizer:_tap];
}

-(void) resignAction:(UIGestureRecognizer*)tap
{
    [_nametext resignFirstResponder];
    [_teltext resignFirstResponder];
    [_addresstext resignFirstResponder];
    [_mintext resignFirstResponder];
    [_maxtext resignFirstResponder];
    [_requirementstext resignFirstResponder];
}
-(void) roomSelect:(id) sender
{
    
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
