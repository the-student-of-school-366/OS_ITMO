select opt in  nano links vi "exit menu"; do

  case $opt in
    vi)
      echo "vi is running"
      vi
    ;;
    nano)
      echo "nano is running"
      nano
    ;;
    links)
      echo "links is running"
      links
    ;;
    "exit menu")
      break
    ;;
    *)
      echo "invalid option"
    ;;
  esac
done