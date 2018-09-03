" Vim syntax file
" Language:         sqlbus log file
" Maintainer:       LiuYF @ CssWeb.com.cn
" Latest Revision:  2018-03-29

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn match   sqlbusBegin       display '^' nextgroup=sqlbusDate,sqlbusDateRFC3339

syn match   sqlbusDate        contained display '\a\a\a [ 0-9]\d *'
                                \ nextgroup=sqlbusHour

syn match   sqlbusHour        contained display '\d\d:\d\d:\d\d\s*'
                                \ nextgroup=sqlbusHost

syn match   sqlbusDateRFC3339 contained display '\d\{4}-\d\d-\d\d'
                                \ nextgroup=sqlbusRFC3339T

syn match   sqlbusRFC3339T    contained display '\cT'
                                \ nextgroup=sqlbusHourRFC3339

syn match   sqlbusHourRFC3339 contained display '\c\d\d:\d\d:\d\d\(\.\d\+\)\=\([+-]\d\d:\d\d\|Z\)'
                                \ nextgroup=sqlbusHost

syn match   sqlbusHost        contained display '\S*\s*'
                                \ nextgroup=sqlbusLabel

syn match   sqlbusLabel       contained display '\s*[^:]*:\s*'
                                \ nextgroup=sqlbusText contains=sqlbusKernel,sqlbusPID

syn match   sqlbusPID         contained display '\[\zs\d\+\ze\]'

syn match   sqlbusKernel      contained display 'kernel:'


syn match   sqlbusIP          '\d\+\.\d\+\.\d\+\.\d\+'

syn match   sqlbusURL         '\w\+://\S\+'

syn match   sqlbusText        contained display '.*'
                                \ contains=sqlbusNumber,sqlbusIP,sqlbusURL,sqlbusError

syn match   sqlbusNumber      contained '0x[0-9a-fA-F]*\|\[<[0-9a-f]\+>\]\|\<\d[0-9a-fA-F]*'

syn match   sqlbusError       contained '\c.*\<\(FATAL\|ERROR\|ERRORS\|FAILED\|FAILURE\).*'


hi def link sqlbusDate        Constant
hi def link sqlbusHour        Type
hi def link sqlbusDateRFC3339 Constant
hi def link sqlbusHourRFC3339 Type
hi def link sqlbusRFC3339T    Normal
hi def link sqlbusHost        Identifier
hi def link sqlbusLabel       Operator
hi def link sqlbusPID         Constant
hi def link sqlbusKernel      Special
hi def link sqlbusError       ErrorMsg
hi def link sqlbusIP          Constant
hi def link sqlbusURL         Underlined
hi def link sqlbusText        Normal
hi def link sqlbusNumber      Number

let b:current_syntax = "sqlbus"

let &cpo = s:cpo_save
unlet s:cpo_save
