# Fuzzy-finder based on skim written in rust

export def find_dir [
] : nothing -> string {
   let res = ls | where type == dir | select name | par-each { $"(ansi blue)($in.name)(ansi reset)" } | str join (char nl)
   $res | sk --ansi --tac
}

export def find_file [
] : nothing -> string {
   let res = ls | where type == file | select name | par-each { $in.name } | str join (char nl)
   $res | sk --ansi --tac
}

 export def find [
 ] : nothing -> string {
   let res = ls | sort-by type | par-each {
      match $in.type {
         "dir" => $"(ansi blue)($in.name)(ansi reset)"
         _ => $in.name
      }
   } | str join (char nl)

   $res | sk --ansi --tac
 }
