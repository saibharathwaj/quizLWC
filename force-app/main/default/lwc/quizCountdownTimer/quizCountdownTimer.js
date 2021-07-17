import { LightningElement, track } from 'lwc';

export default class QuizCountdownTimer extends LightningElement {
    @track timeVal='0:0:0:0';
    timeIntervalInstance;
    totalMilliseconds=0;

    connectedCallback(){
        var parentThis=this;
        this.timeIntervalInstance=setInterval(
            function(){
                //Time calculation for counter in 100 milliseconds
                var hours=Math.floor((parentThis.totalMilliseconds % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                var minutes = Math.floor((parentThis.totalMilliseconds % (1000 * 60 * 60)) / (1000 * 60));
                var seconds = Math.floor((parentThis.totalMilliseconds % (1000 * 60)) / 1000);
                var milliseconds = Math.floor((parentThis.totalMilliseconds % (1000)));
                parentThis.timeVal=hours+':'+minutes+':'+seconds+':'+milliseconds;
                parentThis.totalMilliseconds+=100;
            },100
        );
        //clearing interval --- this.totalMilliseconds=0;clearInterval(this.totalMilliseconds);
    }

}