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
  auto module = new Module("if.c");
  auto builder = new IRBuilder(nullptr, module);
  Type *Int32Type = Type::get_int32_type(module);  
  Type *FloatType = Type::get_float_type(module);
  
  // intialize main()
  auto mainFun = Function::create(FunctionType::get(Int32Type, {}),"main", module);
  auto bb = BasicBlock::create(module, "entry", mainFun);
  builder->set_insert_point(bb);
  
  // intialize a=10,i=0;
  auto aAlloca = builder->create_alloca(Int32Type);
  auto iAlloca = builder->create_alloca(Int32Type);
  builder->create_store(CONST_INT(10),aAlloca);
  builder->create_store(CONST_INT(0),iAlloca);
  
  // while(i<10)
  auto loopBB = BasicBlock::create(module,"loop",mainFun);
  auto blockBB = BasicBlock::create(module,"block",mainFun);
  auto retBB = BasicBlock::create(module,"ret",mainFun);
  builder->create_br(loopBB);
  
  // loop
  builder->set_insert_point(loopBB);
  auto iLoad = builder->create_load(iAlloca);
  auto icmp = builder->create_icmp_lt(iLoad,CONST_INT(10));
  auto br = builder->create_cond_br(icmp,blockBB,retBB);
  
  // block
  builder->set_insert_point(blockBB);
  auto ans = builder->create_iadd(iLoad,CONST_INT(1));
  builder->create_store(ans,iAlloca);
  auto aLoad = builder->create_load(aAlloca);
  iLoad = builder->create_load(iAlloca);
  ans = builder->create_iadd(aLoad,iLoad);
  builder->create_store(ans,aAlloca);
  builder->create_br(loopBB);
  
  // ret
  builder->set_insert_point(retBB);
  aLoad = builder->create_load(aAlloca);
  builder->create_ret(aLoad);
  
  std::cout << module->print();
  delete module;
  return 0;
}