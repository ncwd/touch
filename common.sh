tempdircleanup() {
  [[ -d "$tdir" ]] && rm -rf $tdir
}

tempdir() {
  tdir=$(readlink -f $(mktemp -d tmp-XXXXXXXXX))
  cd $tdir
  trap tempdircleanup 0
}
