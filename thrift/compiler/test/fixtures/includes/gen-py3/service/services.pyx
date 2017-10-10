#
# Autogenerated by Thrift
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#  @generated
#

from libcpp.memory cimport shared_ptr, make_shared, unique_ptr, make_unique
from libcpp.string cimport string
from libcpp cimport bool as cbool
from cpython cimport bool as pbool
from libc.stdint cimport int8_t, int16_t, int32_t, int64_t
from libcpp.vector cimport vector
from libcpp.set cimport set as cset
from libcpp.map cimport map as cmap
from cython.operator cimport dereference as deref
from cpython.ref cimport PyObject
from thrift.py3.exceptions cimport cTApplicationException
from thrift.py3.server cimport ServiceInterface, RequestContext, Cpp2RequestContext
from thrift.py3.server import RequestContext
from folly cimport (
  cFollyPromise,
  cFollyUnit,
  c_unit
)

cimport folly.futures
from folly.executor cimport get_executor

cimport service.types
import service.types
import module.types
cimport module.types
import includes.types
cimport includes.types

import asyncio
import functools
import sys
import traceback

from service.services_wrapper cimport cMyServiceInterface


cdef extern from "<utility>" namespace "std":
    cdef cFollyPromise[unique_ptr[string]] move(cFollyPromise[unique_ptr[string]])
    cdef cFollyPromise[cFollyUnit] move(
        cFollyPromise[cFollyUnit])

cdef class Promise_void:
    cdef cFollyPromise[cFollyUnit] cPromise

    @staticmethod
    cdef create(cFollyPromise[cFollyUnit] cPromise):
        inst = <Promise_void>Promise_void.__new__(Promise_void)
        inst.cPromise = move(cPromise)
        return inst

cdef class MyServiceInterface(
    ServiceInterface
):
    def __cinit__(self):
        self.interface_wrapper = cMyServiceInterface(
            <PyObject *> self,
            get_executor()
        )

    async def query(
            self,
            s,
            i):
        raise NotImplementedError("async def query is not implemented")


    async def has_arg_docs(
            self,
            s,
            i):
        raise NotImplementedError("async def has_arg_docs is not implemented")




cdef api void call_cy_MyService_query(
    object self,
    Cpp2RequestContext* ctx,
    cFollyPromise[cFollyUnit] cPromise,
    unique_ptr[module.types.cMyStruct] s,
    unique_ptr[includes.types.cIncluded] i
):
    cdef MyServiceInterface iface
    iface = self
    __promise = Promise_void.create(move(cPromise))
    arg_s = module.types.MyStruct.create(shared_ptr[module.types.cMyStruct](s.release()))
    arg_i = includes.types.Included.create(shared_ptr[includes.types.cIncluded](i.release()))
    __context = None
    if iface._pass_context_query:
        __context = RequestContext.create(ctx)
    asyncio.get_event_loop().create_task(
        MyService_query_coro(
            self,
            __context,
            __promise,
            arg_s,
            arg_i
        )
    )

async def MyService_query_coro(
    object self,
    object ctx,
    Promise_void promise,
    s,
    i
):
    try:
        if ctx is not None:
            result = await self.query(ctx,
                      s,
                      i)
        else:
            result = await self.query(
                      s,
                      i)
    except Exception as ex:
        print(
            "Unexpected error in service handler query:",
            file=sys.stderr)
        traceback.print_exc()
        promise.cPromise.setException(cTApplicationException(
            repr(ex).encode('UTF-8')
        ))
    else:
        promise.cPromise.setValue(c_unit)

cdef api void call_cy_MyService_has_arg_docs(
    object self,
    Cpp2RequestContext* ctx,
    cFollyPromise[cFollyUnit] cPromise,
    unique_ptr[module.types.cMyStruct] s,
    unique_ptr[includes.types.cIncluded] i
):
    cdef MyServiceInterface iface
    iface = self
    __promise = Promise_void.create(move(cPromise))
    arg_s = module.types.MyStruct.create(shared_ptr[module.types.cMyStruct](s.release()))
    arg_i = includes.types.Included.create(shared_ptr[includes.types.cIncluded](i.release()))
    __context = None
    if iface._pass_context_has_arg_docs:
        __context = RequestContext.create(ctx)
    asyncio.get_event_loop().create_task(
        MyService_has_arg_docs_coro(
            self,
            __context,
            __promise,
            arg_s,
            arg_i
        )
    )

async def MyService_has_arg_docs_coro(
    object self,
    object ctx,
    Promise_void promise,
    s,
    i
):
    try:
        if ctx is not None:
            result = await self.has_arg_docs(ctx,
                      s,
                      i)
        else:
            result = await self.has_arg_docs(
                      s,
                      i)
    except Exception as ex:
        print(
            "Unexpected error in service handler has_arg_docs:",
            file=sys.stderr)
        traceback.print_exc()
        promise.cPromise.setException(cTApplicationException(
            repr(ex).encode('UTF-8')
        ))
    else:
        promise.cPromise.setValue(c_unit)

