import com.opensymphony.xwork2.ActionSupport;
import db.School.EEntity;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

public class InputScore extends ActionSupport {
    private static final SessionFactory ourSessionFactory;
    private String[] content;

    static {
        try {
            ourSessionFactory = new Configuration().
                    configure("hibernate.cfg.xml").
                    buildSessionFactory();
        } catch (Throwable ex) {
            throw new ExceptionInInitializerError(ex);
        }
    }

    private static Session getSession() throws HibernateException {
        return ourSessionFactory.openSession();
    }

    @Override
    public String execute() throws Exception {
        try {
            Session session = getSession();
            for (int i = 0; i < content.length; i += 7) {
                Transaction transaction = session.beginTransaction();
                EEntity e = new EEntity();
                e.setXh(content[i]);
                e.setXq(content[i + 1]);
                e.setKh(content[i + 2]);
                e.setGh(content[i + 3]);
                e.setPscj(content[i + 4].equals("") ? null : Integer.parseInt(content[i + 4]));
                e.setKscj(content[i + 5].equals("") ? null : Integer.parseInt(content[i + 5]));
                e.setZpcj(content[i + 6].equals("") ? null : Integer.parseInt(content[i + 6]));
                session.update(e);
                transaction.commit();
            }
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "failed";
        }
    }

    public String[] getContent() {
        return content;
    }

    public void setContent(String[] content) {
        this.content = content;
    }
}
