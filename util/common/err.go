package common

import (
	"errors"
	"fmt"
	"x-ui/logger"
)

var CtxDone = errors.New("context done")

func NewErrorf(format string, a ...any) error {
	msg := fmt.Sprintf(format, a...)
	return errors.New(msg)
}

func NewError(a ...any) error {
	msg := fmt.Sprintln(a...)
	return errors.New(msg)
}

func Recover(msg string) any {
	panicErr := recover()
	if panicErr != nil {
		if msg != "" {
			logger.Error(msg, "panic:", panicErr)
		}
	}
	return panicErr
}
