set exact off

lc1 = "astring" + chr(9) + space(100)
lc2 = "astring"

? lc1 = lc2
** .F., expected .T.

lc2 += chr(9)
? lc1 = lc2
** .T., as expected

lc1 += chr(9)

? lc1 = lc2
** .F. ; expected: .T.
