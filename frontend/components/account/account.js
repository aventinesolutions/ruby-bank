import { setCallback } from "client/transfer";
import "./account.css";

const element = document.querySelector(".account");

if (element) {
  setCallback(account => {
    element.innerHTML = account;
  });
}
