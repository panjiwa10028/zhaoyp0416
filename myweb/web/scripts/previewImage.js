function PreviewImg(imgFile,ImgD)
{
    //原来的预览代码，不支持 IE7。
   // ImgD.innerHTML = "<img src=\"file:\\\\" + imgFile.value + "\" width=\"80\" height=\"60\" />";
	ImgD.innerHTML = '';
    //新的预览代码，支持 IE6、IE7。
    ImgD.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = imgFile;
    ImgD.style.width = "80px";
    ImgD.style.height = "60px";
}

var maxH = 768; 
var maxW = 1024; 
	/**
 * 判断上传图片尺寸
 * @param ImgD
 * @return
 */
function DrawImage(ImgD,width,height){ 
	var preW = 240; alert(ImgD.src);
	var preH = 320;
	if(width != undefined) {
		preW = width;
	}
	if(height != undefined) {
		preH = height;
	}
	var image=new Image(); 
	image.src=ImgD.src; 
	if(image.width > maxW || image.height > maxH){ 
		alert("图片尺寸过大，请选择" + maxW + "*" + maxH + "的图片！"); 
		return; 
	} 
	if(image.width>0 && image.height>0){ 
		flag=true; 
		if(image.width/image.height>= preW/preH){ 
			if(image.width>preW){ 
				ImgD.width=preW; 
				ImgD.height=(image.height*preW)/image.width; 
			}else{ 
				ImgD.width=image.width; 
				ImgD.height=image.height; 
			} 
			ImgD.alt=image.width+"×"+image.height; 
		} 
		else{ 
			if(image.height>preH){ 
				ImgD.height=preH; 
				ImgD.width=(image.width*preH)/image.height; 
			}else{ 
				ImgD.width=image.width; 
				ImgD.height=image.height; 
			} 
			ImgD.alt=image.width+"×"+image.height; 
		} 
	} 
} 
/**
 * 检查上传文件的格式必须是JPG,GIF,PNG,JPEG,BMP文件
 * @param filePath
 * @return
 */
function checkFormat(filePath) { 
	var i = filePath.lastIndexOf('.'); 
	var len = filePath.length; 
	var str = filePath.substring(len,i+1); 
	var extName = "JPG,GIF,PNG,JPEG,BMP"; 
	if(extName.indexOf(str.toUpperCase()) < 0) { 
		alert("请选择正确的图片文件!"); 
			return false; 
		} 
			return true; 
} 
/**
 * 上传文件改变时预览图片
 * @see <input type="file" size="30" name="logo" onChange="javascript:FileChange(this.value,'uploadimage');">
 * @param value
 * @return
 */	
function FileChange(value,perviewImg){
	if(checkFormat(value)){ 
		flag=false;		
		PreviewImg(value,document.getElementById(perviewImg));
	} 
}