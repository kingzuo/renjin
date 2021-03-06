#
# Renjin : JVM-based interpreter for the R language for the statistical analysis
# Copyright © 2010-2018 BeDataDriven Groep B.V. and contributors
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, a copy is available at
# https://www.gnu.org/licenses/gpl-2.0.txt
#

library(grDevices)
library(graphics)
library(hamcrest)


grDevices::png()
grDevices::dev.control(displaylist = "enable")
plot(x = 1, y = 2)
g1 <- grDevices::recordPlot()
invisible(dev.off)

grDevices::png()
grDevices::dev.control(displaylist = "inhibit")
plot(x = 1, y = 2)
g2 <- grDevices::recordPlot()
invisible(dev.off)


       test.recordplot.01 = function() { assertThat(g2[[1]], identicalTo(NULL)) }
       test.recordplot.02 = function() { assertThat(class(g2[[2]]), identicalTo("raw")) }
       test.recordplot.03 = function() { assertThat(length(g1[[2]]), identicalTo(length(g2[[2]]))) }
       test.recordplot.04 = function() { assertTrue(typeof(g1[[1]]) == "pairlist") }
       test.recordplot.05 = function() { assertTrue(length(g1[[1]]) == 8L) }

ignore.test.recordplot.06 = function() { assertThat(class( g1[[1]][[1]][[1]]),                identicalTo("function")) }
ignore.test.recordplot.07 = function() { assertThat(class( g1[[1]][[1]][[2]][[1]]),               identicalTo(c("ExternalRoutine","NativeSymbolInfo"))) }
ignore.test.recordplot.08 = function() { assertThat(names( g1[[1]][[1]][[2]][[1]]),               identicalTo(c("name","address","package","numParameters"))) }
ignore.test.recordplot.09 = function() { assertThat(class( g1[[1]][[1]][[2]][[1]]$name),          identicalTo(c("charater"))) }
ignore.test.recordplot.10 = function() { assertThat(       g1[[1]][[1]][[2]][[1]]$name,           identicalTo(c("C_plot_new"))) }
ignore.test.recordplot.11 = function() { assertThat(class( g1[[1]][[1]][[2]][[1]]$address),       identicalTo(c("RegisteredNativeSymbol"))) }
ignore.test.recordplot.12 = function() { assertThat(class( g1[[1]][[1]][[2]][[1]]$package),       identicalTo(c("DLLInfo"))) }
ignore.test.recordplot.13 = function() { assertThat(       g1[[1]][[1]][[2]][[1]]$package[["name"]],           identicalTo(c("graphics"))) }
ignore.test.recordplot.14 = function() { assertThat(       g1[[1]][[1]][[2]][[1]]$package[["dynamicLookup"]],  identicalTo(c(FALSE))) }
ignore.test.recordplot.15 = function() { assertThat( class(g1[[1]][[1]][[2]][[1]]$package[["handle"]]),        identicalTo(c("DLLHandle"))) }
ignore.test.recordplot.16 = function() { assertThat( class(g1[[1]][[1]][[2]][[1]]$package[["info"]]),          identicalTo(c("DLLInfoReference"))) }
ignore.test.recordplot.17 = function() { assertThat(class( g1[[1]][[1]][[2]][[1]]$numParameters), identicalTo(c("integer"))) }
ignore.test.recordplot.18 = function() { assertThat(       g1[[1]][[1]][[2]][[1]]$numParameters,  identicalTo(0L)) }


ignore.test.recordplot.06b = function() { assertThat(class( g1[[1]][[2]][[1]]),                identicalTo("function")) }
ignore.test.recordplot.07b = function() { assertThat(class( g1[[1]][[2]][[2]][[1]]),               identicalTo(c("ExternalRoutine","NativeSymbolInfo"))) }
ignore.test.recordplot.08b = function() { assertThat(names( g1[[1]][[2]][[2]][[1]]),               identicalTo(c("name","address","package","numParameters"))) }
ignore.test.recordplot.09b = function() { assertThat(class( g1[[1]][[2]][[2]][[1]]$name),          identicalTo(c("charater"))) }
ignore.test.recordplot.10b = function() { assertThat(       g1[[1]][[2]][[2]][[1]]$name,           identicalTo(c("C_plot_new"))) }
       test.recordplot.11b = function() { assertThat(class( g1[[1]][[2]][[2]][[1]]$address),       identicalTo(c("RegisteredNativeSymbol"))) }
