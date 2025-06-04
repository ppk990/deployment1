

<!DOCTYPE html>
<html>
    <head>
        <Title>YATRA</Title>
        <style>
            h1{                
                text-align: center;
                color: rgb(90, 1, 19);
            }
            body{
                background-image: url(sunset.jpg);
                background-repeat: no-repeat;
                background-position: center;
                background-size: 120% auto;
                height: max-content;
                background-position-y: center;
            }
            .one{
                text-align: center;
                margin: 100px 50px 50px 50px;
                background-color: orange;
                color: black;

            }
            .two{
                text-align: center;
                margin: 100px 50px 50px 50px;
                 background-color: orange;
                color: black;

            }
            .three{
                text-align: center;
                margin: 100px 50px 50px 50px;
                background-color: yellowgreen;
                color: bisque;

            }
            
            </style>
        </head>
    <body>
        <Form method="POST">
        <h1>YATRA</h1>
        <div class="one">
        <label>Email</label>
        <input type="text" name="Email" required placeholder="enter email" style="background-color: yellowgreen ; color: brown;"><br/>
        </div>
        <div class="two">
        <label>Passwword</label>
        <input type="text" name="Passwword" required placeholder="enter pass" style="background-color: aqua;color: darkred;"><br/>
            </div>
            <div class="three">
        <input type="submit" name="sb" value="Submit" style="background-color: cadetblue;color: darkgreen;">
        </div>
</Form>
        </body>
        
<?php

$con=mysqli_connect('localhost','root','','Sample');

if(isset($_POST['sb'])){
    $Email=$_POST['Email'];
    $Passwword=$_POST['Passwword'];

    $query="INSERT INTO yatra(Email,Passwword) values('$Email','$Passwword')";
    $execute=mysqli_query($con,$query);
}
?>
</html>