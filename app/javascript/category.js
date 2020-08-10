$(function(){
  $(function(){
    function appendOption(category){
      var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
      return html;
    }
    function appendChidrenBox(insertHTML){
      var childSelectHtml = '';
      childSelectHtml = `<div class='edit__box__content__inner__category__form__input__added' id= 'children_wrapper'>
                          <div class='edit__box__content__inner__category__form__input1'>
                            
                            <select class="edit__box__content__inner__category__form__input--select" id="child_category" name="item[category_id]">
                              <option value="---" data-category="---">---</option>
                              ${insertHTML}
                            <select>
                          </div>
                        </div>`;
      $('.edit__box__content__inner__category__form__input').append(childSelectHtml);
    }

    function appendGrandchidrenBox(insertHTML){
      var grandchildSelectHtml = '';
      grandchildSelectHtml = `<div class='edit__box__content__inner__category__form__input__added' id= 'grandchildren_wrapper'>
                                <div class='edit__box__content__inner__category__form__input2'>
                                  
                                  <select class="edit__box__content__inner__category__form__input__box--select" id="grandchild_category" name="item[category_id]">
                                    <option value="---" data-category="---">---</option>
                                    ${insertHTML}
                                  </select>
                                </div>
                              </div>`;
      $('.edit__box__content__inner__category__form__input').append(grandchildSelectHtml);
    }

    $('#parent_category').on('change', function(){
      var parent_category_id = document.getElementById
      ('parent_category').value;
      if (parent_category_id != "---"){
        $.ajax({
          url: '/items/category/get_category_children',
          type: 'GET',
          data: { parent_id: parent_category_id },
          dataType: 'json'
        })
        .done(function(children){
          $('#children_wrapper').remove();
          $('#grandchildren_wrapper').remove();
          var insertHTML = '';
          children.forEach(function(child){
            insertHTML += appendOption(child);
          });
          appendChidrenBox(insertHTML);
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        $('#children_wrapper').remove();
        $('#grandchildren_wrapper').remove();
      }
    });

    $('.edit__box__content__inner__category').on('change', '#child_category', function(){
      var child_category_id = $('#child_category option:selected').data('category');
      if (child_category_id != "---"){
        $.ajax({
          url: '/items/category/get_category_grandchildren',
          type: 'GET',
          data: { child_id: child_category_id },
          dataType: 'json'
        })
        .done(function(grandchildren){
          if (grandchildren.length != 0) {
            $('#grandchildren_wrapper').remove();
            var insertHTML = '';
            grandchildren.forEach(function(grandchild){
              insertHTML += appendOption(grandchild);
            });
            appendGrandchidrenBox(insertHTML);
          }
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        $('#grandchildren_wrapper').remove();
      }
    });
  });
});