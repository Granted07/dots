const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
        console.log(entry)
        if (entry.isIntersecting) {
            entry.classList.add('cta-content-shown');
        }
    });
});
const hiddenElement = document.getElementById("cta-content-hidden");
hiddenElement.forEach((el) => observer.observe(el));