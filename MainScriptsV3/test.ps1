$m = (
  @{name="xp86"; bit="bit32"; ip="10.1.190.12"},
  @{name="xp64"; bit="bit64"; ip="10.1.190.13"}
)

$machines = (
  @{name="xp86"; bit="bit32"; ip="10.1.190.12"},
  @{name="xp64"; bit="bit64"; ip="10.1.190.13"},

  @{name="vistax86"; bit="bit32"; ip="10.1.190.14"},
  @{name="vistax64"; bit="bit64"; ip="10.1.190.15"},

  @{name="win7x86"; bit="bit32"; ip="10.1.190.16"},
  @{name="win7x64"; bit="bit64"; ip="10.1.190.17"},

  @{name="whs2003x86"; bit="bit32"; ip="10.1.190.18"},
  @{name="whs2011x64"; bit="bit64"; ip="10.1.190.19"},

  @{name="win8x86"; bit="bit32"; ip="10.1.190.21"},
  @{name="win8x64"; bit="bit64"; ip="10.1.190.20"}
)


$tfw_path = "C:/Users/miroslav.beka.HQ/tfw/src/tfw_run.py"
$tfw_conf = "C:/Users/miroslav.beka.HQ/tfw/tfw.conf"
$tfw_script = "C:/Users/miroslav.beka.HQ/MainScriptsV3/foo.tfw"
$tfw_out = "C:/Users/miroslav.beka.HQ/MainScriptsV3/out/"

if (-not (Test-Path $tfw_out)){
  mkdir $tfw_out
}

$cwd = Get-Location

foreach ($machine in $m) {
  Write-Host "Executing regression set for $($machine["name"])"

  start-job -ScriptBlock {Python "$tfw_path" "-c" $tfw_conf "-v" "bit=$($machine["bit"])" "-v" "machine=$($machine["name"])" "-v" "product=ess" "-r" "http://$($machine["ip"]):11000" $tfw_script 2> "$($cwd)\$($machine["name"]).log"}
}

