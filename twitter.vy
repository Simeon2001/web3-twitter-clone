# @version >=0.2

owner: public(address)
counter: public(uint256)

struct tweet:
    tweeter: address
    id: uint256
    tweetTxt: String[200]
    tweetImg: String[100]

event tweetcreated:
    tweeter: address
    id: uint256
    tweetTxt: String[200]
    tweetImg: String[100]

tweets: HashMap[uint256,tweet]

@external
def __init__():
    self.owner = msg.sender
    self.counter = 0

@external
@payable
def addTweet(tweetTxt: String[200], tweetImg: String[100]):
    #n: uint256 = 0.1
    assert msg.value == as_wei_value(1,"ether"), "you need 1 bnb"
    self.tweets[self.counter] = tweet({tweeter: msg.sender,id: self.counter,tweetTxt: tweetTxt,tweetImg: tweetImg})
    log tweetcreated(msg.sender,self.counter,tweetTxt,tweetImg)
    self.counter += 1
    send(self.owner, msg.value)

@view
@external
def getTweet(id: uint256) -> tweet:
    assert id < self.counter, "No such tweet"
    return self.tweets[id]