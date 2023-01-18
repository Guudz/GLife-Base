function getRandomInt(max) {
    return Math.floor(Math.random() * Math.floor(max));
}


onNet('getRandom', (callback, max) => {

    callback(getRandomInt(max))
});