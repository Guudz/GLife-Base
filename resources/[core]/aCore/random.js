function getRandomInt(max) {
    return Math.floor(Math.random() * Math.floor(max));
}


on('getRandom', (callback, max) => {

    callback(getRandomInt(max))
});