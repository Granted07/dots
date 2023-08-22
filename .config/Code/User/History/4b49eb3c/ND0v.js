const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
        if (entry.isIntersecting){
            entry.target.classList.add('cta-content-shown');
        }
    });
});
const hiddenElement = document.querySelectorAll(".cta-content-hidden");
hiddenElement.forEach((el) => observer.observe(el));