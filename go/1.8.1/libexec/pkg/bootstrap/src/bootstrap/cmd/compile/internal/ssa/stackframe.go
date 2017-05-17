// Do not edit. Bootstrap copy of /tmp/go-20170517-18751-tjx0zu/go/src/cmd/compile/internal/ssa/stackframe.go

//line /tmp/go-20170517-18751-tjx0zu/go/src/cmd/compile/internal/ssa/stackframe.go:1
// Copyright 2016 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package ssa

// stackframe calls back into the frontend to assign frame offsets.
func stackframe(f *Func) {
	f.Config.fe.AllocFrame(f)
}
