const hiddenElement = document.getElementById("cta-content-hidden");
if (hiddenElement.isIntersecting){
    hiddenElement.classList.add('cta-content-shown');
}