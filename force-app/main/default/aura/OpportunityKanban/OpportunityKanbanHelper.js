({
    hideSpinner : function( component ) {
        var eleSpinner = component.find( "spinner" );
        
        $A.util.addClass( eleSpinner, "slds-hide" );
    },
    showSpinner : function( component ) {
        var eleSpinner = component.find( "spinner" );
        
        $A.util.removeClass( eleSpinner, "slds-hide" );
    },
    showToast : function( data ) {
       // var toastEvent = $A.get( "e.force:showToast" );
       // alert('11111');
        /*toastEvent.setParams(
            {
                duration	: 2000,
                title		: data.title,
                message		: data.message,
                type		: data.type ? data.type : (data.isSuccess ? "success" : "error")
            }
        );*/
        alert('Record Updated Successfully');
       // toastEvent.fire();
    },
    applySortable : function( component ) {     
        var helper = this;
        
        jQuery( ".slds-lane" ).sortable(
            {
                revert				: true,
                connectWith			: ".slds-lane",
                handle 				: ".slds-title",
                placeholder 		: "slds-item slds-m-around--small slds-item-placeholder"
            }
        );
        
        jQuery( ".slds-lane" ).on(
            "sortstart",
            $A.getCallback(
                function( event, ui ) {                    
                    jQuery( ui.item ).addClass( "moving-card" );
                }
            )
        );
        
        jQuery( ".slds-lane" ).on(
            "sortstop",
            $A.getCallback(
                function( event, ui ) {                    
                    jQuery( ui.item ).removeClass( "moving-card" );                    
                    
                    var oppId       		= $( ui.item ).data( "id" );
                    var oldOppStatus 		= $( ui.item ).data( "status" );
                    var newOppStatus   	    = $( ui.item ).parent().data( "name" );
                    var isDropEnabled 		= $( ui.item ).parent().data( "drop-enabled" );
                    
                    /**
                     * If the cards were dropped
                     * into a prohibited column
                     * and if the action was not
                     * just a re-ordering then
                     * thrown an error!
                     */
                    if( !isDropEnabled && oldOppStatus !== newOppStatus ) {
                        jQuery( ".slds-lane" ).sortable( "cancel" );
                        
                        helper.showToast( {
                            isSuccess 	: false,
                            title 		: "Prohibited",
                            message 	: "You cannot move cards into this column. Action has been reverted."
                        } );
                    }
                    else {
                        helper.showSpinner( component );
                        
                        var action = component.get( "c.updateOppStatus" );
                        var params = {
                            "oppId"        : oppId,
                            "newOppStatus" : newOppStatus,
                            "ordering"      : []
                        };
                        
                        /**
                         * Maintain the ordering within
                         * the lane.
                         */
                        $( ui.item ).parent().children().each(
                            function() {
                                params.ordering.push( $( this ).data( "id" ) );
                            }
                        );
                        action.setParams( params );
                        action.setCallback( 
                            this, 
                            function( response ) {
                                var state = response.getState();
                                
                                helper.hideSpinner( component );
                                
                                if( component.isValid() && state === "SUCCESS" ) {                                    
                                    var updateStatus = response.getReturnValue();
                                    
                                    /**
                                     * Show a separate message
                                     * if the cards were just
                                     * re-arranged within the
                                     * same column.
                                     */                                    
                                    if( oldOppStatus === newOppStatus ) {
                                        updateStatus.type 		= "info";
                                        updateStatus.message	= "Column Ordering was Updated.";
                                    }
                                    
                                    $( ui.item ).attr( "data-status", newOppStatus );
                                    
                                    helper.showToast( updateStatus );
                                }
                                else if(state === "INCOMPLETE")
                                {
                                    alert('Incomplete');
                                }
                                    else if(state === 'ERROR')
                                    {
                                        var errors = response.getError();
                                        if(errors)
                                        {
                                            if (errors[0] && errors[0].message) 
                                            {
                                                console.log("Error message : "+errors[0].message);
                                            }
                                            else
                                            {
                                                console.log("Unknown Error");
                                            }
                                        }
                                    }
                            }
                        );
                        
                        $A.enqueueAction( action );
                    }
                }
            )
        );
    }
})