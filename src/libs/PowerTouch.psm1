Function PowerTouch {
  # TODO Criar varios arquivos ao mesmo tempo: touch file_name.txt file_name2.txt
  # TODO Adicionar flags ao comando
  $file = $args[0]

  if($null -eq $file) {
    throw "No filename supplied"
  }

  if(Test-Path $file) {
    (Get-ChildItem $file).LastWriteTime = Get-Date
  }
  else {
    $null = New-Item -force -type file $file
  }
}

export-modulemember -function PowerTouch