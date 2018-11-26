import createChannel from "./cable";

let callback;

const transferChannel = createChannel("TransferChannel", {
  received({ transfer }) {
    if (callback) callback.call(null, transfer);
  }
});

function sendTransfer(transfer) {
  transferChannel.perform("send_transfer", { transfer });
}

function setCallback(fn) {
  callback = fn;
}

export { sendTransfer, setCallback };
