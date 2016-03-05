viewModel.app = {}; var app = viewModel.app;

app.isLoading = ko.observable(false);
app.ajaxPost = function (url, data, callbackSuccess, callbackError, otherConfig) {
    var callbackScheduler = function (callback) {
        app.isLoading(false);
        callback();
    };

    if (typeof callbackSuccess == "object") {
        otherConfig = callbackSuccess;
        callbackSuccess = function () { };
        callbackError = function () { };
    } 

    if (typeof callbackError == "object") {
        otherConfig = callbackError;
        callbackError = function () { };
    } 

    var config = {
        url: url,
        type: 'post',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: ko.mapping.toJSON(data),
        success: function (a) {
            callbackScheduler(function () {
                if (callbackSuccess !== undefined) {
                    callbackSuccess(a);
                }
            });
        },
        error: function (a, b, c) {
            callbackScheduler(function () {
                if (callbackError !== undefined) {
                    callbackError(a, b, c);
                }
            });
        }
    };

    if (data instanceof FormData) {
        delete config.config;
        config.data = data;
        config.async = false;
        config.cache = false;
        config.contentType = false;
        config.processData = false;
    }

    if (otherConfig != undefined) {
        config = $.extend(true, config, otherConfig);
    }

    if (config.hasOwnProperty("withLoader")) {
        if (config.withLoader) {
            app.isLoading(true);
        }
    } else {
        app.isLoading(true);
    }

    return $.ajax(config);
};
app.isFine = function (res) {
    if (!res.success) {
        sweetAlert("Oops...", res.message, "error");
        return false;
    }

    return true;
};