ignore.test.recordplot.12b = function() { assertThat(class( g1[[1]][[2]][[2]][[1]]$package),       identicalTo(c("DLLInfo"))) }
ignore.test.recordplot.13b = function() { assertThat(       g1[[1]][[2]][[2]][[1]]$package[["name"]],           identicalTo(c("graphics"))) }
ignore.test.recordplot.14b = function() { assertThat(       g1[[1]][[2]][[2]][[1]]$package[["dynamicLookup"]],  identicalTo(c(FALSE))) }
ignore.test.recordplot.15b = function() { assertThat( class(g1[[1]][[2]][[2]][[1]]$package[["handle"]]),        identicalTo(c("DLLHandle"))) }
ignore.test.recordplot.16b = function() { assertThat( class(g1[[1]][[2]][[2]][[1]]$package[["info"]]),          identicalTo(c("DLLInfoReference"))) }
       test.recordplot.17b = function() { assertThat(class( g1[[1]][[2]][[2]][[1]]$numParameters), identicalTo(c("integer"))) }
ignore.test.recordplot.18b = function() { assertThat(       g1[[1]][[2]][[2]][[1]]$numParameters,  identicalTo(0L)) }

ignore.test.recordplot.19 = function() { assertThat(class( g1[[1]][[3]][[1]]),                identicalTo("function")) }
ignore.test.recordplot.20 = function() { assertThat(class( g1[[1]][[3]][[2]][[1]]),           identicalTo(c("CallRoutine", "NativeSymbolInfo"))) }
ignore.test.recordplot.21 = function() { assertThat(names( g1[[1]][[3]][[2]][[1]]),           identicalTo(c("name","address","package","numParameters"))) }
       test.recordplot.22 = function() { assertThat(class( g1[[1]][[3]][[2]][[1]]$name),      identicalTo("character")) }
       test.recordplot.23 = function() { assertThat( g1[[1]][[3]][[2]][[1]]$name,       identicalTo("C_plot_window")) }
       test.recordplot.24 = function() { assertThat(class( g1[[1]][[3]][[2]][[1]]$address),      identicalTo("RegisteredNativeSymbol")) }
ignore.test.recordplot.25 = function() { assertThat(class( g1[[1]][[3]][[2]][[1]]$package),      identicalTo("DLLInfo")) }
ignore.test.recordplot.26 = function() { assertThat(       g1[[1]][[3]][[2]][[1]]$package[["name"]],           identicalTo(c("graphics"))) }
ignore.test.recordplot.27 = function() { assertThat(       g1[[1]][[3]][[2]][[1]]$package[["dynamicLookup"]],  identicalTo(c(FALSE))) }
ignore.test.recordplot.28 = function() { assertThat( class(g1[[1]][[3]][[2]][[1]]$package[["handle"]]),        identicalTo(c("DLLHandle"))) }
ignore.test.recordplot.29 = function() { assertThat( class(g1[[1]][[3]][[2]][[1]]$package[["info"]]),          identicalTo(c("DLLInfoReference"))) }
       test.recordplot.30 = function() { assertThat(class( g1[[1]][[3]][[2]][[1]]$numParameters),      identicalTo("integer")) }
ignore.test.recordplot.31 = function() { assertThat(       g1[[1]][[3]][[2]][[1]]$numParameters,       identicalTo(-1)) }
       test.recordplot.32 = function() { assertThat(       g1[[1]][[3]][[2]][[2]],            identicalTo(c(1, 1))) }
       test.recordplot.33 = function() { assertThat(       g1[[1]][[3]][[2]][[3]],            identicalTo(c(2, 2))) }
       test.recordplot.34 = function() { assertThat(       g1[[1]][[3]][[2]][[4]],            identicalTo("")) }
       test.recordplot.35 = function() { assertThat(       g1[[1]][[3]][[2]][[5]],            identicalTo(NA)) }

