/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.IProductDAO;
import dal.IWishlistDAO;
import dal.imp.CartDAO;
import dal.imp.ProductDAO;
import dal.imp.WishlistDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.User;
import model.WishlistItem;

/**
 *
 * @author nguye
 */
@WebServlet(name="WishlistController", urlPatterns={"/wishlist", "/addWishlist"})
public class WishlistController extends HttpServlet {
    IWishlistDAO wishlistDAO = new WishlistDAO();
    IProductDAO productDAO = new ProductDAO();
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        if (request.getServletPath().equals("/getWishlist")) {
            getWishlistItem(request, response);
        } else if (request.getServletPath().equals("/addWishlist")) {
            addWishlistItem(request, response);
        } else {
            request.getRequestDispatcher("/home").forward(request, response);
        }
    } 
    
    protected void getWishlistItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            // Nếu user chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getUserId();
        List<WishlistItem> listCartItem = wishlistDAO.getWishlistItems(userId);
        request.setAttribute("listWishlistItem", listCartItem);
        request.getRequestDispatcher("wishlist").forward(request, response);
    }
    
    protected void addWishlistItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productID"));
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user"); // Giả sử bạn đã lưu userId trong session
        // Thêm sản phẩm vào giỏ hàng
        if (user == null) {
            // Nếu user chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getUserId();
        wishlistDAO.addWishlistItem(userId, productId);
        List<WishlistItem> updatedWishlist = wishlistDAO.getWishlistItems(userId);
        updateWishlistInSession(request, updatedWishlist);
        request.getRequestDispatcher("wishlist").forward(request, response);
    }
    
    public void updateWishlistInSession(HttpServletRequest request, List<WishlistItem> updatedWishlist) {
        HttpSession session = request.getSession();
        session.setAttribute("wishlist", updatedWishlist);
    }
    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        if (request.getServletPath().equals("/wishlist")) {
            getWishlistItem(request, response);
        } else if (request.getServletPath().equals("/addCart")) {
            addWishlistItem(request, response);
        } else {
            request.getRequestDispatcher("/home").forward(request, response);
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    
}
