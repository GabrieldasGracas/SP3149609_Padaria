package persistencia;

/** Toda entidade que pode ser gravada no JSON precisa ter um id. */
public interface Identificavel {
    int getId();
    void setId(int id);
}
