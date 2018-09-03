" Vim syntax file
" Language:         /var/log/afc file
" Maintainer:       Yakov Lerner <iler.ml@gmail.com>
" Latest Revision:  2008-06-29
" Changes:          2008-06-29 support for RFC3339 tuimestamps James Vega
" 		    2016 Jan 19: afcDate changed by Bram

if exists("b:current_syntax")
  finish
endif
let s:cpo_save = &cpo
set cpo&vim

syn match   afcBegin       display '^' nextgroup=afcAfc,afcDate,afcDateRFC3339,afcText

syn match   afcAfc        contained display 'ERROR\|ERRORS\|error\|errors\|FAIL\|FAILED\|FAILURE\|fail\|failed\|failure'

syn match   afcDate        contained display '[[:lower:][:upper:]][[:lower:][:upper:]][[:lower:][:upper:]] [ 0-9]\d *' nextgroup=afcHour
syn match   afcHour        contained display '\d\d:\d\d:\d\d\s*' nextgroup=afcHost
syn match   afcDateRFC3339 contained display '\d\{4}-\d\d-\d\d' nextgroup=afcRFC3339T
syn match   afcRFC3339T    contained display '\cT' nextgroup=afcHourRFC3339
syn match   afcHourRFC3339 contained display '\c\d\d:\d\d:\d\d\(\.\d\+\)\=\([+-]\d\d:\d\d\|Z\)' nextgroup=afcHost
syn match   afcHost        contained display '\S*\s*' nextgroup=afcLabel
syn match   afcLabel       contained display '\s*[^:]*:\s*' nextgroup=afcText contains=afcKernel,afcPID
syn match   afcPID         contained display '\[\zs\d\+\ze\]'
syn match   afcKernel      contained display 'kernel:'
syn match   afcIP          display '\d\+\.\d\+\.\d\+\.\d\+'
syn match   afcText        contained display '.*' contains=afcNumber,afcIP,afcWarn,afcDebug,afcError
syn match   afcNumber      contained '0x[0-9a-fA-F]*\|\[<[0-9a-f]\+>\]\|\<\d[0-9a-fA-F]*'
syn match   afcError       contained '\c.*\<\(FATAL\|ERROR\|ERRORS\|FAILED\|FAILURE\|error\|fail\>\).*'
syn match   afcWarn        contained '\c.*WARNING:.*'
syn match   afcDebug       contained '\c.*DEBUG:.*'

"syn keyword AfcKey	ERROR DEBUG INFOMATION

hi def link afcAfc         ErrorMsg
hi def link afcDate        Constant
hi def link afcHour        Type
hi def link afcDateRFC3339 Constant
hi def link afcHourRFC3339 Type
hi def link afcRFC3339T    Normal
hi def link afcHost        Identifier
hi def link afcLabel       Operator
hi def link afcPID         Constant
hi def link afcKernel      Special
hi def link afcError       ErrorMsg
hi def link afcIP          Underlined
hi def link afcURL         Underlined
hi def link afcText        Normal
hi def link afcWarn        Identifier
hi def link afcDebug       comment

"hi def link AfcKey Type

let b:current_syntax = "afclog"
let &cpo = s:cpo_save
unlet s:cpo_save
