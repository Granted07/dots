
const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
        console.log(entry)
        if (entry.isIntersecting) {
            hiddenElement.classList.add('.cta-content-shown');
        }
    });
});
const hiddenElement = document.querySelector('.cta-content-hidden');
hiddenElement.forEach((element) => observer.observe(element));