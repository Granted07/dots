const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
        if (entry.isIntersecting){
            entry.classList.add('cta-content-shown');
        }
    });
});
const hiddenElement = document.querySelectorAll(".container");
hiddenElement.forEach((el) => observer.observe(el));