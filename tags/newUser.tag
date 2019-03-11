<newUser>
  <div class= "center">
    <h1 hide={ loginState==="oldUser" || loginState === "readyToGo"}> Ahoy there Matey !</h1>
  </div>
  <div class="row">
    <div class="left">
      <input type="text" value="" class="newName" id="name" placeholder="input your new name" ref="userName" hide={ loginState==="oldUser" || loginState==="readyToGo"}>
    </div>
    <div class="right">
      <button type="button" onclick="{getChrisDataNewId}"  class="btn btn-primary" hide={ loginState==="oldUser" || loginState==="readyToGo"}>SUBMIT</button>
    </div>

    <div show={ loginState==="oldUser"} class="reveal">
      <h1> Ahoy there {this.userName} !</h1>
      <h2 hide={this.fail==="true"}>This is your User ID: {this.userId} </h2>
      <h2 if={this.fail==="true"}>{this.result}</h2>
      <p hide={this.fail==="true"}>Remember it well...or else...</p>
      <button type="button" onclick="{readyToStart}"  class="btn btn-primary" hide={ loginState==="readyToGo"||this.fail==="true"}> CONTINUE</button>
      <button type="button" class="btn btn-primary" name="button" onclick={setName} if={this.fail==="true"}>Set name again</button>
    </div>
 <oldUser show={ loginState==="readyToGo"}></oldUser>

<script>
let tag=this;
console.log(this);
this.userName="";

getChrisDataNewId(){
   this.userName=this.refs.userName.value;

  fetch('http://treasure.chrisproctor.net/players/new/' + this.userName).then(response => {
        return response.json();
    }).then(data => {
        // Work with JSON data here
        this.userId=data.pid;
        this.loginState="oldUser"
        this.result=this.userId
        if (!this.userId){
        this.result="sorry, this user name is taken"
        this.fail="true"
    } else{
        this.fail="flase"
    }
         this.update();
    });

  }

readyToStart(){
  this.loginState="readyToGo"
}

setName(){
    this.loginState="tryAgain"
    document.getElementById("name").value=""
}

</script>


<style>
    :scope{}
.newName{
  font-size: 25px;
}

.center{
  display: block;
  margin-left: 30%;
}

.left{
  margin-left:30%;
}

.right{
  margin-left: 10%;
}

.reveal{
 width:100%;
 text-align: center;

}
</style>
</newUser>
