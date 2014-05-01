{
header = "\033[1;"
footer = "\033[0m"

debug = "34m" #blue text
info = "34m" #green text
warn = "33m" #yellow text
error = "31m" #red text
fatal = "41m" #red background

color = "31m"

level=$4
if (level == "DEBUG") color = debug;
else if (level == "INFO") color = info;
  else if (level == "WARN") color = warn;
  else if (level == "ERROR") color = error;
  else if (level == "FATAL") color = fatal;

  printf $1 $2 $3 header color " " level  " "footer
  for (i=5; i <=NF; i++) printf "%s ", $i
  printf "\n"
}
