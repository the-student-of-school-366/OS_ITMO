str=""
input=""
while [[ "$input" != "q" ]]
do
str+="$input"
read -r input
done
echo $str