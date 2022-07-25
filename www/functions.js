
// Pour créer un lien vers une tab en texte
var openTab = function (tabName) {
  $('a', $('.sidebar')).each(function () {
    if (this.getAttribute('data-value') == tabName) {
      this.click()
    };
  });
}