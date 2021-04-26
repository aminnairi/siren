import "./siren.css"
import Elm from "./Siren.elm";

window.addEventListener("load", () => {
  const sirenLink = document.createElement("link");

  sirenLink.setAttribute("href", "siren.css");
  sirenLink.setAttribute("rel", "stylesheet");

  document.body.appendChild(sirenLink);

  const main = document.getElementsByTagName("main");

  if (main instanceof HTMLCollection && main[0] instanceof HTMLElement && Elm && Elm.Siren && Elm.Siren.init) {
    const node = main[0];
    Elm.Siren.init({node});
  }
});
