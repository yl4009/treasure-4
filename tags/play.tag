<play>
    <div class="" hide={this.state==="gameOver"}>
    <button type="button" class="btn btn-primary" name="button" onclick={startPlay} hide={this.playState==="startPlay"}  >start play</button>
  		<div class="row">
  			<div id="left" class="col-1">
         <div class="btn-group-vertical">
            <button type="button" style="margin-top:5%" class="btn btn-success mr-md-2" name={item} id={item} onclick={playCard} each={item, i in allCards} show={this.playState==="startPlay"} >{item}</button>
          </div>
        </div>
        <div class="col-3" show={this.playState==="startPlay"}>
          <img src="./asset/{playerImage}.png" alt="player" style="height:200px;width:200px;">
          <p if={this.playCardState==="CardPlay"}> {this.userName} currently has a total treasure score of {this.userTotalTeasure}</p>
        </div>


        <div id="middle" class="col-3" show={this.playState==="startPlay"}>
          <p if={this.playState==="startPlay"}>  Round {this.turns}: <br>The value of treasure for this round is {this.treasure}</p>
          <p> Your opponent {this.opponent} played {this.oppoTurns} </p>
          <img src="./asset/{this.treasureImage}.jpg" alt="player" style="height:200px;width:200px;">
        </div>
        <div id="right" class="col-1">
       </div>

       <div class="col-3" show={this.playState==="startPlay"}>
         <img src="./asset/{oppoimage}.png" alt="player" style="height:200px;width:200px;">
         <p if={this.playCardState==="CardPlay"}> {this.opponent} currently has a total treasure score of: {this.oppoTotalTeasure}</p>
       </div>

       <div class="btn-group-vertical col-1" show={this.playState==="startPlay"}>
         <button type="button" style="margin-top:5%" class="btn btn-secondary mr-md-2" name={item} id={item} each={item, i in allCards} show={this.playState==="startPlay"} disabled>{item}</button>
       </div>
    </div>
    </div>
    <gameOver if={this.state==="gameOver"}></gameOver>


<script>
this.oppoimage="oppoimage1"
this.playerImage="girlpirate";

let tag=this;
this.allCards=[1,2,3,4,5,6,7,8,9,10,11,12,13]
this.playState=""
this.btnCount=0
this.treasure=""
this.turns="1";
this.youTotalTeasure=0;
this.oppoTotalTeasure=0;
var userName=this.parent.parent.userName;
this.userName=userName
console.log('userName',userName)
this.userInfo=[{
    myName:userName
}]

observer.on('playState:friend',(playFriend)=>{
    this.playFriend=playFriend;
    console.log("FFFFFF", this.playFriend)
    this.upstate
    if (playFriend){
        this.oppoimage="oppoimage2"
    } else this.oppoimage="oppoimage1"
});

observer.on('play:treasure',(treasure)=>{
 this.treasure=treasure
 this.update()
     if (this.treasure<6){
         this.treasureImage="treasurebox1"
     } else if(this.treasure<9) {
         this.treasureImage="treasurebox2"
     } else{
         this.treasureImage="treasurebox3"
     }
 console.log('frind trasure', this.treasure)
})

startPlay(){
 console.log('this',event.target);
    this.playState="startPlay";
    this.timer=setInterval(refreshInfo,3000)
}

