package persistencia;

import java.io.File;
import java.util.List;

import classes.Produto;

import com.google.gson.reflect.TypeToken;

/** Persistência de Produto no arquivo produtos.json (incluir, alterar, excluir e listar herdados). */
public class ProdutoDAO extends RepositorioJson<Produto> {

    public ProdutoDAO(String pastaDados) {
        super(pastaDados + File.separator + "produtos.json", new TypeToken<List<Produto>>() { }.getType());
    }
}
