package persistencia;

import java.io.File;
import java.util.List;

import classes.Funcionario;

import com.google.gson.reflect.TypeToken;

/** Persistência de Funcionario no arquivo funcionarios.json (incluir, alterar, excluir e listar herdados). */
public class FuncionarioDAO extends RepositorioJson<Funcionario> {

    public FuncionarioDAO(String pastaDados) {
        super(pastaDados + File.separator + "funcionarios.json", new TypeToken<List<Funcionario>>() { }.getType());
    }
}