ignore.test.recordplot.36 = function() { assertThat(class( g1[[1]][[4]][[1]]),                identicalTo("function")) }
ignore.test.recordplot.37 = function() { assertThat(class( g1[[1]][[4]][[2]][[1]]),           identicalTo(c("CallRoutine", "NativeSymbolInfo"))) }
ignore.test.recordplot.38 = function() { assertThat(names( g1[[1]][[4]][[2]][[1]]),           identicalTo(c("name","address","package","numParameters"))) }
       test.recordplot.39 = function() { assertThat(class( g1[[1]][[4]][[2]][[1]]$name),      identicalTo("character")) }
       test.recordplot.40 = function() { assertThat(       g1[[1]][[4]][[2]][[1]]$name,       identicalTo("C_plotXY")) }
       test.recordplot.41 = function() { assertThat(class( g1[[1]][[4]][[2]][[1]]$address),      identicalTo("RegisteredNativeSymbol")) }
ignore.test.recordplot.42 = function() { assertThat(class( g1[[1]][[4]][[2]][[1]]$package),      identicalTo("DLLInfo")) }
ignore.test.recordplot.43 = function() { assertThat(       g1[[1]][[4]][[2]][[1]]$package[["name"]],           identicalTo(c("graphics"))) }
ignore.test.recordplot.44 = function() { assertThat(       g1[[1]][[4]][[2]][[1]]$package[["dynamicLookup"]],  identicalTo(c(FALSE))) }
ignore.test.recordplot.45 = function() { assertThat( class(g1[[1]][[4]][[2]][[1]]$package[["handle"]]),        identicalTo(c("DLLHandle"))) }
ignore.test.recordplot.46 = function() { assertThat( class(g1[[1]][[4]][[2]][[1]]$package[["info"]]),          identicalTo(c("DLLInfoReference"))) }
       test.recordplot.47 = function() { assertThat(class( g1[[1]][[4]][[2]][[1]]$numParameters),      identicalTo("integer")) }
ignore.test.recordplot.48 = function() { assertThat(       g1[[1]][[4]][[2]][[1]]$numParameters,       identicalTo(-1)) }
       test.recordplot.49 = function() { assertThat(       g1[[1]][[4]][[2]][[2]],            identicalTo(list(x = 1, y = 2, xlab = "1", ylab = "2"))) }
       test.recordplot.50 = function() { assertThat(       g1[[1]][[4]][[2]][[3]],            identicalTo("p")) }
ignore.test.recordplot.51 = function() { assertThat(       g1[[1]][[4]][[2]][[4]],            identicalTo(1)) }
       test.recordplot.52 = function() { assertThat(       g1[[1]][[4]][[2]][[5]],            identicalTo("solid")) }
       test.recordplot.53 = function() { assertThat(       g1[[1]][[4]][[2]][[6]],            identicalTo("black")) }
       test.recordplot.54 = function() { assertThat(       g1[[1]][[4]][[2]][[7]],            identicalTo(NA)) }
       test.recordplot.55 = function() { assertThat(       g1[[1]][[4]][[2]][[8]],            identicalTo(1)) }
       test.recordplot.56 = function() { assertThat(       g1[[1]][[4]][[2]][[9]],            identicalTo(1)) }

ignore.test.recordplot.57 = function() { assertThat(class( g1[[1]][[5]][[1]]),                identicalTo("function")) }
ignore.test.recordplot.58 = function() { assertThat(class( g1[[1]][[5]][[2]][[1]]),           identicalTo(c("CallRoutine", "NativeSymbolInfo"))) }
ignore.test.recordplot.59 = function() { assertThat(names( g1[[1]][[5]][[2]][[1]]),           identicalTo(c("name","address","package","numParameters"))) }
       test.recordplot.60 = function() { assertThat(class( g1[[1]][[5]][[2]][[1]]$name),      identicalTo("character")) }
       test.recordplot.61 = function() { assertThat(       g1[[1]][[5]][[2]][[1]]$name,       identicalTo("C_axis")) }
       test.recordplot.62 = function() { assertThat(class( g1[[1]][[5]][[2]][[1]]$address),      identicalTo("RegisteredNativeSymbol")) }
