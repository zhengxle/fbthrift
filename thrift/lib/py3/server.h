/*
 * Copyright 2018-present Facebook, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#pragma once

#include <Python.h>
#include <folly/Executor.h>
#include <folly/Function.h>
#include <folly/ScopeGuard.h>
#include <thrift/lib/cpp/server/TServer.h>

namespace thrift {
namespace py3 {
using AddressHandler = folly::Function<void(folly::SocketAddress)>;

template <class Ret, class... Args>
folly::Function<Ret(Args...)> object_partial(
    Ret (*func)(PyObject*, Args...),
    PyObject* py_object) {
  Py_INCREF(py_object);
  auto guard = folly::makeGuard([=] { Py_DECREF(py_object); });
  return [func, py_object, guard = std::move(guard)](Args... args) mutable {
    func(py_object, std::forward<Args>(args)...);
  };
}

class Py3ServerEventHandler
    : public apache::thrift::server::TServerEventHandler {
 public:
  explicit Py3ServerEventHandler(
      folly::Executor* executor,
      AddressHandler address_handler)
      : executor_(executor), address_handler_(std::move(address_handler)) {}

  void preServe(const folly::SocketAddress* address) {
    executor_->add([addr = *address, this]() mutable {
      address_handler_(std::move(addr));
    });
  }

 private:
  folly::Executor* executor_;
  AddressHandler address_handler_;
};

} // namespace py3
} // namespace thrift
