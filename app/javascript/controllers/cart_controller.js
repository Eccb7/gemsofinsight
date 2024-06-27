import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cart"
export default class extends Controller {
  initialize() {
    console.log("cart controller initialized");
    const cart = JSON.parse(localStorage.getItem("cart"));
    if (!cart) {
      return;
    }

    let total = 0;
    const tableBody = document.getElementById("cartItems");
    for (let i = 0; i < cart.length; i++) {
      const item = cart[i];
      total += item.price * item.quantity;
      const row = document.createElement("tr");

      // Populate table cells with item details
      row.innerHTML = `
        <td class="px-4 py-2">${item.name}</td>
        <td class="px-4 py-2">Ksh ${item.price}</td>
        <td class="px-4 py-2">${item.size}</td>
        <td class="px-4 py-2">${item.quantity}</td>
        <td class="px-4 py-2">
          <button class="bg-sky-500 rounded text-white px-2 py-1 ml-2" data-id="${item.id}" data-size="${item.size}" data-action="click->cart#removeFromCart">Remove</button>
        </td>
      `;
      tableBody.appendChild(row);
    }

    const totalEl = document.getElementById("total");
    totalEl.innerText = `Total: Ksh ${total}`;
  }

  clear() {
    localStorage.removeItem("cart");
    window.location.reload();
  }

  removeFromCart(event) {
    const cart = JSON.parse(localStorage.getItem("cart"));
    const id = event.target.getAttribute("data-id");
    const size = event.target.getAttribute("data-size");
    
    const index = cart.findIndex(item => item.id === id && item.size === size);
    if (index >= 0) {
      cart.splice(index, 1);
    }

    localStorage.setItem("cart", JSON.stringify(cart));
    window.location.reload();
  }

  checkout() {
    const cart = JSON.parse(localStorage.getItem("cart"));
    const payload = {
      authenticity_token: "",
      cart: cart
    };

    const csrfToken = document.querySelector("[name='csrf-token']").content;

    fetch("/checkout", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken
      },
      body: JSON.stringify(payload)
    }).then(response => {
      if (response.ok) {
        response.json().then(body => {
          window.location.href = body.url;
        });
      } else {
        response.json().then(body => {
          const errorEl = document.createElement("div");
          errorEl.innerText = `There was an error processing your order. ${body.error}`;
          let errorContainer = document.getElementById("errorContainer");
          errorContainer.appendChild(errorEl);
        });
      }
    });
  }

  orderViaWhatsapp() {
    const cart = JSON.parse(localStorage.getItem("cart"));
    if (!cart || cart.length === 0) {
      // Handle case when cart is empty
      alert("Your cart is empty. Please add items to your cart before ordering.");
      return;
    }

    let message = "Order details:\n";
    cart.forEach(item => {
      message += `Item: ${item.name}\nPrice: Ksh ${item.price}\nSize: ${item.size}\nQuantity: ${item.quantity}\n\n`;
    });

    // You can replace '1234567890' with the actual phone number you want to send the WhatsApp message to
    const phoneNumber = '254705086431';
    const whatsappURL = `https://wa.me/${phoneNumber}?text=${encodeURIComponent(message)}`;

    // Open WhatsApp in a new tab with the pre-filled message
    window.open(whatsappURL);
  }
}
