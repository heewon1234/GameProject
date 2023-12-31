var Tile = function (column, row, group) {

    this.states = {
        ZERO: 0,
        ONE: 1,
        TWO: 2,
        THREE: 3,
        FOUR: 4,
        FIVE: 5,
        SIX: 6,
        SEVEN: 7,
        EIGHT: 8,
        DEFAULT: 9,
        FLAG: 10,
        WRONG_FLAG: 11,
        UNKNOWN: 12,
        MINE: 13
    };

    this.column = column;
    this.row = row;
    this.x = column * gameProperties.tileWidth;
    this.y = row * gameProperties.tileHeight;
    this.onRevealed = new Phaser.Signal();
    this.onFlagged = new Phaser.Signal();

    var tile = this;
    var currentState = this.states.DEFAULT;
    var currentValue = this.states.ZERO;

    var sprite = game.add.sprite
        (
            this.x,
            this.y,
            graphicAssets.tiles.name,
            currentState,
            group
        );

    var init = function () {
        sprite.inputEnabled = true;
        sprite.input.useHandCursor = true;
        sprite.events.onInputOut.add(rollOut, this);
        sprite.events.onInputOver.add(rollOver, this);
        sprite.events.onInputDown.add(click, this);
    };

    var rollOver = function () {
        var tween = game.add.tween(sprite);
        tween.to({ x: tile.x - 3, y: tile.y - 3 }, 100, Phaser.Easing.Exponential.easeOut);
        tween.start();
    };

    var rollOut = function () {
        var tween = game.add.tween(sprite);
        tween.to({ x: tile.x, y: tile.y }, 100, Phaser.Easing.Exponential.easeOut);
        tween.start();
    };

    var click = function () {
        if (game.input.activePointer.rightButton.isDown) {
            tile.flag();
        } else if (currentState == tile.states.DEFAULT) {
            tile.reveal();
        }
        
    };

    this.reveal = function () {
        sprite.animations.frame = currentValue;
        sprite.inputEnabled = false;
        tile.onRevealed.dispatch(tile);
    };

    this.flag = function () {
        switch (currentState) {
            case tile.states.DEFAULT:
                currentState = tile.states.FLAG;
                break;
            case tile.states.FLAG:
                currentState = tile.states.UNKNOWN;
                break;

            case tile.states.UNKNOWN:
                currentState = tile.states.DEFAULT;
                break;
        }

        tile.onFlagged.dispatch(tile);
        sprite.animations.frame = currentState;
    };

    this.setValue = function (value) {
        currentValue = value;
    };

    this.getValue = function () {
        return currentValue;
    };

    this.isRevealed = function () {
        return (sprite.animations.frame == currentValue);
    };

    this.getState = function() {
        return currentState;
    };

    this.enable = function(enable) {
        sprite.inputEnabled = enable;
    };
 
    init();
};