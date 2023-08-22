
const hiddenElement = document.querySelectorAll('.cta-content-hidden');
const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
        console.log(entry)
        if (entry.isIntersecting) {
            entry.target.classList.remove('cta-content-hidden');
            entry.target.classList.add('cta-content-shown');
        }
    });
});

hiddenElement.forEach((element) => observer.observe(element));