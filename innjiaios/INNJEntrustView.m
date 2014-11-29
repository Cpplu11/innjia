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
@property (nonatomic,strong) NSArray * roomnumtexts;
@property (nonatomic,strong) NSArray *sexchoices;
@end

@implementation INNJEntrustView

- (void)awakeFromNib
{
    // Initialization code
    _sexenable = _roomsenable = YES;
    _nametext.background = _teltext.background = _addresstext.background = _mintext.background = _maxtext.background = _requirementstext.background =  _citytext.background =  SCBGIMAGEOFF;
    [_datebtn setBackgroundImage:SCBGIMAGEOFF forState:UIControlStateNormal];
   
    PADDINGDEFAULT(_nametext);
    PADDINGDEFAULT(_teltext);
    PADDINGDEFAULT(_addresstext);
    PADDINGDEFAULT(_citytext);
    PADDINGDEFAULT(_mintext);
    PADDINGDEFAULT(_maxtext);
    PADDINGDEFAULT(_requirementstext);
    
    [_submitbutton setBackgroundImage:SCBGIMAGEON forState:UIControlStateNormal];
    [_submitbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //性别选择
    _sexchoices = @[@"女士",@"先生"];
    _sex = _sexchoices[0];
    CGFloat space = 30;
    CGFloat width = (CGRectGetWidth(_sexarea.bounds) -([_sexchoices count]-1)*space)/[_sexchoices count];
    CGFloat height = CGRectGetHeight(_sexarea.bounds);
    for(int roomi = 0;roomi<[_sexchoices count];roomi++)
    {
        UIButton *btn= [[UIButton alloc] initWithFrame:CGRectMake(roomi*(width+space), 0, width, height)];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:_sexchoices[roomi] forState:UIControlStateNormal];
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

    //户型选择
    _roomnumtexts = @[@"一室",@"二室",@"三室",@"四室",@"五室",@"六室"];
    _rooms = @"1";
    _shi = @"一室";
    space = 4;
    width = (CGRectGetWidth(_roomtextarea.bounds) -([_roomnumtexts count]-1)*space)/[_roomnumtexts count];
    height = CGRectGetHeight(_roomtextarea.bounds);
    for(int roomi = 0;roomi<[_roomnumtexts count];roomi++)
    {
        UIButton *btn= [[UIButton alloc] initWithFrame:CGRectMake(roomi*(width+space), 0, width, height)];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitle:_roomnumtexts[roomi] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:SCBGIMAGEOFF forState:UIControlStateNormal];
        [btn setBackgroundImage:SCBGIMAGEON forState:UIControlStateSelected];
        if(0 == roomi)
        {
            btn.selected = YES;
        }
        
        [_roomtextarea addSubview:btn];
        btn.tag = 2000+roomi;
        [btn addTarget:self action:@selector(roomSelect:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAction:)];
    [self addGestureRecognizer:_tap];
}

-(void) bindData:(NSDictionary *)data editable:(BOOL)edit
{
    _nametext.text = data[@"realname"];
    _nametext.enabled = edit;
    
    _teltext.text = data[@"tel"];
    _teltext.enabled = edit;
    
    _addresstext.text = data[@"village"];
    _addresstext.enabled = edit;
    
    _citytext.text = data[@"city"];
    _citytext.enabled = edit;
    
    NSArray *rents = [data[@"rent"] componentsSeparatedByString:@","];
    _mintext.text = rents[0];
    _mintext.enabled = edit;
    _maxtext.text = rents[1];
    _maxtext.enabled = edit;
    
    _requirementstext.text = data[@"memo"];
    _requirementstext.enabled = edit;
    
    [_datebtn setTitle:data[@"checkintime"] forState:UIControlStateNormal];
    _datebtn.enabled = edit;
    
    
    //sex
    NSInteger sexi = [_sexchoices indexOfObject:data[@"sex"]];
    [self sexSelect:[_sexarea.subviews objectAtIndex:sexi]];
    _sexenable = edit;
    
    //rooms
    NSInteger roomi = [data[@"shi"] integerValue]-1;
    [self roomSelect:[_roomtextarea.subviews objectAtIndex:roomi]];
    _roomsenable = edit;
    
    if(edit == false)
    {
        [_submitbutton removeFromSuperview];
    }
}
-(void) resignAction:(UIGestureRecognizer*)tap
{
    [_nametext resignFirstResponder];
    [_teltext resignFirstResponder];
    [_addresstext resignFirstResponder];
    [_mintext resignFirstResponder];
    [_maxtext resignFirstResponder];
    [_requirementstext resignFirstResponder];
    [_citytext resignFirstResponder];
    if(self.superview!=nil && [[self superview] isKindOfClass:[UIScrollView class]])
    {
        UIScrollView *scrollview = (UIScrollView *)[self superview];
        [UIView animateWithDuration:1.0 animations:^{
            scrollview.contentInset = UIEdgeInsetsMake(0, 0,0,0);
        }];
    }
}
-(void) sexSelect:(id)sender
{
    if(!_sexenable)
        return;
    
    for(int i=0;i<2;i++)
    {
        [(UIButton*)[_sexarea viewWithTag:1000+i] setSelected:NO];
    }
    
    [sender setSelected:YES];
    self.sex = _sexchoices[((UIView*)sender).tag - 1000];
    
    
}
-(void) roomSelect:(id) sender
{
    if(!_roomsenable)
        return;
    for(int i=0;i<[_roomnumtexts count];i++)
    {
        [(UIButton*)[_roomtextarea viewWithTag:2000+i] setSelected:NO];
    }
    
    [sender setSelected:YES];
    self.rooms = [NSString stringWithFormat:@"%d",1+((UIView*)sender).tag - 2000];
    self.shi = _roomnumtexts[((UIView*)sender).tag - 2000];
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
