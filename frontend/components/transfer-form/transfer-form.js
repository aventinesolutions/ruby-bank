import { sendTransfer } from "client/transfer";
import "./transfer-form.css";

function submitTransfer(amount, email) {
  sendTransfer({ amount: amount.value, email: email.value });

  // eslint-disable-next-line
  amount.value = "";
  // eslint-disable-next-line
  email.value = "";
  amount.focus();
}

const form = document.querySelector(".transfer-form");

if (form) {
  const amount = form.querySelector(".js-input-amount");
  const email = form.querySelector(".js-input-email");
  const submit = form.querySelector(".js-form-submit");

  submit.addEventListener("click", event => {
    event.preventDefault();
    submitTransfer(amount, email);
  });
}
