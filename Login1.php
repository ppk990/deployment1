<!DOCTYPE html>
<html>
    <head>
        <h1>Welcome</h1>
        </head>
        <body>
            <form  method="POST">
            Name:<input type="text" name="Name"><br/>
            Lastname:<input type="text" name="Lname"><br/>
            
            <button type="submit" name="sb" value="submit">Submit</button><br/>
</form>
        </body>
            <?php
$con =mysqli_connect('localhost','root','','private');
if(isset($_POST['sb'])) 

{
  $Name=$_POST['Name'];
  $Lastname=$_POST['Lname'];

  $query="INSERT INTO prime(Name,Lastname) values('$Name','$Lastname')";
  $execute=mysqli_query($con,$query);
}

?>
    </html>