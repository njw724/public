<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	    <%String rnum=request.getParameter("rnum");%>
<script src="https://rawgit.com/enyo/dropzone/master/dist/dropzone.js"></script>
<link rel="stylesheet" href="https://rawgit.com/enyo/dropzone/master/dist/dropzone.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.min.js" ></script>
<script type="text/javascript">
Dropzone.options.myDropzone = {
		  // Prevents Dropzone from uploading dropped files immediately
		  autoProcessQueue: false,

		  init: function() {
		    var submitButton = document.querySelector("#submit-all")
		        myDropzone = this; // closure
		
		    submitButton.addEventListener("click", function() {
		      myDropzone.processQueue(); // Tell Dropzone to process all queued files.
		      
		    });

		    // You might want to show the submit button only when 
		    // files are dropped here:
		    this.on("addedfile", function() {
		      // Show submit button here and/or inform user to click it.
		      
		    });
		  }
		};

</script>s
<body>
					<form id="myDropzone" class="dropzone" enctype="multipart/form-data" accept="" method="post" action="restaurant_upload">
						<input type="hidden" name="rnum" value="<%=rnum%>">
					</form>
					<button id="submit-all"><span>전송</span></button>
					
</body>