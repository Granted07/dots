const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
        console.log(entry)
        if (entry.isIntersecting) {
            entry.classList.remove('cta-content-hidden');
            entry.classList.add('cta-content-shown');
        }
    });
});
const hiddenElement = document.querySelectorAll('.cta-content-hidden');
hiddenElement.forEach((el) => observer.observe(el));