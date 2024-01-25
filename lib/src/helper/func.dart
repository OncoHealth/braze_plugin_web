// ignore_for_file: require_trailing_commas
// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs
// adopted: Dmytro Diachenko @followthemoney1.

typedef Func0<R> = R Function();
// ignore: public_member_api_docs
typedef Func1<A, R> = R Function(A a);
// ignore: public_member_api_docs
typedef Func3<A, B, C, R> = R Function(A a, B b, C c);
// ignore: public_member_api_docs
typedef Func2Opt1<A, B, R> = R Function(A a, [B? b]);
