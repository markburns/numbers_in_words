require './spec/spec_helper'

describe NumbersInWords::NumberGroup do
  it "should split into group of three digit numbers" do
    g = Numeric::NumberGroup

    g.groups_of(1                   ,3 ).should == {0=>1                                          }
    g.groups_of(12                  ,3 ).should == {0=>12                                         }
    g.groups_of(123                 ,3 ).should == {0=>123                                        }
    g.groups_of(1111                ,3 ).should == {3=>1    , 0=>111                              }
    g.groups_of(87654               ,3 ).should == {3=>87   , 0=>654                              }
    g.groups_of(1_234_567           ,3 ).should == {6=>1    , 3=>234  , 0=>567                    }
    g.groups_of(123_456_789_101_112 ,3 ).should == {12=>123 , 9=>456  , 6=>789  , 3=>101 , 0=>112 }
  end
end


