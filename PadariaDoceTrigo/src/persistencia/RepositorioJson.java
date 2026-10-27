package persistencia;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.Writer;
import java.lang.reflect.Type;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Base de persistência: lê e grava uma lista de objetos em um arquivo JSON
 * usando a Gson (fromJson / toJson). Nenhum JSON é montado "na mão".
 * Operações: listar, buscarPorId, incluir, alterar e excluir.
 */
public abstract class RepositorioJson<T extends Identificavel> {

    private final File arquivo;
    private final Type tipoLista;
    private final Gson gson = new GsonBuilder().setPrettyPrinting().create();

    protected RepositorioJson(String caminhoArquivo, Type tipoLista) {
        this.arquivo = new File(caminhoArquivo);
        this.tipoLista = tipoLista;
    }

    /** Carrega todos os registros do arquivo (lista vazia se o arquivo não existir). */
    public synchronized List<T> listar() {
        if (!arquivo.exists()) {
            return new ArrayList<T>();
        }
        try (Reader leitor = new InputStreamReader(new FileInputStream(arquivo), StandardCharsets.UTF_8)) {
            List<T> lista = gson.fromJson(leitor, tipoLista);
            return lista == null ? new ArrayList<T>() : lista;
        } catch (IOException e) {
            throw new RuntimeException("Não foi possível ler o arquivo " + arquivo.getName() + ".", e);
        }
    }

    public synchronized T buscarPorId(int id) {
        for (T item : listar()) {
            if (item.getId() == id) {
                return item;
            }
        }
        return null;
    }

    /** Inclui um novo registro, gerando o próximo id disponível. */
    public synchronized T incluir(T novo) {
        List<T> lista = listar();
        int maior = 0;
        for (T item : lista) {
            maior = Math.max(maior, item.getId());
        }
        novo.setId(maior + 1);
        lista.add(novo);
        salvar(lista);
        return novo;
    }

    /** Substitui o registro de mesmo id. Retorna false se ele não existir. */
    public synchronized boolean alterar(T alterado) {
        List<T> lista = listar();
        for (int i = 0; i < lista.size(); i++) {
            if (lista.get(i).getId() == alterado.getId()) {
                lista.set(i, alterado);
                salvar(lista);
                return true;
            }
        }
        return false;
    }

    /** Remove o registro com o id informado. Retorna false se ele não existir. */
    public synchronized boolean excluir(int id) {
        List<T> lista = listar();
        boolean removido = false;
        for (int i = 0; i < lista.size(); i++) {
            if (lista.get(i).getId() == id) {
                lista.remove(i);
                removido = true;
                break;
            }
        }
        if (removido) {
            salvar(lista);
        }
        return removido;
    }

    private void salvar(List<T> lista) {
        File pasta = arquivo.getParentFile();
        if (pasta != null && !pasta.exists()) {
            pasta.mkdirs();
        }
        try (Writer escritor = new OutputStreamWriter(new FileOutputStream(arquivo), StandardCharsets.UTF_8)) {
            gson.toJson(lista, tipoLista, escritor);
        } catch (IOException e) {
            throw new RuntimeException("Não foi possível gravar o arquivo " + arquivo.getName() + ".", e);
        }
    }
}
