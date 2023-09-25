var Timer = function (x, y) {
    var tf_counter = game.add.text(x, y, 'Time: ' + gameProperties.count, fontStyles.counterFontStyle);

    tf_counter.anchor.set(0, 0.5);

    var timer = game.time.events;

    this.start = function() {
        timer.loop(1000, update, this);
        timer.start();
    };
 
    this.stop = function() {
        timer.stop();
    };
 
    var update = function() {
        gameProperties.count++;
        tf_counter.text = 'Time: ' + gameProperties.count;
    };
};