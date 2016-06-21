//
//  ListTableViewCell.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/17.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "ListTableViewCell.h"
#import "repairTableModel.h"

@implementation ListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat CellWidth= self.contentView.frame.size.width-4;
        
        _titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(30,0,CellWidth-30,35)];
        _titleLbl.font=[UIFont systemFontOfSize:13];
        [_titleLbl setLineBreakMode:NSLineBreakByWordWrapping];
        [_titleLbl setNumberOfLines:0];
        [self addSubview:_titleLbl];
        
        _titleImage=[[UIImageView alloc]initWithFrame:CGRectMake(8,10,15,15)];
        //_titleImage.backgroundColor=[UIColor blueColor];
        [self addSubview:_titleImage];
        //_titleImage
        //_titleImage.image=[UIImage imageNamed:@"nshoul"];
        
    }
    return self;
}

-(void)showUiNewsCell:(repairTableModel*)NModel{
    
    _titleLbl.text=NModel.title;
    _titleImage.image=[UIImage imageNamed:NModel.imageurl];
    _cellId=NModel.cellId;
}
@end
