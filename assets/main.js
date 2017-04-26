const article = document.querySelector('.post-content');
if(article) {
    const h2 = Array.from(article.querySelectorAll('h2'));
    const h3 = Array.from(article.querySelectorAll('h3'));

    h2.forEach((h2) => addlink(h2));
    h3.forEach((h3) => addlink(h3));
}

function addlink(item) {
    item.insertAdjacentHTML('beforeend', `<a class="heading__anchor-link" href="#${item.id}">#${item.id}</a>`);
}
