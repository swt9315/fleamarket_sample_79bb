window.addEventListener('DOMContentLoaded', function(){
  
  //id名が"payment_card_submit-button"というボタンが押されたら取得
  let submit = document.getElementById("payment_card_submit-button");
  Payjp.setPublicKey('pk_test_9a9b5886a32f02092f60b9a4');
    submit.addEventListener('click', function(e){
    e.preventDefault(); //ボタンを1度無効化
    let card = { //入力されたカード情報を取得
        number: document.getElementById("payment_card_no").value,
        cvc: document.getElementById("payment_card_cvc").value,
        exp_month: document.getElementById("payment_card_month").value,
        exp_year: document.getElementById("payment_card_year").value
    };
    Payjp.createToken(card, function(status, response) {  // トークンを生成
      if (status === 200) { //成功した場合(status === 200はリクエストが成功している状況
        //データを自サーバにpostしないようにremoveAttr("name")で削除
        $(".number").removeAttr("name");
        $(".cvc").removeAttr("name");
        $(".exp_month").removeAttr("name");
        $(".exp_year").removeAttr("name"); 
        $("#charge-form").append(
          $(`<input type="hidden" name="payjp_token" value="${response.id}">`)
        ); //取得したトークンを送信できる状態にします
        document.inputForm.submit();
      } else {
        alert("カード情報が正しくありません。"); //エラー確認用
      }
    });
  });
});
