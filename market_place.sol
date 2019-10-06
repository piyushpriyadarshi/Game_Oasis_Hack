pragma solidity >=0.4.22 <0.7.0;

// import "./oraclizeAPI_0.5.sol";

contract GameOasis{
    address owner;
    uint count;
    
    
    struct Gameinfo
    {
    uint  Pricechoice;
    uint  decidedPrice;
    uint  totalBuyer;
    uint  totalVote;
    uint  choice;
    string url;
    string name;
    //uint ratio;
    }
    
    
    
    uint public startBidTime;
    uint public endBidTime;
    mapping(address=>bool) public voteStatus;
    
   
    

     
    
 constructor() public
    {
        owner=msg.sender;
        //price=_price;
    }
    
    
struct   BidderInfo
{
 address bidder;
 uint idItem;
 uint choice;
// bool bidVot;
}
struct BuyerInfo
{
    address buyer;
    uint choice;
   // bool buyerVot;
}
    mapping(address=>uint) public buyers;
    mapping(address=>uint) public bidders;
   // mapping(uint=>Gameinfo) public games;
    
BidderInfo[] public bii;
BuyerInfo[] public bui;
Gameinfo[] public gi;
function getAllGames(uint j) public view returns(uint,uint,string,string){
   for(uint i=0;i<=count;i++)
   {
       if(i==j){
           return(gi[i].choice,gi[i].Pricechoice,gi[i].name,gi[i].url);
       }
       
   }
}
function setBidingTime() public
{
    require(msg.sender==owner);
    startBidTime=now;
    endBidTime=now+21600;
    
}

function addGame(uint _price,string memory _url,string memory _name) public
{
    count=count+1;
    Gameinfo memory g;
  
         g.Pricechoice=_price;
         g.url=_url;
         g.name=_name;
         g.choice=count;
         g.decidedPrice=0;
         g.totalBuyer=0;
         g.totalVote=0;
         gi.push(g);
         
         
        // games[count]=gi;
    
    
}

function setBuyerInfo(uint _choice) public
{
    require(buyers[msg.sender]==0);
   // require(now>startBidTime && now<=endBidTime);
    bui.push(BuyerInfo({
        buyer:msg.sender,
        choice:_choice
    }));
    
    buyers[msg.sender]=_choice;
    gi[_choice].totalBuyer+=1;
    
}
function setBidderInfo(uint _choice,uint _idItem) public
{
    require(bidders[msg.sender]==0);
     require(now>startBidTime && now<=endBidTime);
    bii.push(BidderInfo({
        bidder:msg.sender,
        choice:_choice,
        idItem:_idItem
    }));
    
    bidders[msg.sender]=_choice;
    //        
}

function Vote(uint _choice) public{
    require((buyers[msg.sender]!=0 || bidders[msg.sender]!=0)&& voteStatus[msg.sender]==false);
    gi[_choice].totalVote+=1;
    voteStatus[msg.sender]=true;
}


function PriceDecider () internal
{
     require(now>startBidTime && now<=endBidTime);
    
    //require(bid axie >= price);
    for(uint i=0;i<=count;i++)
    {
     uint ratio;
     
   ratio=uint((gi[i].totalVote*100)/gi[i].totalBuyer);
    if(ratio>=50){
    gi[i].decidedPrice=(uint)((ratio*gi[i].Pricechoice)/100)+gi[i].Pricechoice;
    }
    else
    {
        gi[i].decidedPrice=gi[i].Pricechoice-(uint)((ratio*gi[i].Pricechoice)/100);
        
    }
   // return decidedPriceC2;
    
    ratio=0;
    }
    
   // return decidedPriceC2;
}

function decideTransfer()public
{
    
    
    
    
}


}