<%-- 
    Document   : register
    Created on : 25 Feb, 2022, 5:07:14 PM
    Author     : hp
--%>
<%@page contentType="text/html" import="java.sql.*,java.util.*,java.util.Date;" pageEncoding="UTF-8"%>
<%    
    try{
            String email = null;
            Cookie c[] = request.getCookies();
            for(int i=0;i<c.length;i++){
                if(c[i].getName().equals("user")){
                    email = c[i].getValue();
                    break;
                }
            }
            if(email==null){
            
%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="UTF-8">
    <title>VR Tube</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap');
		*{
		  margin: 0;
		  padding: 0;
		  box-sizing: border-box;
		  font-family: 'Poppins',sans-serif;
		}
		body{
		  height: 100vh;
		  display: flex;
		  justify-content: center;
		  align-items: center;
		  padding: 10px;
		  background: linear-gradient(135deg, #71b7e6, #9b59b6);
		}
		.container{
		  max-width: 700px;
		  width: 100%;
		  background-color: #fff;
		  padding: 25px 30px;
		  border-radius: 5px;
		  box-shadow: 0 5px 10px rgba(0,0,0,0.15);
		}
		.container .title{
		  font-size: 25px;
		  font-weight: 500;
		  position: relative;
		}
		.container .title::before{
		  content: "";
		  position: absolute;
		  left: 0;
		  bottom: 0;
		  height: 3px;
		  width: 30px;
		  border-radius: 5px;
		  background: linear-gradient(135deg, #71b7e6, #9b59b6);
		}
		.content form .user-details{
		  display: flex;
		  flex-wrap: wrap;
		  justify-content: space-between;
		  margin: 20px 0 12px 0;
		}
		form .user-details .input-box{
		  margin-bottom: 15px;
		  width: calc(100% / 2 - 20px);
		}
		form .input-box span.details{
		  display: block;
		  font-weight: 500;
		  margin-bottom: 5px;
		}
		.user-details .input-box input{
		  height: 45px;
		  width: 100%;
		  outline: none;
		  font-size: 16px;
		  border-radius: 5px;
		  padding-left: 15px;
		  border: 1px solid #ccc;
		  border-bottom-width: 2px;
		  transition: all 0.3s ease;
		}
                .user-details .input-box select{
		  height: 45px;
		  width: 100%;
		  outline: none;
		  font-size: 16px;
		  border-radius: 5px;
		  padding-left: 15px;
		  border: 1px solid #ccc;
		  border-bottom-width: 2px;
		  transition: all 0.3s ease;
		}
		.user-details .input-box input:focus,
		.user-details .input-box input:valid{
		  border-color: #9b59b6;
		}
                .user-details .input-box select:focus,
		.user-details .input-box select:valid{
		  border-color: #9b59b6;
		}
		 form .gender-details .gender-title{
		  font-size: 20px;
		  font-weight: 500;
		 }
		 form .category{
		   display: flex;
		   width: 80%;
		   margin: 14px 0 ;
		   justify-content: space-between;
		 }
		 form .category label{
		   align-items: center;
		   display: inline-flex;
		   cursor: pointer;
		 }
		 form .category label .dot{
		  height: 18px;
		  width: 18px;
		  border-radius: 50%;
		  margin-right: 10px;
		  background: #d9d9d9;
		  cursor: pointer;
		  border: 5px solid transparent;
		  transition: all 0.3s ease;
		}
		
		 
		 form .button{
		   height: 45px;
		   margin: 35px 0
		 }
		 form .button input{
		   height: 100%;
		   width: 100%;
		   border-radius: 5px;
		   border: none;
		   color: #fff;
		   font-size: 18px;
		   font-weight: 500;
		   letter-spacing: 1px;
		   cursor: pointer;
		   transition: all 0.3s ease;
		   background: linear-gradient(135deg, #71b7e6, #9b59b6);
		 }
		 form .button input:hover{
		  /* transform: scale(0.99); */
		  background: linear-gradient(-135deg, #71b7e6, #9b59b6);
		  }
		 @media(max-width: 584px){
		 .container{
		  max-width: 100%;
		}
		form .user-details .input-box{
			margin-bottom: 15px;
			width: 100%;
		  }
		  form .category{
			width: 100%;
		  }
		  .content form .user-details{
			max-height: 300px;
			overflow-y: scroll;
		  }
		  .user-details::-webkit-scrollbar{
			width: 5px;
		  }
		  }
		  
		  .btn.btn-primary {
				height: 100%;
				padding:2px 10px;
				border-radius: 5px;
				border: none;
				color: #fff;
				font-size: 18px;
				font-weight: 500;
				letter-spacing: 1px;
				cursor: pointer;
				transition: all 0.3s ease;
				background: linear-gradient(135deg, #71b7e6, #9b59b6);
			}

			.btn.btn-primary:hover {
				/* transform: scale(0.99); */
				background: linear-gradient(-135deg, #71b7e6, #9b59b6);
			}
			
		  
		  @media(max-width: 459px){
		  .container .content .category{
			flex-direction: column;
		  }
		}
        .breadcrumb1 {
            margin-top:25px; 
        }
        .breadcrumb1 ul{
                padding:0;
                margin:0;
                list-style:none;
        }
        .breadcrumb1 li {
            position: relative;
            margin-right: 10px;
            padding-right: 10px;
            display: inline-block;
            color:#000;
            font-size: 20px;
        }
        .breadcrumb1 li a {
            display:inline-block;
            color:#c32143;
        }
        .breadcrumb1 li a:hover{
                color:#000;
                text-decoration:none;
        }
        i.bx{
                color:#c32143;
                font-size:20px;
        }
        span.divider {
            padding: 0 5px;
            color: #ccc;
        }
	</style>
        <script>
		$(document).ready(function(){
			$(".btn.btn-primary").click(function(){
				var text = $(this).text();
				//alert(text);
				$.post(
					"login.jsp",{text:text},function(data){
						$("#rec").html(data);
					}
				);
			});
		});
                
		
	</script>
  </head>
   <body>
       
  <div class="container" id="rec">
      <%
                                        if(request.getParameter("img_success")!=null){
                                            out.println("<h6 class='alert alert-success'> User Register Successfully !</h6>");
                                        }
                                        else if(request.getParameter("empty")!=null){
                                            out.println("<h6 class='alert alert-warning'>All Field Required !</h6>");
                                        }
                                        else if(request.getParameter("again")!=null){
                                            out.println("<h6 class='alert alert-danger'>Try Again !</h6>");
                                        }
                                        else if(request.getParameter("img_error")!=null){
                                            out.println("<h6 class='alert alert-danger'>Profile Image not upload !</h6>");
                                        }
                                    %>
     <div class="breadcrumb1">
        <ul>
          <a href="index.jsp"><i class='bx bxs-home'></i></a>
          <span class="divider">&nbsp;|&nbsp;</span>
          <li class="current-page"><b>Home</b></li>
        </ul>
    </div>                                
     <br>
    <div class="title">Registration</div>
    <div class="content">
		<form action="insert_rec.jsp" method="post">
			 <div class="user-details">
			  <div class="input-box">
				<span class="details">Username</span>
                                <input type="text" name="username" id="username" placeholder="Enter your username" required>
			  </div>
			  <div class="input-box">
				<span class="details">Email</span>
                                <input type="text" name="email" id="email" placeholder="Enter your email" required>
			  </div>
			  <div class="input-box">
				<span class="details">Phone Number</span>
				<input type="text" name="phone" id="phone" placeholder="Enter your number" required>
			  </div>
			  <div class="input-box">
				<span class="details">Password</span>
                                <input type="password" name="pass" id="pass" placeholder="Enter your password" required>
			  </div>
			  <div class="input-box">
				<span class="details">Date of Birth</span>
                                <input type="date" name="dob" id="dob" placeholder="Enter your DOB" required>
			  </div>
			  <div class="input-box">
				<span class="details">Country</span>
                                <select name="country" id="country"> 
                                        <option value="India">India</option>
                                        <option value="United States">United States</option>
                                        <option value="Australia">Australia</option>
                                        <option value="China">China</option>
                                        <option value="Bangladesh">Bangladesh</option>
                                        <option value="Russia">Russia</option>
                                        <option value="not define">Other</option>
                                </select> 
			  </div>
			</div>  
			<div class="gender-details">
			  <span class="gender-title">Gender</span>
				<div class="category">
				  <div class="radios">
					<label for="radio-01">
                                            <input type="radio" class="dot" name="gender" id="gender" value="Male"> Male
					</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				  <label for="radio-02">
                                      <input type="radio" class="dot" name="gender" id="gender" value="Female"> Female
				  </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				  <label for="radio-03">
                                      <input type="radio" class="dot" name="gender" id="gender" value="Prefer not to say"> Prefer not to say
					</label>
				  </div>
				</div>
			</div>
			<div class="button">
			  <input type="submit" value="Register">
			</div>
		</form>
                <p class="text-center">
			<center>No thanks I have account .&nbsp;&nbsp;<button class="btn btn-primary">Login</button></center>
		</p>
    </div>
  </div>

</body>
</html>
<%
            }
            else{
                response.sendRedirect("index.jsp");
            }
    }
   catch(NullPointerException ec){
       out.println(ec.getMessage());
   }
%>