#PATCH CREATOR :

cd ~/PATCH
read patchname
mkdir $patchname
cd    $patchname;


mkdir exe;mkdir card;mkdir sql;mkdir sh;mkdir cat;mkdir dbd2;
cd dbdb2;

mkdir exe; mkdir sql;mkdir bnd;


echo "Please enter patch item or exit"
while true
do
  read fpath
  if [[ -z $fpath  || ! -f "$FILE" ]];then
    echo "Please enter patch item or exit"  	
  elif [ $fpath == "exit" ]; then
    echo "Added Item count $c Bye...";exit

  else
    # or wusing which $component name
    loc=`echo $fpath | cut -d '/' -f 5`
	case $loc in 
	  exe)
	    cp -p $fpath exe/.; ((c++));   ;;
	  cat)                         ;   ;;
	    cp -p $fpath cat/.; ((c++));   ;;
	  sh)                          ;   ;;
	    cp -p $fpath sh/.;  ((c++));   ;;
	  card)                        ;   ;;
	    cp -p $fpath card/.;((c++));   ;;
	  sql)                         ;   ;;
	    cp -p $fpath sql/.; ((c++));   ;;
	  dbdb2)
        loc2=`echo $fpath | cut -d '/' - 6`
		case $loc2 in
          exe)
            cp -p $fpath dbdb2/exe/.; ((c++)); ;; 
          bnd)                             ; ;;
            cp -p $fpath dbdb2/bnd/.; ((c++)); ;;
          sql)                             ; ;;
            cp -p $fpath dbdb2/sql/.; ((c++)); ;;
		  *)
		    echo "Wrong Path" ;;
        esac
       *)
	      echo "Wrong Path" ;;
	esac
  fi
done
