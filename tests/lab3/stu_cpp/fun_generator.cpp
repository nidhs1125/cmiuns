#include "BasicBlock.h"
#include "Constant.h"
#include "Function.h"
#include "IRBuilder.h"
#include "Module.h"
#include "Type.h"

#include <iostream>
#include <memory>

#ifdef DEBUG
#define DEBUG_OUTPUT std::cout << __LINE__ << std::endl;
#else
#define DEBUG_OUTPUT
#endif

#define CONST_INT(num) \
    ConstantInt::get(num, module)

#define CONST_FP(num) \
    ConstantFP::get(num, module)

int main() {
  auto module = new Module("fun.c");
  auto builder = new IRBuilder(nullptr, module);
  Type *Int32Type = Type::get_int32_type(module);
  
  // initialize callee
  std::vector<Type *> paramater(1,Int32Type);
  auto calleeFunTy=FunctionType::get(Int32Type,paramater);
  auto calleeFun=Function::create(calleeFunTy,"callee",module);
  
  auto bb=BasicBlock::create(module,"entry",calleeFun);
  builder->set_insert_point(bb);
  
  //alloc memory for a
  auto aAlloca=builder->create_alloca(Int32Type);
  //aAlloca=a
  std::vector<Value *> args;
  for(auto arg=calleeFun->arg_begin();arg!=calleeFun->arg_end();arg++){
    args.push_back(*arg);
  }
  builder->create_store(args[0],aAlloca);
  
  //calculate r=2*a
  auto rAlloca=builder->create_alloca(Int32Type);
  auto aLoad=builder->create_load(aAlloca);
  auto mul=builder->create_imul(CONST_INT(2),aLoad);
  builder->create_store(mul,rAlloca);
  auto rLoad=builder->create_load(rAlloca);
  builder->create_ret(rLoad);
  
  //intialize main()
  auto mainFun = Function::create(FunctionType::get(Int32Type, {}),"main", module);
  bb = BasicBlock::create(module, "entry", mainFun);
  builder->set_insert_point(bb);
  //call callee
  auto call=builder->create_call(calleeFun,{CONST_INT(110)});
  builder->create_ret(call);
  
  std::cout << module->print();
  delete module;
  return 0;
}