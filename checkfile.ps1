$DIRS=@(
"C:\Users\Hiroto Haruguchi\Desktop\fromLinux\"
)

foreach($DIR in $DIRS){
   $result = (dir $DIR/*.img)
   if ($result.Length -ne 0){
   move "C:\Users\Hiroto Haruguchi\Desktop\fromLinux\*.img" "C:\cygwin\home\Hiroto Haruguchi\"
   } 



}