var fetchInfo=()=>{

    this.gameId=this.parent.gameId;
    this.userId=this.parent.userId;
     console.log('iiii',this.parent.userId);
    var userId=this.userId;

    fetch('http://treasure.chrisproctor.net/players/'+ this.userId +'/games/' +this.gameId + '/play/' + this.cardNumber).then(response => {
         return response.json();
     }).then(data => {
         var turns=data.turns
         var lengthInTurns=turns.length;
         var decideTurns=data.turns[0];
         this.treasure=decideTurns.treasure;
         if (this.treasure<4){
             this.treasureImage="treasurebox1"
         } else if(this.treasure<9) {
             this.treasureImage="treasurebox2"
         } else{
             this.treasureImage="treasurebox3"
         }
         console.log('treasure',this.treasure);
         var i=0;
         for (var key in decideTurns){
         i=i+1
         };

            if (i==1 ) {
                var currentTurns=data.turns[1];
                for (var key in currentTurns){
                    if (key !=userName && key!="treasure"){
                        this.oppoTurns=currentTurns[key]
                        this.opponent=key
                        alert(this.opponent +":"+this.oppoTurns)
                        console.log('data.turns',data.turns)
                    }
                    }
            } else if (i==2){
                alert("opponent hasn't play")
            }

         console.log('xLABEL:', data)
         var players=data.players
         console.log('players',players)
         for (var key in players){
            if(key!=userName){
                this.opponent=key
                this.oppoTotalTeasure=players[key].score
                console.log('total 2',this.oppoTotalTeasure)
            } else {
                this.userTotalTeasure=players[key].score
                console.log('total 1',this.userTotalTeasure)
            }
        }

             this.userTotalTeasure=data.players[userName].score
         // Work with JSON data her

     this.turns=data.turns.length;
     this.playCardState="CardPlay";

     this.update();
     document.getElementById(this.cardNumber).style.color = "black";
     //alert("This button is disabled afterward.");
      if (lengthInTurns==13){
          this.state="gameOver"
      }
 });
     var userScore=this.userTotalTeasure;
     var oppoScore=this.oppoTotalTeasure
     observer.trigger('userScore',userScore)
     observer.trigger('oppoScore',oppoScore)
}

var refreshInfo=()=>{
    this.gameId=this.parent.gameId;
    this.userId=this.parent.userId;

    var userId=this.userId;
    fetch('http://treasure.chrisproctor.net/players/'+ this.userId +'/games/' +this.gameId).then(response => {
         return response.json();
     }).then(data => {
         var turns=data.turns
         var lengthInTurns=turns.length;
         var decideTurns=data.turns[0];
         this.treasure=decideTurns.treasure;
         if (this.treasure<4){
             this.treasureImage="treasurebox1"
         } else if(this.treasure<9) {
             this.treasureImage="treasurebox2"
         } else{
             this.treasureImage="treasurebox3"
         }
         console.log('treasure',this.treasure);
         var i=0;
         for (var key in decideTurns){
         i=i+1
         };

            if (i==1 ) {
                var currentTurns=data.turns[1];
                for (var key in currentTurns){
                    if (key !=userName && key!="treasure"){
                        this.oppoTurns=currentTurns[key]
                        this.opponent=key
                        //alert(this.opponent +":"+this.oppoTurns)
                        console.log('data.turns',data.turns)
                    }
                    }
            }

         console.log('xLABEL:', data)
         var players=data.players
         console.log('players',players)
         for (var key in players){
            if(key!=userName){
                this.opponent=key
                this.oppoTotalTeasure=players[key].score
                console.log('total 2',this.oppoTotalTeasure)
            } else {
                this.userTotalTeasure=players[key].score
                console.log('total 1',this.userTotalTeasure)
            }
        }

             this.userTotalTeasure=data.players[userName].score
         // Work with JSON data her

     this.turns=data.turns.length;
     this.playCardState="CardPlay";

     this.update();
     document.getElementById(this.cardNumber).style.color = "black";
     //alert("This button is disabled afterward.");
      if (lengthInTurns==13){
          this.state="gameOver"
      }
 });
     var userScore=this.userTotalTeasure;
     var oppoScore=this.oppoTotalTeasure
     observer.trigger('userScore',userScore)
     observer.trigger('oppoScore',oppoScore)

}
playCard(){
    this.cardNumber=event.target.name;
    console.log('xxxxx',this)
    fetchInfo()
}



</script>

<style>
  :scope{
  }


</style>

</play>
