WSDataType = { json: "json", jsonp: "jsonp" };

WS = function(service, dataType) {
    this.service = service;
    if (dataType)
        this.dataType = dataType;
};
WS.prototype = {
    dataType: WSDataType.json,
    service: null,


    call: function (method, args, callback, error) {

        //================== To Display the Loading message =======================//
        /*$('#GridView').block({
        message: 'Loading Assets..<br/><img src="images/ajax-loader1.gif" no-repeat alt="" />',
        centerY: false,
        centerX: false,
        css: { position: 'absolute'}
        });*/
        
        $("#divTile").text("");
        $("#message").text("");

        $('.loading_sign').block({ message: '<img src="images/loading21.gif"/>',
            centerY: false,
            centerX: false,
            css: {
                border: 'none',
                position: 'absolute'
            },
            baseZ: 100000
        });
        var url = null;
        var service = this.service;
        if (service[service.length - 1] != "/") service += "/";
        if (this.dataType == WSDataType.jsonp) {
            url = $.jmsajaxurl({
                url: service,
                method: method,
                data: args != null ? args : {}
            });
        } else {
            url = service + method;
        }


        $.ajax({
            type: this.dataType == WSDataType.json ? "POST" : "GET",
            url: url + ((this.dataType == WSDataType.jsonp) ? "&format=json" : ""),
            data: ((this.dataType == WSDataType.json) ? JSON.stringify(args) : ""),
            //cache: false,

            contentType: "application/json; charset=utf-8",
            dataType: this.dataType,
            success: function (response) {
                if (callback)
                    callback(response);
            },
            error: error
        });





    }
};