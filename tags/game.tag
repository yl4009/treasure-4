<game>
<div class="container" hide={this.gameState||this.state==="join"}>
   <div hide={this.state==="newGame"||this.state==="join"}>
        <p> Do you want to start a new game to play with a bot or your friend?</p>
        <button type="button" class="btn btn-primary" name="button" onclick={newGame}>New game</button>

        <p> If your friend has already invited you and given you the room number, please click Join button</p>
        <button type="button" class="btn btn-primary" name="button" onclick={join}>Join</button>
        <button type="button" name="button"  class="btn btn-primary" onclick={resume}>resume previous game</button>
        <play if={this.gameState==="autoplay"}></play>
   </div>
    <div class="row" if={this.state==="newGame"} hide={this.gameState==="autoplay"}
        <p> choose game type</p>
        <select class="custom-select" name="" onchange={updateNewGameType}>
            <option value="">---</option>
            <option value="autoplay">Play with Bot</option>
            <option value="invite">Invite a friend</option>
        </select>
    </div>
</div>
</div>
<div if={this.gameState==="invite"}>
    <p>Get ready to play with your frinds?</p>
    <button type="button" name="button" class="btn btn-primary" onclick={startGameFriend}>Start game</button>
</div>

<div class="">
<play if={this.gameState==="autoplay"}||{this.gameState==="readyWithFriends"} hide={!this.gameState}></play>
</div>

<joinFriend if={this.state==="join"}></joinFriend>




<script>
this.state=""
this.userInfo=[{
    myName:this.parent.userName
}]
this.userName=this.parent.userName
console.log('game this', this)
observer.on('userId',(userId)=>{
    this.userId=userId;
    this.userInfo.push({
        myId:userId
    });
     console.log('infooo',this.userInfo)
     });

observer.trigger('userInfo', this.userInfo)

newGame(){
    this.state="newGame";
    console.log('this',this)
       fetch('http://treasure.chrisproctor.net/players/'+ this.userId +'/games/new').then(response => {
            return response.json();
        }).then(data => {
            this.gameId=data.gid
            // Work with JSON data here
        });
    }

updateNewGameType(){
    console.log('select',this);
   this.gameState=event.target.value
console.log('select',this.gameState)
   if (this.gameState=="autoplay"){
       fetch('http://treasure.chrisproctor.net/players/'+ this.userId +'/games/' + this.gameId + '/autoplay').then(response => {
            return response.json();
        }).then(data => {
            console.log('autoplay',data)
       treasure=data.turns[0].treasure
            observer.trigger('play:treasure',treasure);
        this.update();
            // Work with JSON data here
        });
   }

   if(this.gameState=="invite"){
       alert("please tell your friend your room Id:" + this.gameId)
       this.state="inviteFriend"
       this.update();
   }
}

startGameFriend(){
    this.gameState="readyWithFriends";
    console.log('with friends',this.userId)
    console.log('with friends',this.gameId)
    fetch('http://treasure.chrisproctor.net/players/'+ this.userId +'/games/' + this.gameId).then(response => {
         return response.json();
     }).then(data => {
         console.log(data)
         // Work with JSON data here
    var treasure=data.turns[0].treasure
      observer.trigger('play:treasure',treasure)
     });
}

join(){
    this.state="join";
}

</script>

<style>
 :scope{}

 .container {
     background-image: url(./asset/login.jpg);
     background-repeat:no-repeat;
     height:1000px;
   }

</style>

</game>
