package org.renjin.gcc.codegen.var;

import com.google.common.base.Optional;
import org.objectweb.asm.MethodVisitor;
import org.objectweb.asm.Opcodes;
import org.renjin.gcc.codegen.RecordClassGenerator;
import org.renjin.gcc.codegen.expr.AbstractExprGenerator;
import org.renjin.gcc.codegen.expr.ExprGenerator;
import org.renjin.gcc.codegen.expr.NullPtrGenerator;
import org.renjin.gcc.gimple.type.GimplePointerType;
import org.renjin.gcc.gimple.type.GimpleType;


public class AddressableRecordPtrVarGenerator extends AbstractExprGenerator implements VarGenerator {

  private RecordClassGenerator generator;
  private int varIndex;

  public AddressableRecordPtrVarGenerator(RecordClassGenerator generator, int varIndex) {
    this.generator = generator;
    this.varIndex = varIndex;
  }

  @Override
  public void emitDefaultInit(MethodVisitor mv, Optional<ExprGenerator> initialValue) {
    
    // allocate a unit array so that we can provide an "address" for this pointer
    mv.visitInsn(Opcodes.ICONST_1);
    mv.visitTypeInsn(Opcodes.ANEWARRAY, generator.getType().getInternalName());
    mv.visitVarInsn(Opcodes.ASTORE, varIndex);
    
    if(initialValue.isPresent()) {
      if(initialValue.get() instanceof NullPtrGenerator) {
        // array values already initialized to zero by VM
        
      } else {
        throw new UnsupportedOperationException("initialValue: " + initialValue);
      }
    }
  }

  @Override
  public void emitPushRecordRef(MethodVisitor mv) {
    mv.visitVarInsn(Opcodes.ALOAD, varIndex);
    mv.visitInsn(Opcodes.ICONST_0);
    mv.visitInsn(Opcodes.AALOAD);
  }

  @Override
  public void emitStore(MethodVisitor mv, ExprGenerator valueGenerator) {
    mv.visitVarInsn(Opcodes.ALOAD, varIndex);
    mv.visitInsn(Opcodes.ICONST_0);
    valueGenerator.emitPushRecordRef(mv);
    mv.visitInsn(Opcodes.AASTORE);
  }

  @Override
  public GimpleType getGimpleType() {
    return generator.getGimpleType();
  }

  @Override
  public ExprGenerator addressOf() {
    return new AddressExpr();
  }

  @Override
  public void emitPushPtrArrayAndOffset(MethodVisitor mv) {
    mv.visitVarInsn(Opcodes.ALOAD, varIndex);
    mv.visitInsn(Opcodes.ICONST_0);
    mv.visitInsn(Opcodes.AALOAD);
  }

  private class AddressExpr extends AbstractExprGenerator {


    @Override
    public GimpleType getGimpleType() {
      return new GimplePointerType(generator.getGimpleType());
    }

    @Override
    public void emitPushPtrArrayAndOffset(MethodVisitor mv) {
      mv.visitVarInsn(Opcodes.ALOAD, varIndex);
      mv.visitInsn(Opcodes.ICONST_0);
    }
  }
  
}