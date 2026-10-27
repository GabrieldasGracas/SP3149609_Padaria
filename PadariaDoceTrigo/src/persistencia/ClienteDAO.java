package persistencia;

import java.io.File;
import java.util.List;

import classes.Cliente;

import com.google.gson.reflect.TypeToken;

/** Persistência de Cliente no arquivo clientes.json (incluir, alterar, excluir e listar herdados). */
public class ClienteDAO extends RepositorioJson<Cliente> {

    public ClienteDAO(String pastaDados) {
        super(pastaDados + File.separator + "clientes.json", new TypeToken<List<Cliente>>() { }.getType());
    }
}
