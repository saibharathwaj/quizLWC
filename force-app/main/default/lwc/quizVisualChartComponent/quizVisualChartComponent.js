import { LightningElement, api } from 'lwc';
import chartResource from '@salesforce/resourceUrl/charts';
import { loadScript } from 'lightning/platformResourceLoader';

export default class QuizVisualChartComponent extends LightningElement {
    @api chartLabels;
    @api chartValues;
    //@api chartbgColor;
    @api chartbgColor=['rgb(60,179,113)','rgb(60,179,113)','rgb(255,165,0)','rgb(0,0,255)','rgb(255,0,0)'];
    @api strUserName;
    chart;
    connectedCallback(){
        console.log('inside: Chart:::');
        console.log('Ch labels::',this.chartLabels);
        console.log('chartbgColor::',this.chartbgColor);
        console.log('chartValues:::',this.chartValues);
        console.log('strUserName:::',this.strUserName);
        this.loadChartResource();
    }

    loadChartResource(){
        console.log('in loadChartResource');
        Promise.all([
            loadScript(this, chartResource +'/Chart.js')
        ])
        .then(() =>{
            //window.Chart.platform.disableCSSInjection = true;
            this.callBarChart();    
        })
        .catch((error) =>{
            console.log('Error in Chart load:::',error);
        });
    }

    callBarChart(){
        console.log('inside callbarchart:::');
        const config={
            type: "bar",
            data: {
                datasets: [
                    {
                        data: this.chartValues,
                       // data:[2,4,6,8,10,12,14,16,18,20],
                        backgroundColor:['Red','Green','Violet','Blue','Pink'],
                        label:'Performance Metrics'
                    }
                ],
                labels: this.chartLabels
            },
            options:{
                responsive:true,
                legend:{
                    display:false
                },
                animation: {
                    animateScale:true,
                    animateRotate:true
                },
                title: {
                    display:true,
                    text:this.strUserName
                }
            }
        };
        this.inserttoDOM("div.barChart",config);
    }

    inserttoDOM(divclass,config){
        console.log('inside dom::::');
        console.log('divclass:::',divclass);
        console.log('config:::',config);
        const canvas=document.createElement("canvas");
        const chartNode = this.template.querySelector(divclass);
        chartNode.innerHTML = "";
        chartNode.appendChild(canvas);
        const ctx = canvas.getContext("2d");
        this.chart = new window.Chart(ctx, config);
        this.chart.canvas.parentNode.style.height = 'auto';
        this.chart.canvas.parentNode.style.width = '100%';
    
    }
}