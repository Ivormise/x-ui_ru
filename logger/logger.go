package logger

import (
	"github.com/op/go-logging"
	"os"
)

var logger *logging.Logger

func init() {
	InitLogger(logging.INFO)
}

func InitLogger(level logging.Level) {
	format := logging.MustStringFormatter(
		`%{time:2006/01/02 15:04:05} %{level} - %{message}`,
	)
	newLogger := logging.MustGetLogger("x-ui")
	backend := logging.NewLogBackend(os.Stderr, "", 0)
	backendFormatter := logging.NewBackendFormatter(backend, format)
	backendLeveled := logging.AddModuleLevel(backendFormatter)
	backendLeveled.SetLevel(level, "")
	newLogger.SetBackend(backendLeveled)

	logger = newLogger
}

func Debug(args ...any) {
	logger.Debug(args...)
}

func Debugf(format string, args ...any) {
	logger.Debugf(format, args...)
}

func Info(args ...any) {
	logger.Info(args...)
}

func Infof(format string, args ...any) {
	logger.Infof(format, args...)
}

func Warning(args ...any) {
	logger.Warning(args...)
}

func Warningf(format string, args ...any) {
	logger.Warningf(format, args...)
}

func Error(args ...any) {
	logger.Error(args...)
}

func Errorf(format string, args ...any) {
	logger.Errorf(format, args...)
}
