$(function(){
  var index = [0,1,2,3,4,5,6,7,8,9];
  // 商品編集画面開いた際に、画像編集時の画像差し替え処理に入らないよう初期値を設定
  var editIndex = 10;
  var request = $("#image-area").attr("action");
  if(request != undefined && request.indexOf("edit") != -1){
    $.ajax({
      url: "/items/set_images",
      data: {id:request.replace(/[^0-9]/g, '')},
      dataType: "json"
    }).done(function(data){
      data.images.forEach(function(d){
        buildImage(d.image.url);
      })
    })
  }

  $(".exhibit__wrapper__itemimage__flexbox").on("click", ".edit-btn", function(){
    editIndex = Number($(this).attr("index"));
    $(`#item_images_attributes_${editIndex}_image`).click()
  })

  $(".exhibit__wrapper__itemimage__flexbox").on("click", ".delete-btn", function(){
    var targetIndex = Number($(this).attr("index"));
    $(`#item_images_attributes_${targetIndex}__destroy`).prop("checked", true);
    index.push(targetIndex);
    if($(this).parent().parent().parent().attr("class") == "exhibit__wrapper__itemimage__flexbox__imagearea-first"){
      $(".exhibit__wrapper__itemimage__flexbox__imagearea .exhibit__wrapper__itemimage__flexbox__imagearea__image:first").appendTo(".exhibit__wrapper__itemimage__flexbox__imagearea-first");
    }
    if(index.length > 6){
      $(".exhibit__wrapper__itemimage__flexbox__imagearea__field").css("width",(index.length-5)*132);
    }else if(index.length == 6){
      $("#field-second").remove();
      $(".exhibit__wrapper__itemimage__flexbox__imagearea").remove();
      $(".exhibit__wrapper__itemimage__flexbox__imagearea-first").attr("class", "exhibit__wrapper__itemimage__flexbox__imagearea");
      $(".exhibit__wrapper__itemimage__flexbox__imagearea__field").css("display","flex");
    }else if(index.length == 1){
      $("#field-second").css("display","flex");
      $("#field-second").css("width",index.length*132);
    }else{
      $("#field-second").css("width",index.length*132);
    }
    $("#image-area").attr("for",`item_images_attributes_${targetIndex}_image`);
    $(this).parent().parent().remove();
    $(`#item_images_attributes_${targetIndex}_image`).remove();
    $(".exhibit__wrapper__itemimage__flexbox").append(`<input class="file-field" type="file" name="item[images_attributes][${targetIndex}][image]" id="item_images_attributes_${targetIndex}_image">`);
  })
  var buildImage = function(url){
    if(index.indexOf(editIndex) === -1 && editIndex != 10) {
      if(img = $(`img[index="${editIndex}"]`)[0]){
        img.setAttribute("src", url);
        $(".exhibit__wrapper__itemimage__flexbox").append(`<input class="file-field" type="file" name="item[images_attributes][${editIndex}][image]" id="item_images_attributes_${editIndex}_image">`);
      }
    } else {
      if(index.length != 0){
        $(".exhibit__wrapper__itemimage__flexbox__imagearea").append(`
          <div class="exhibit__wrapper__itemimage__flexbox__imagearea__image">
          <img index=${index[0]} class="exhibit__wrapper__itemimage__flexbox__imagearea__image__img" src="${url}">
          <div class="btn-flexbox">
            <div class="delete-btn" index=${index[0]}><i class="far fa-times-circle"></i></div>
            <div class="edit-btn" index=${index[0]}><i class="fas fa-edit"></i></div>
          </div>
        `);
        $(".exhibit__wrapper__itemimage__flexbox").append(`<input class="file-field" type="file" name="item[images_attributes][${index[1]}][image]" id="item_images_attributes_${index[1]}_image">`);
        $("#image-area").attr("for",`item_images_attributes_${index[1]}_image`);
        index.shift();
        if(index.length > 5){
          $("#field-second").remove();
          $(".exhibit__wrapper__itemimage__flexbox__imagearea__field").css("display","flex");
          $(".exhibit__wrapper__itemimage__flexbox__imagearea__field").css("width",(index.length-5)*132);
        }else if(index.length == 5){
          $(".exhibit__wrapper__itemimage__flexbox__imagearea__field").css("display","none");
          $("#image-area").append(`
            <div class="exhibit__wrapper__itemimage__flexbox__imagearea__field" id="field-second">
              <i class="fas fa-camera"></i>
              <div class="exhibit__wrapper__itemimage__flexbox__imagearea__field__text">
                クリックしてファイルをアップロード
              </div>
            </div>
          `);
          $(".exhibit__wrapper__itemimage__flexbox__imagearea").attr("class", "exhibit__wrapper__itemimage__flexbox__imagearea-first");
          $(".exhibit__wrapper__itemimage__flexbox__imagearea-first").after(`<div class="exhibit__wrapper__itemimage__flexbox__imagearea"></div>`);
        }else if(index.length == 0){
          $("#field-second").css("display","none");
        }
        $("#field-second").css("width",index.length*132);
      }
    }
  }
  $(".exhibit__wrapper__itemimage__flexbox").on("change", function(e){
    var blob = window.URL.createObjectURL(e.target.files[0]);
    buildImage(blob);
  })
})