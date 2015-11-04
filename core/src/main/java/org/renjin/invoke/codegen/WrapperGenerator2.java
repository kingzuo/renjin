package org.renjin.invoke.codegen;

import com.google.common.base.Charsets;
import com.google.common.io.Files;
import com.sun.codemodel.CodeWriter;
import com.sun.codemodel.JCodeModel;
import com.sun.codemodel.JPackage;
import org.renjin.invoke.annotations.CastStyle;
import org.renjin.invoke.model.JvmMethod;
import org.renjin.invoke.model.PrimitiveModel;
import org.renjin.primitives.Primitives;
import org.renjin.primitives.Primitives.Entry;

import javax.tools.*;
import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/**
 * 
 * Generates wrapper classes for primitive functions. This generator
 * supercedes {@link WrapperGenerator2},
 *
 */
public class WrapperGenerator2 {

  public static void main(String[] args) throws IOException {
    
    File baseDir = new File("");

    WrapperGenerator2 generator = new WrapperGenerator2(baseDir);
    
    if(args.length > 0) {
      generator.setSingleFunction(args[0]);
    }
    generator.generate();
    System.exit(generator.isSuccessful() ? 0 : 1);
  }
  
  private File sourcesDir;
  private File outputDir;
  private String singleFunction;
  
  private boolean encounteredError = false;
  
  private List<JavaFileObject> compilationUnits = new ArrayList<JavaFileObject>();
  
  public WrapperGenerator2(File baseDir) {
    sourcesDir = new File(baseDir.getAbsoluteFile() + File.separator + "target" + File.separator + "generated-sources" + File.separator +
        "r-wrappers" + File.separator);
    sourcesDir.mkdirs();

    outputDir = new File(baseDir.getAbsoluteFile() + File.separator + "target" + File.separator + "classes");

  }

  public void setSingleFunction(String name) {
    this.singleFunction = name;
  }
  
  public void generate() throws IOException {
    generateSources();
    compile();
  }

  public boolean isSuccessful() {
    return !encounteredError;
  }
  
  private void generateSources()
      throws IOException {

    int implementedCount = 0;

    JCodeModel codeModel = new JCodeModel();

    List<Entry> entries = Primitives.getEntries();
    for(Entry entry : entries) {
      if(singleFunction == null || singleFunction.equals(entry.name)) {
        List<JvmMethod> overloads = JvmMethod.findOverloads(entry.functionClass, entry.name, entry.methodName);

        if(overloads.isEmpty() && entry.functionClass != null) {
          System.err.println("WARNING: Can't find " + entry.functionClass.getName() + "." +
              (entry.methodName == null ? entry.name : entry.methodName));
        }

        if(!overloads.isEmpty()) {
          generate(codeModel, new PrimitiveModel(entry, overloads));
          implementedCount ++;
        }

        for(JvmMethod method : overloads) {
          if(implicitIntCasting(method)) {
            System.out.println("IMPLICIT INT CASTING: " + method);
          }
        }
      }
    }

    codeModel.build(new CodeWriter() {
      @Override
      public Writer openSource(JPackage pkg, String fileName) throws IOException {
        File pkgDir = new File(sourcesDir, pkg.name().replace('.', '/'));
        pkgDir.mkdirs();

        File sourceFile = new File(pkgDir, fileName);
        compilationUnits.add(new WrapperSource(sourceFile));
        return new FileWriter(sourceFile);
      }

      @Override
      public OutputStream openBinary(JPackage jPackage, String s) throws IOException {
        throw new UnsupportedOperationException();
      }

      @Override
      public void close() throws IOException {
      }
    });

    System.out.println("Total primitives: " + entries.size());
    System.out.println("   % Implemented: " + ((double)implementedCount / entries.size() * 100d) + "%");
  }

  private boolean implicitIntCasting(JvmMethod method) {
    for(JvmMethod.Argument arg : method.getFormals()) {
      if(arg.getClazz().equals(int.class) && arg.getCastStyle() == CastStyle.IMPLICIT) {
        return true;
      }
    }
    return false;
  }

  private void generate(JCodeModel codeModel, PrimitiveModel primitive) throws IOException {
    try {
      InvokerGenerator generator = new InvokerGenerator(codeModel);
      generator.generate(primitive);

    } catch(Exception e) {
      System.err.println("Error generating wrapper for '" + primitive.getName() + "': " + e.getMessage());
      System.err.println("Overloads defined:");
      for(JvmMethod method : primitive.getOverloads()) {
        System.err.println("  " + method.toString());
      }
      encounteredError = true;
      e.printStackTrace();
    }
  }

  private static class WrapperSource extends SimpleJavaFileObject {
    
    private File file;
    
    public WrapperSource(File file) {
      super(file.toURI(), JavaFileObject.Kind.SOURCE);
      this.file = file;
    }

    @Override
    public CharSequence getCharContent(boolean ignoreEncodingErrors)
        throws IOException {
      return Files.toString(file, Charsets.UTF_8);
    }
  }

  public void compile() throws IOException {

    JavaCompiler compiler = ToolProvider.getSystemJavaCompiler();
    DiagnosticCollector<JavaFileObject> diagnostics = new DiagnosticCollector<JavaFileObject>();
    StandardJavaFileManager jfm = compiler.getStandardFileManager(diagnostics, null, null);
    jfm.setLocation(StandardLocation.CLASS_OUTPUT, Collections.singleton(outputDir));
    JavaCompiler.CompilationTask task = compiler.getTask(
        null, // Writer out
        jfm,
        diagnostics,
        Arrays.asList("-g", "-source", "1.6", "-target", "1.6"),
        null, // Iterable<String> classes
        compilationUnits);

    boolean success = task.call();

    if(!success) {
      System.err.println("Compilation failed: ");
      for(Diagnostic<? extends JavaFileObject> d : diagnostics.getDiagnostics()) {
        System.err.println(d.toString());
      }
      encounteredError = true;
    }
    
    jfm.close();
  }

}