ignore.test.recordplot.63 = function() { assertThat(class( g1[[1]][[5]][[2]][[1]]$package),      identicalTo("DLLInfo")) }
ignore.test.recordplot.64 = function() { assertThat(       g1[[1]][[5]][[2]][[1]]$package[["name"]],           identicalTo(c("graphics"))) }
ignore.test.recordplot.65 = function() { assertThat(       g1[[1]][[5]][[2]][[1]]$package[["dynamicLookup"]],  identicalTo(c(FALSE))) }
ignore.test.recordplot.66 = function() { assertThat( class(g1[[1]][[5]][[2]][[1]]$package[["handle"]]),        identicalTo(c("DLLHandle"))) }
ignore.test.recordplot.67 = function() { assertThat( class(g1[[1]][[5]][[2]][[1]]$package[["info"]]),          identicalTo(c("DLLInfoReference"))) }
       test.recordplot.68 = function() { assertThat(class( g1[[1]][[5]][[2]][[1]]$numParameters),      identicalTo("integer")) }
ignore.test.recordplot.69 = function() { assertThat(       g1[[1]][[5]][[2]][[1]]$numParameters,       identicalTo(-1)) }
       test.recordplot.70 = function() { assertThat(       g1[[1]][[5]][[2]][[2]],            identicalTo(1)) }
       test.recordplot.71 = function() { assertThat(       g1[[1]][[5]][[2]][[3]],            identicalTo(NULL)) }
       test.recordplot.72 = function() { assertThat(       g1[[1]][[5]][[2]][[4]],            identicalTo(NULL)) }
       test.recordplot.73 = function() { assertThat(       g1[[1]][[5]][[2]][[5]],            identicalTo(TRUE)) }
       test.recordplot.74 = function() { assertThat(       g1[[1]][[5]][[2]][[6]],            identicalTo(NA)) }
       test.recordplot.75 = function() { assertThat(       g1[[1]][[5]][[2]][[7]],            identicalTo(NA)) }
       test.recordplot.76 = function() { assertThat(       g1[[1]][[5]][[2]][[8]],            identicalTo(FALSE)) }
       test.recordplot.77 = function() { assertThat(       g1[[1]][[5]][[2]][[9]],            identicalTo(NA)) }
       test.recordplot.78 = function() { assertThat(       g1[[1]][[5]][[2]][[10]],            identicalTo("solid")) }
       test.recordplot.79 = function() { assertThat(       g1[[1]][[5]][[2]][[11]],            identicalTo(1)) }
       test.recordplot.80 = function() { assertThat(       g1[[1]][[5]][[2]][[12]],            identicalTo(1)) }
       test.recordplot.81 = function() { assertThat(       g1[[1]][[5]][[2]][[13]],            identicalTo(NULL)) }
       test.recordplot.82 = function() { assertThat(       g1[[1]][[5]][[2]][[14]],            identicalTo(NULL)) }
       test.recordplot.83 = function() { assertThat(       g1[[1]][[5]][[2]][[15]],            identicalTo(NA)) }
       test.recordplot.84 = function() { assertThat(       g1[[1]][[5]][[2]][[16]],            identicalTo(NA)) }

ignore.test.recordplot.85 = function() { assertThat(class( g1[[1]][[6]][[1]]),                identicalTo("function")) }
ignore.test.recordplot.86 = function() { assertThat(class( g1[[1]][[6]][[2]][[1]]),           identicalTo(c("CallRoutine", "NativeSymbolInfo"))) }
ignore.test.recordplot.87 = function() { assertThat(names( g1[[1]][[6]][[2]][[1]]),           identicalTo(c("name","address","package","numParameters"))) }
       test.recordplot.88 = function() { assertThat(class( g1[[1]][[6]][[2]][[1]]$name),      identicalTo("character")) }
       test.recordplot.89 = function() { assertThat(       g1[[1]][[6]][[2]][[1]]$name,       identicalTo("C_axis")) }
       test.recordplot.90 = function() { assertThat(class( g1[[1]][[6]][[2]][[1]]$address),      identicalTo("RegisteredNativeSymbol")) }
