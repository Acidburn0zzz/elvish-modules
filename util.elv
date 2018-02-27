use re

fn dotify-string [str dotify-length]{
  if (or (== $dotify-length 0) (<= (count $str) $dotify-length)) {
    put $str
  } else {
    re:replace '(.{'$dotify-length'}).*' '$1…' $str
  }
}

fn pipesplit [l1 l2 l3]{
  pout = (pipe)
  perr = (pipe)
  run-parallel {
    $l1 > $pout 2> $perr
    pwclose $pout
    pwclose $perr
  } {
    $l2 < $pout
    prclose $pout
  } {
    $l3 < $perr
    prclose $perr
  }
}

fn eval [str]{
  tmpf = (mktemp)
  echo $str > $tmpf
  -source $tmpf
  rm -f $tmpf
}

fn y-or-n [&style=default prompt]{
  prompt = $prompt" [y/n] "
  if (not-eq $style default) {
    prompt = (edit:styled $prompt $style)
  }
  print $prompt > /dev/tty
  resp = (head -n1 < /dev/tty)
  eq $resp y
}