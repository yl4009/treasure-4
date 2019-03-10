<gameOver>
<p>Game Over {this.result}</p>


<script>
let tag=this

//observer.on('userScore',(userScore)=>{
//    this.userScore=userScore})
//observer.on('oppoScore',(oppoScore)=>{
//    this.oppoScore=oppoScore})
var userScore=this.parent.userTotalTeasure
var oppoScore=this.parent.youTotalTeasure
if (userScore>oppoScore){
    this.result="You Win"
} else{
    this.result="sorry, you loose, want to try again?"
}
console.log('winnnnn',this.result)


</script>

</gameOver>