ignore.test.recordplot.91 = function() { assertThat(class( g1[[1]][[6]][[2]][[1]]$package),      identicalTo("DLLInfo")) }
ignore.test.recordplot.92 = function() { assertThat(       g1[[1]][[6]][[2]][[1]]$package[["name"]], identicalTo(c("graphics"))) }
ignore.test.recordplot.93 = function() { assertThat(       g1[[1]][[6]][[2]][[1]]$package[["dynamicLookup"]], identicalTo(c(FALSE))) }
ignore.test.recordplot.94 = function() { assertThat( class(g1[[1]][[6]][[2]][[1]]$package[["handle"]]), identicalTo(c("DLLHandle"))) }
ignore.test.recordplot.95 = function() { assertThat( class(g1[[1]][[6]][[2]][[1]]$package[["info"]]), identicalTo(c("DLLInfoReference"))) }
       test.recordplot.96 = function() { assertThat(class( g1[[1]][[6]][[2]][[1]]$numParameters), identicalTo("integer")) }
ignore.test.recordplot.97 = function() { assertThat(  g1[[1]][[6]][[2]][[1]]$numParameters, identicalTo(-1)) }
       test.recordplot.98 = function() { assertThat(  g1[[1]][[6]][[2]][[2]], identicalTo(2)) }
       test.recordplot.99 = function() { assertThat(  g1[[1]][[6]][[2]][[3]], identicalTo(NULL)) }
       test.recordplot.100 = function() { assertThat( g1[[1]][[6]][[2]][[4]], identicalTo(NULL)) }
ignore.test.recordplot.101 = function() { assertThat( g1[[1]][[6]][[2]][[5]], identicalTo(TRUE)) }
       test.recordplot.102 = function() { assertThat( g1[[1]][[6]][[2]][[6]], identicalTo(NA)) }
       test.recordplot.103 = function() { assertThat( g1[[1]][[6]][[2]][[7]], identicalTo(NA)) }
       test.recordplot.104 = function() { assertThat( g1[[1]][[6]][[2]][[8]], identicalTo(FALSE)) }
       test.recordplot.105 = function() { assertThat( g1[[1]][[6]][[2]][[9]], identicalTo(NA)) }
       test.recordplot.106 = function() { assertThat( g1[[1]][[6]][[2]][[10]], identicalTo("solid")) }
       test.recordplot.107 = function() { assertThat( g1[[1]][[6]][[2]][[11]], identicalTo(1)) }
       test.recordplot.108 = function() { assertThat( g1[[1]][[6]][[2]][[12]], identicalTo(1)) }
       test.recordplot.109 = function() { assertThat( g1[[1]][[6]][[2]][[13]], identicalTo(NULL)) }
       test.recordplot.110 = function() { assertThat( g1[[1]][[6]][[2]][[14]], identicalTo(NULL)) }
       test.recordplot.111 = function() { assertThat( g1[[1]][[6]][[2]][[15]], identicalTo(NA)) }
       test.recordplot.112 = function() { assertThat(  g1[[1]][[6]][[2]][[16]], identicalTo(NA)) }

ignore.test.recordplot.113 = function() { assertThat(class( g1[[1]][[7]][[1]]), identicalTo("function")) }
ignore.test.recordplot.114 = function() { assertThat(class( g1[[1]][[7]][[2]][[1]]), identicalTo(c("CallRoutine", "NativeSymbolInfo"))) }
ignore.test.recordplot.115 = function() { assertThat(names( g1[[1]][[7]][[2]][[1]]), identicalTo(c("name","address","package","numParameters"))) }
       test.recordplot.116 = function() { assertThat(class( g1[[1]][[7]][[2]][[1]]$name), identicalTo("character")) }
       test.recordplot.117 = function() { assertThat( g1[[1]][[7]][[2]][[1]]$name, identicalTo("C_box")) }
       test.recordplot.118 = function() { assertThat(class( g1[[1]][[7]][[2]][[1]]$address), identicalTo("RegisteredNativeSymbol")) }
