<joinFriend>
<div class="" hide={this.state==="startPlayWithFriend"}>
    <input type="text" name="" ref="gameId" placeholder="please input the gameId">
    <button type="button" name="button" onclick={joinGame} class="btn btn-primary" >confirm</button>
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
</joinFriend>
