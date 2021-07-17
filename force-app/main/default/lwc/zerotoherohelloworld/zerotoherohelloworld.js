import { LightningElement,track } from 'lwc';

export default class Zerotoherohelloworld extends LightningElement {
    strMessage="Hello World";
    strTitle="LWC";
    @track address={
        city:'Melbourne',
        postcode:'6008',
        country:'Australia'
    };
   /*Data Binding Example */
    changeHandler(event){
        this.strTitle=event.target.value;
    }
    /*@Track Example */
    trackHandler(event){
       // this.address.city=event.target.value;
       //Using Spread operator
       this.address={...this.address,"city":event.target.value};
    } 

    /* Getter Example */
    users=["Sai","Bharathwaj","Thara"];
    num1=10;
    num2=12;

    get firstUser(){
        return this.users[0];
    }
    get multipleCalculation(){
        return this.num1*this.num2;
    }
}