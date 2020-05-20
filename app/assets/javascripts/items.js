$(function(){
  var index = [0,1,2,3,4,5,6,7,8,9];
  $(".exhibit__wrapper__itemimage__flexbox").on("click", ".delete-btn", function(){
    var targetIndex = Number($(this).attr("index"));
    index.push(targetIndex);
    if($(this).parent().parent().attr("class") == "exhibit__wrapper__itemimage__flexbox__imagearea-first"){
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
    $(this).parent().remove();
    $(`#item_images_attributes_${targetIndex}_image`).remove();
    $(".exhibit__wrapper__itemimage__flexbox").append(`<input class="file-field" type="file" name="item[images_attributes][${targetIndex}][image]" id="item_images_attributes_${targetIndex}_image">`);

  })
  var buildImage = function(url){
    if(index.length != 0){
      $(".exhibit__wrapper__itemimage__flexbox__imagearea").append(`
        <div class="exhibit__wrapper__itemimage__flexbox__imagearea__image">
        <img class="exhibit__wrapper__itemimage__flexbox__imagearea__image__img" src="${url}">
        <div class="delete-btn" index=${index[0]}><i class="far fa-times-circle"></i></div>
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
  $(".exhibit__wrapper__itemimage__flexbox").on("change", function(e){
    var blob = window.URL.createObjectURL(e.target.files[0]);
    buildImage(blob);
  })
})