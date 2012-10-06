if (typeof Date.prototype.getDayOfYear === 'undefined') {
    Date.prototype.getDayOfYear = function() {
        return Math.ceil((this - new Date(this.getFullYear(),0,1)) / 86400000);
    }
}

var refinery = window.refinery || {};

refinery.Calendar = function (config) {

    var Calendar = {
        datepicker : '',
        current_date : '',
        initialized : false,
        data : {},
        holder : null,
        root_url : '/calendar/',
        source_url : '/calendar/archive/',
        source_params : 'dates=true',

        // datepicker cfg
        defaultDate : null,
        firstDay : 0,
        year : 2012,
        month : 1,

        onChangeMonthYear : function (year, month, inst) {
            inst.settings.year = year;
            inst.settings.month = month;
            inst.settings.datepicker.datepicker('destroy');
            inst.settings.initialized = false;
            inst.settings.defaultDate = new Date(year, month -1);
            inst.settings.loadData(year, month);
        },

        beforeShowDay : function (date) { },

        prepareDialogData : function (dateText) {
            var date = new Date(dateText);
            var key = date.getDate().toString() + date.getMonth().toString() + date.getFullYear().toString();
            var title, body, cover, ev;

            title =  $('<h2/>', {
                text : date.toLocaleDateString()
            });
            body = $('<div />');

            if (this.data[key]) {
                day_data = this.data[key];

                for (i = 0; i < day_data.length; i++) {
                    ev = day_data[i];
                    cover = $('<div />').appendTo(body);

                    $('<a>', {
                        'href' : this.root_url + ev.slug,
                        'text' : ev.name
                    }).appendTo(cover);
                }
            }

            return {
                title : title,
                body : body
            }
        },

        showDialog : function (dateText) {
            var dialog_data = this.prepareDialogData(dateText);
            this.dialog.render(dialog_data);
        },

        onSelect : function(dateText, inst) {
            inst.settings.showDialog(dateText);
        },

        initPicker : function () {
            this.datepicker.datepicker(this);
        },

        processResponse : function (response) {
            var ev = null,
                date = null,
                key,
                tmp_date;

            for (var i = 0, l = response.length; i < l; i++) {
                ev = response[i];
                if (typeof ev.dates !== 'undefined' && ev.dates.length > 0) {
                    for (var j = 0; j < ev.dates.length; j++) {
                        tmp_date = new Date(ev.dates[j]['date_time']);
                        key = tmp_date.getDate().toString() + tmp_date.getMonth().toString() + tmp_date.getFullYear().toString();
                        this.data[key] = this.data[key] || [];
                        if (this.data[key].indexOf(ev) === -1) {
                            this.data[key].push(ev) ;
                        }
                    }
                } else {
                    // for backward compatibility
                    tmp_date = new Date(ev.start_date);
                    key = tmp_date.getDate().toString() + tmp_date.getMonth().toString() + tmp_date.getFullYear().toString();
                    this.data[key] = this.data[key] || [];
                    if (this.data[key].indexOf(ev) === -1) {
                        this.data[key].push(ev) ;
                    }
                }
            }
        },

        setHolderState : function (state) {
            var states = ['load', 'error', 'initialized'];
            this.holder.removeClass(states.join(' '));
            this.holder.addClass(state);
        },

        loadData : function (year, month) {
            var that = this;
            that.setHolderState('load');

            $.ajax({
                url : that.source_url + year + '/' + month + '?' + that.source_params,
                dataType : 'json',
                type : 'GET',
                error : function (response) {
                    if (!!console) {
                        console.log(response);
                    }

                    that.setHolderState('error');
                },
                success : function (response) {
                    if (response) {
                        try  {
                            that.processResponse(response);
                            if (!that.initialized) {
                                that.initialized = true;
                                that.setHolderState('initialized');
                                that.initPicker();
                                that.showDialog(that.current_date.toString('M/d/y'));
                            }
                        } catch (err) {
                            if (!!console) {
                                console.log(err);
                            }

                            that.setHolderState('error');
                        }
                    }
                }
            });
        },

        init : function (config) {
            var that = this;

            this.holder = $(config.holder);
            this.root_url = config.root_url || this.root_url;
            this.source_url = config.source_url || this.source_url;
            this.firstDay = config.first_day || this.firstDay;

            this.holder.html('');
            if (typeof $.datepicker === 'undefined') {
                var msg = 'Calendar require jQuery UI Datepicker.';
                msg += '<br>Please add to your <b>application.js</b>:<br >';
                msg += '<code>//= require jquery-ui</code>';

                this.holder.html(msg);
                return false;
            }

            this.datepicker = $('<div id="refinery-jquery-ui-calendar" />').appendTo(this.holder);
            this.dialog = new refinery.Calendar.Dialog(this.holder);

            this.current_date = new Date();
            this.year = this.current_date.getFullYear();
            this.month = this.current_date.getMonth() + 1;
            this.defaultDate = this.current_date;

            this.beforeShowDay = function (date) {
                var cls = '', rt = false,
                key = date.getDate().toString() + date.getMonth().toString() + date.getFullYear().toString();

                if ( that.data[key] ) {
                    cls += ' ui-datepicker-event';
                    rt = true;
                }

                if (date < that.current_date) {
                    cls += ' ui-datepicker-past';
                }

                return [rt, $.trim(cls)];
            }

            this.loadData(this.year, this.month);

            return this;
        }
    }

    return Calendar.init(config);
};

refinery.Calendar.Dialog = function (holder) {
    var holder = $(holder);
    if (holder.length > 0) {
        this.holder = $('<div id="refinery-calendar-dialog" style="display: none;" />').appendTo(holder);
        this.init();
    }
};

refinery.Calendar.Dialog.prototype = {
    holder : null,
    header_wrapper : null,
    body_wrapper : null,

    show : function () {
        this.holder.show();
    },

    hide : function () {
        this.holder.hide();
    },

    toggle : function () {
        this.holder.toggle();
    },

    render : function (content) {
        this.hide();
        this.setTitle(content.title);
        this.setBody(content.body);
        this.show();
    },

    setTitle : function (title) {
        this.header_wrapper.html('');
        title.appendTo(this.header_wrapper);
    },

    setBody : function (body) {
        this.body_wrapper.html('');
        body.appendTo(this.body_wrapper);
    },

    clear : function () {
        this.holder.html('');
    },

    init : function () {
        // todo close button
        this.header_wrapper = $('<div />', {
            'class' : 'dialog-header'
        }).appendTo(this.holder);

        this.body_wrapper = $('<div />', {
            'class' : 'dialog-body'
        }).appendTo(this.holder);
    }
};