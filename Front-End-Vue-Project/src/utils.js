const jumpToThisPage = function (name, params) {
    this.$router.push({name: name, params: params});
};

export default {jumpToThisPage};
