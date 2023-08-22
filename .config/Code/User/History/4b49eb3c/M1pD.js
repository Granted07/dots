const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
        console.log(entry)
        if (entry.isIntersecting) {
            entry.target.classList.remove('cta-content-hidden');
            entry.target.classList.add('cta-content-shown');
        }
    });
});
const hiddenElement = document.querySelectorAll('.cta-content-hidden');
hiddenElement.forEach((element) => observer.observe(element));