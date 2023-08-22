const hiddenElement = document.querySelector('.hidden');

const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
        console.log(entry)
        if (entry.isIntersecting) {
            hiddenElement.classList.add('show');
        }
    });
});

hiddenElement.forEach((element) => observer.observe(element));