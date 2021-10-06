package swp.controller;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
//import com.sun.org.apache.bcel.internal.classfile.Code;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import swp.account.AccountDTO;
import swp.comment.CommentDAO;
import swp.comment.CommentDTO;
import swp.post.PostDAO;
import swp.post.PostDTO;

/**
 *
 * @author macbook
 */
@WebServlet(name = "LoadPostContentServlet", urlPatterns
        = {
            "/LoadPostContentServlet"
        })
public class LoadPostContentServlet extends HttpServlet {

    private static final String SUCCESS = "contentPage";
    private static final String FAIL = "notFoundPage";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        ServletContext context = request.getServletContext();
        Map<String, String> roadmap = (Map<String, String>) context.getAttribute("ROADMAP");
        String url = roadmap.get(FAIL);
        HttpSession session = request.getSession(false);
        try {
            String postId = request.getParameter("postId");
            PostDAO getPost = new PostDAO();
            PostDTO post = getPost.getPostById(postId);
            CommentDAO cmt = new CommentDAO();
            ArrayList<CommentDTO> cmtList = cmt.getAllCommentOfPost(postId);
            if (post != null) {
                url = roadmap.get(SUCCESS);
                AccountDTO acc = (AccountDTO) session.getAttribute("CURRENT_USER");
                String email = acc.getEmail();
                if(getPost.checkLike(postId,email)){
                    request.setAttribute("LIKE_STATUS", "yes");
                }
                request.setAttribute("POST_DETAIL", post);
                request.setAttribute("POST_CMT",cmtList);
            }
        } catch (Exception e) {
            log(e.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