ignore.test.recordplot.119 = function() { assertThat(class( g1[[1]][[7]][[2]][[1]]$package), identicalTo("DLLInfo")) }
ignore.test.recordplot.120 = function() { assertThat( g1[[1]][[7]][[2]][[1]]$package[["name"]], identicalTo(c("graphics"))) }
ignore.test.recordplot.121 = function() { assertThat( g1[[1]][[7]][[2]][[1]]$package[["dynamicLookup"]], identicalTo(c(FALSE))) }
ignore.test.recordplot.122 = function() { assertThat( class(g1[[1]][[7]][[2]][[1]]$package[["handle"]]), identicalTo(c("DLLHandle"))) }
ignore.test.recordplot.123 = function() { assertThat( class(g1[[1]][[7]][[2]][[1]]$package[["info"]]), identicalTo(c("DLLInfoReference"))) }
       test.recordplot.124 = function() { assertThat(class( g1[[1]][[7]][[2]][[1]]$numParameters), identicalTo("integer")) }
ignore.test.recordplot.125 = function() { assertThat( g1[[1]][[7]][[2]][[1]]$numParameters, identicalTo(-1L)) }
ignore.test.recordplot.126 = function() { assertThat( g1[[1]][[7]][[2]][[2]], identicalTo(1)) }

ignore.test.recordplot.127 = function() { assertThat(class( g1[[1]][[8]][[1]]), identicalTo("function")) }
ignore.test.recordplot.128 = function() { assertThat(class( g1[[1]][[8]][[2]][[1]]), identicalTo(c("CallRoutine", "NativeSymbolInfo"))) }
ignore.test.recordplot.129 = function() { assertThat(names( g1[[1]][[8]][[2]][[1]]), identicalTo(c("name","address","package","numParameters"))) }
       test.recordplot.130 = function() { assertThat(class( g1[[1]][[8]][[2]][[1]]$name), identicalTo("character")) }
       test.recordplot.131 = function() { assertThat(       g1[[1]][[8]][[2]][[1]]$name, identicalTo("C_title")) }
       test.recordplot.132 = function() { assertThat(class( g1[[1]][[8]][[2]][[1]]$address), identicalTo("RegisteredNativeSymbol")) }
ignore.test.recordplot.133 = function() { assertThat(class( g1[[1]][[8]][[2]][[1]]$package), identicalTo("DLLInfo")) }
ignore.test.recordplot.134 = function() { assertThat(       g1[[1]][[8]][[2]][[1]]$package[["name"]], identicalTo(c("graphics"))) }
ignore.test.recordplot.135 = function() { assertThat(       g1[[1]][[8]][[2]][[1]]$package[["dynamicLookup"]], identicalTo(c(FALSE))) }
ignore.test.recordplot.136 = function() { assertThat( class(g1[[1]][[8]][[2]][[1]]$package[["handle"]]), identicalTo(c("DLLHandle"))) }
ignore.test.recordplot.137 = function() { assertThat( class(g1[[1]][[8]][[2]][[1]]$package[["info"]]), identicalTo(c("DLLInfoReference"))) }
       test.recordplot.138 = function() { assertThat(class( g1[[1]][[8]][[2]][[1]]$numParameters), identicalTo("integer")) }
ignore.test.recordplot.139 = function() { assertThat(       g1[[1]][[8]][[2]][[1]]$numParameters, identicalTo(-1L)) }
       test.recordplot.140 = function() { assertThat(       g1[[1]][[8]][[2]][[2]], identicalTo(NULL)) }
       test.recordplot.141 = function() { assertThat(       g1[[1]][[8]][[2]][[3]], identicalTo(NULL)) }
       test.recordplot.142 = function() { assertThat(       g1[[1]][[8]][[2]][[4]], identicalTo("1")) }
       test.recordplot.143 = function() { assertThat(       g1[[1]][[8]][[2]][[5]], identicalTo("2")) }
       test.recordplot.144 = function() { assertThat(       g1[[1]][[8]][[2]][[6]], identicalTo(NA)) }
       test.recordplot.145 = function() { assertThat(       g1[[1]][[8]][[2]][[7]], identicalTo(FALSE)) }
       test.recordplot.146 = function() { assertThat(g1[[2]], identicalTo(g2[[2]])) }
