package controller;

import dal.imp.ReviewsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Reviews;
import org.json.JSONObject;

@WebServlet(name = "ReviewsController", urlPatterns = {"/getAllReviews", "/updateReviewStatus"})
public class ReviewsController extends HttpServlet {
    private final ReviewsDAO reviewsDAO = new ReviewsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getServletPath().equals("/getAllReviews")) {
            getAllReviews(request, response);
        } else {
            request.getRequestDispatcher("/home").forward(request, response);
        }
    }

    protected void getAllReviews(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Reviews> listReviews = reviewsDAO.getAllReviews();
        if (listReviews == null) {
            listReviews = new ArrayList<>(); // Đảm bảo danh sách không bị null
        }
        request.setAttribute("reviews", listReviews);
        request.getRequestDispatcher("allReviewsList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String action = request.getServletPath();

        if ("/updateReviewStatus".equals(action)) {
            try {
                int reviewID = Integer.parseInt(request.getParameter("reviewID"));
                boolean status = Boolean.parseBoolean(request.getParameter("status"));

                boolean success = reviewsDAO.updateReviewStatus(reviewID, status);
                
                out.print("{\"success\": " + success + "}");
            } catch (Exception e) {
                e.printStackTrace();
                out.print("{\"success\": false}");
            }
        }

}
}
