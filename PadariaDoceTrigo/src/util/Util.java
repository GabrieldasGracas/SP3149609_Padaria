package util;

import java.util.Locale;

/** Funções auxiliares usadas pelas páginas JSP (validação e formatação). */
public class Util {

    private static final Locale BR = new Locale("pt", "BR");

    private Util() { }

    /** Escapa caracteres especiais de HTML para exibir texto com segurança. */
    public static String esc(Object valor) {
        if (valor == null) {
            return "";
        }
        return valor.toString()
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }

    /** Remove espaços das pontas; null vira texto vazio. */
    public static String texto(String s) {
        return s == null ? "" : s.trim();
    }

    /** Converte para int; devolve null se o texto não for um inteiro válido. */
    public static Integer paraInt(String s) {
        try {
            return Integer.valueOf(texto(s));
        } catch (NumberFormatException e) {
            return null;
        }
    }

    /** Converte para double aceitando vírgula ou ponto (ex.: "4,50" ou "4.50"); null se inválido. */
    public static Double paraDouble(String s) {
        String t = texto(s);
        if (t.isEmpty()) {
            return null;
        }
        if (t.contains(",")) {
            t = t.replace(".", "").replace(",", ".");
        }
        try {
            double v = Double.parseDouble(t);
            if (Double.isNaN(v) || Double.isInfinite(v)) {
                return null;
            }
            return v;
        } catch (NumberFormatException e) {
            return null;
        }
    }

    /** Formata como moeda: R$ 4,50. */
    public static String moeda(double valor) {
        return String.format(BR, "R$ %,.2f", valor);
    }

    /** Formata para preencher um campo de formulário: 4,50. */
    public static String decimalParaCampo(double valor) {
        return String.format(BR, "%.2f", valor);
    }

    public static String soDigitos(String s) {
        return texto(s).replaceAll("\\D", "");
    }

    public static boolean emailValido(String s) {
        return texto(s).matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$");
    }

    /** Mensagens aceitas na URL (?msg=...) após salvar ou excluir. */
    public static String mensagem(String codigo) {
        if ("salvo".equals(codigo)) {
            return "Registro salvo com sucesso.";
        }
        if ("excluido".equals(codigo)) {
            return "Registro excluído com sucesso.";
        }
        return null;
    }
}
