const article = document.querySelector('.post-content');
if(article) {
    const h2 = Array.from(article.querySelectorAll('h2'));
    const h3 = Array.from(article.querySelectorAll('h3'));
    h2.forEach((h2) => addlink(h2));
    h3.forEach((h3) => addlink(h3));
}

function addlink(item) {
    item.insertAdjacentHTML('beforeend', `<a class="heading__anchor-link" href="#${item.id}">#link</a>`);
}

var isInViewport = function (elem) {
    var distance = elem.getBoundingClientRect();
    return (
        distance.top >= 0 &&
        // distance.left >= 0 &&
        distance.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
        distance.right <= (window.innerWidth || document.documentElement.clientWidth)
    );
};

let callout = document.querySelector('.callout');

if (callout) {
    window.addEventListener('scroll', () => {
        if (isInViewport(callout)) {
            setTimeout(function () {
                callout.classList.add('shake');
            }, 1500);
        } else {
            callout.classList.remove('shake')
        }
    })
}


var form = document.querySelector(".search__form");

if(form) {
    form.addEventListener("submit", function(e) {
        e.preventDefault();
        var search = form.querySelector("input[type=search]");
        search.value = "site:benrobertson.io " + search.value;
        form.submit();
    });
}
