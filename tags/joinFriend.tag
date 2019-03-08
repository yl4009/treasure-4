<joinFriend>
  <div class="container">
    <div class="buttons" hide={this.state==="startPlayWithFriend"}>
        <h2> Please input the game ID given by your friend</h2>
        <input type="text" name="" ref="gameId" placeholder="00000" style="margin-left:10%">
        <button type="button" name="button" class="btn btn-primary btn-lg" onclick={joinGame} class="btn btn-primary" style="margin-left:5%" >confirm</button>
    </div>
  </div>
  <play if={this.state==="startPlayWithFriend"}></play>

<script>

  joinGame(){
    this.userId=this.parent.userId;
    this.gameId=this.refs.gameId.value;
    this.userName=this.parent.userInfo.myName;
    console.log('parent', this)
    console.log('gameid',this.gameId)
  fetch('http://treasure.chrisproctor.net/players/'+ this.userId +'/games/' + this.gameId + '/join').then(response => {
     return response.json();
 }).then(data => {
     console.log(data)
     this.treasure=data.turns[0].treasure
     treasure=this.treasure
     observer.trigger('play:treasure',treasure)
     // Work with JSON data here
     this.state="startPlayWithFriend"
 });
     this.update()
}
</script>

<style>
 :scope{}

.container {
    background-image: url(./asset/map.jpg);
    background-repeat:no-repeat;
    height:1000px;
  }

.buttons {
  padding-top: 30%;
  padding-left: 13%;
}



</style>
</joinFriend>
