$(document).on("turbolinks:load", function () {
  Payjp.setPublicKey("pk_test_f8d27e295fe0b604c446c7cb");
  let form = $(".form");

  $("#charge-form").click(function () {
    let card = {
      number: $("#card_number").val(),
      cvc: $("#cvc").val(),
      exp_month: $("#exp_month").val(),
      exp_year: $("#exp_year").val(),
    };

    Payjp.createToken(card, function (status, response) {
      if (status === 200) {
        $("#card_number").removeAttr("name");
        $("#cvc").removeAttr("name");
        $("#exp_month").removeAttr("name");
        $("#exp_year").removeAttr("name");
        var token = response.id;
        form.append($('<input type="hidden" name="payjpToken" />').val(token));
        form.get(0).submit();
        alert("ok");
      } else {
        form.find(".payment-errors").text(response.error.message);
        form.find("button").prop("disabled", false);
        alert("カード情報が正しくありません。");
      }
    });
  });
});
