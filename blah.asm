la      #a0, text
li      $a1, 256
syscall

li      $t0, 0


find:

        lb          $t1, text($t0)  #tmp = text[i[
        bne         $t1, 0, print
        addi        $t0, $t0, 1
        j           find

print:

        li          $v0, 11



        syscall
        j            print

end:    $li,        $v0, 10
        syscall
