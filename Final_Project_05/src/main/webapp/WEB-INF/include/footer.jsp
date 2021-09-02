<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>footer</title>

<style>
	/*footer css*/
	html,body {
	  height:100%;
	}
	.page-wrapper {
	  min-height: 100%;
	  margin-bottom: -229px; 
	}
	.page-wrapper:after {
	  content: "";
	  display: block;
	}
	.footer-distributed, .page-wrapper:after {
	  height:229px;
	}
	.footer-distributed{
		background-color: #014618;
		box-shadow: 0 1px 1px 0 rgba(0, 0, 0, 0.12);
		box-sizing: border-box;
		width: 100%;
		text-align: left;
		font: bold 16px sans-serif;
		padding: 55px 50px;
		margin-top: 80px;
	}
	.footer-distributed .footer-left,
	.footer-distributed .footer-center,
	.footer-distributed .footer-right{
		display: inline-block;
		vertical-align: top;
	}
	/* Footer left */
	.footer-distributed .footer-left{
		width: 40%;
	}
	/* The company logo */
	.footer-distributed h3{
		color: #ffffff;
		font: normal 36px 'Cookie', cursive;
		margin: 0;
	}
	.footer-distributed h3 span{
		color: #FFC107;
	}
	/* Footer links */
	.footer-distributed .footer-links{
		color:  #ffffff;
		margin: 20px 0 12px;
		padding: 0;
	}
	.footer-distributed .footer-links a{
		display:inline-block;
		line-height: 1.8;
		text-decoration: none;
		color:  inherit;
	}
	.footer-distributed .footer-company-name{
		color:  #8f9296;
		font-size: 14px;
		font-weight: normal;
		margin: 0;
	}
	/* Footer Center */
	.footer-distributed .footer-center{
		width: 35%;
	}
	.footer-distributed .footer-center i{
		background-color:  #33383b;
		color: #ffffff;
		font-size: 25px;
		width: 38px;
		height: 38px;
		border-radius: 50%;
		text-align: center;
		line-height: 42px;
		margin: 10px 15px;
		vertical-align: middle;
	}
	.footer-distributed .footer-center i.fa-envelope{
		color: white !important;
		font-size: 17px;
		line-height: 38px;
	}
	.footer-distributed .footer-center p{
		display: inline-block;
		color: #ffffff;
		vertical-align: middle;
		margin:0;
	}
	.footer-distributed .footer-center p span{
		display:block;
		font-weight: normal;
		font-size:14px;
		line-height:2;
	}
	.footer-distributed .footer-center p a{
		color: rgb(1,210,211);
		text-decoration: none;;
	}	
	/* Footer Right */
	.footer-distributed .footer-right{
		width: 20%;
	}
	.footer-distributed .footer-company-about{
		line-height: 20px;
		color:  #92999f;
		font-size: 13px;
		font-weight: normal;
		margin: 0;
	}
	.footer-distributed .footer-company-about span{
		display: block;
		color:  #ffffff;
		font-size: 14px;
		font-weight: bold;
		margin-bottom: 20px;
	}
	.footer-distributed .footer-icons{
		margin-top: 25px;
	}
	.footer-distributed .footer-icons a{
		display: inline-block;
		width: 35px;
		height: 35px;
		cursor: pointer;
		background-color:  #33383b;
		border-radius: 2px;
	
		font-size: 20px;
		color: #ffffff;
		text-align: center;
		line-height: 35px;
	
		margin-right: 3px;
		margin-bottom: 5px;
	}
	@media (max-width: 768px) {
		.footer-distributed{
			font: bold 14px sans-serif;
		}
		.footer-distributed .footer-left,{
			display: block;
			width: 100%;
			margin-bottom: 40px;
			text-align: center;
		}
		
		.footer-distributed .footer-center,
		.footer-distributed .footer-right{
			display: none;
		}
		.footer-distributed .footer-center i{
			margin-left: 0;
		}
	}

	
	}
</style>
</head>
<body>
	<footer class="footer-distributed ">
		<div class="footer-left ">
		    <h3>High<span>Clear</span></h3>
		     <div>
		         <p class="footer-company-name ">Badminton club &copy; 2021</p>
		         
		     </div>
		</div>
		     <div class="footer-center ">
		         <div>
		              <i class="fa fa-map-marker "></i>
		              <p><span>서울 강남구 테헤란로124 삼원타워</span> 에이콘 아카데미 베트민턴실</p>
		         </div>
		         <div>
		              <i class="fa fa-phone "></i>
		              <p>02)123-4567</p>
		         </div>
		         <div>
		              <i class="fa fa-envelope"></i>
		              <p><a href="mailto:Kgura@highclear.com" style="color: white;">Kgura@highclear.com </a></p>
		         </div>
		      </div>
		      <div class="footer-right ">
		      	 <p class="footer-company-about ">
		              <span>About the HighClear</span>
		              High-Clear provides the opportunity for members to play badminton. <br>
		              <small>noCopyright 2021ⓒ HighClear Research Instiute. All Right not Reserved.</small>
		         </p>
		      </div>
	</footer>
</body>
</html>