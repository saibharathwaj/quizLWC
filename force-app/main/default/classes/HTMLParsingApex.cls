public class HTMLParsingApex {
    
    public static String strResp='<?xml version="1.0" encoding="UTF-8"?><breakfast_menu>  <food>    <name>Belgian Waffles</name>    <price>$5.95</price>    <description>Two of our famous Belgian Waffles with plenty of real maple syrup</description>    <calories>650</calories>  </food>  <food>    <name>Strawberry Belgian Waffles</name>    <price>$7.95</price>    <description>Light Belgian waffles covered with strawberries and whipped cream</description>    <calories>900</calories>  </food>  <food>    <name>Berry-Berry Belgian Waffles</name>    <price>$8.95</price>    <description>Light Belgian waffles covered with an assortment of fresh berries and whipped cream</description>    <calories>900</calories>  </food>  <food>    <name>French Toast</name>    <price>$4.50</price>    <description>Thick slices made from our homemade sourdough bread</description>    <calories>600</calories>  </food>  <food>    <name>Homestyle Breakfast</name>    <price>$6.95</price>    <description>Two eggs, bacon or sausage, toast, and our ever-popular hash browns</description>    <calories>950</calories>  </food></breakfast_menu>';  
	public Map<String,String> xmlDataMap= new Map<String,String>();
    @AuraEnabled
    public static String htmlTagParsing(){
        String value='<TABLE border="1" summary="This table summarizes travel expenses incurred during August trips to San Jose and Seattle"> <CAPTION>Travel Expense Report </CAPTION><TR><TH></TH><TH id="a2" axis="expenses">Meals</TH><TH id="a3" axis="expenses">Hotels</TH><TH id="a4" axis="expenses">Transport</TH><TD>subtotals</TD></TR><TR><TH id="a6" axis="location">San Jose</TH><TH></TH><TH></TH><TH></TH><TD></TD></TR><TR><TD id="a7" axis="date">25-Aug-97</TD><TD headers="a6 a7 a2">37.74</TD><TD headers="a6 a7 a3">112.00</TD><TD headers="a6 a7 a4">45.00</TD><TD></TD></TR><TR><TD id="a8" axis="date">26-Aug-97</TD><TD headers="a6 a8 a2">27.28</TD><TD headers="a6 a8 a3">112.00</TD><TD headers="a6 a8 a4">45.00</TD><TD></TD></TR><TR><TD>subtotals</TD><TD>65.02</TD><TD>224.00</TD><TD>90.00</TD><TD>379.02</TD></TR><TR><TH id="a10" axis="location">Seattle</TH><TH></TH><TH></TH><TH></TH><TD></TD></TR><TR><TD id="a11" axis="date">27-Aug-97</TD><TD headers="a10 a11 a2">96.25</TD><TD headers="a10 a11 a3">109.00</TD><TD headers="a10 a11 a4">36.00</TD><TD></TD></TR><TR><TD id="a12" axis="date">28-Aug-97</TD><TD headers="a10 a12 a2">35.00</TD><TD headers="a10 a12 a3">109.00</TD><TD headers="a10 a12 a4">36.00</TD><TD></TD></TR><TR><TD>subtotals</TD><TD>131.25</TD><TD>218.00</TD><TD>72.00</TD><TD>421.25</TD></TR><TR><TH>Totals</TH><TD>196.27</TD><TD>442.00</TD><TD>162.00</TD><TD>800.27</TD></TR></TABLE>';
    	String escapeString= value.escapeHtml4();
        System.debug('escapeString:::'+escapeString);//&lt;&gt;
        String unescapeString=value.unescapeHtml4();
        System.debug('unescape String:::'+unescapeString);
        return unescapeString;
    }
   
    public void parserXML(){
        xmlDataMap= new Map<String,String>();
        DOM.document doc= new DOM.Document();
        try {
            doc.load(strResp);
            DOM.XmlNode root= doc.getRootElement();
            iterateThroughXML(root);
        } catch(Exception e){
            
        }
    }
    
    public void iterateThroughXML(DOM.XmlNode node){
       // System.debug('Nodetype:::'+node.getNodeType());
        if(node.getNodeType() == DOM.XmlNodeType.ELEMENT){
            System.debug('Name::'+node.getName());
            if(node.getName().equalsIgnoreCase('food')){
                System.debug('Attribute count:::'+node.getAttributeCount());
               // System.debug('KeyAt 0:::'+node.getAttributeKeyAt(0));
                //System.debug('KeyNsAt 0::::'+node.getAttributeKeyNsAt(0));
                //System.debug('KeyAt 1::::'+node.getAttributeKeyAt(1));
                //System.debug('KeyNsAt 1::::'+node.getAttributeKeyNsAt(1));
                if(node.getAttributeCount() > 0){
                    xmlDataMap.put(node.getAttributeValue(node.getAttributeKeyAt(0), node.getAttributeKeyNsAt(0)), 
                                   node.getAttributeValue(node.getAttributeKeyAt(1), node.getAttributeKeyNsAt(1)));
                }
            }
            System.debug('Parent:::'+node.getParent());
            
            for(Dom.XmlNode child: node.getChildElements()){
               // iterateThroughXML(child);
               System.debug('Child Elements:::'+child.getChildElements());
                for(Dom.XmlNode detailElement: child.getChildElements()){
                    System.debug('Name:::'+detailElement.getName()+'~'+'Text::::'+detailElement.getText());
                }
            }
        }
        System.debug('Map:::'+xmlDataMap);
    }
    
}