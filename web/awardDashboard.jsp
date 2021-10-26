<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> <%@page
    contentType="text/html" pageEncoding="UTF-8"%>
    <c:set var="loginStatus" value="${sessionScope.LOGIN}" />
    <c:set var="currentUser" value="${sessionScope.CURRENT_USER}" />
    <c:set var="notify" value="${requestScope.NOTIFY}"/>
    <c:if test="${empty currentUser}">
        <c:redirect url="notFoundPage" />
    </c:if>
    <c:if test="${currentUser.role != 'M'}">
        <c:redirect url="notFoundPage" />
    </c:if>
    <c:set var="awardedError" value="${requestScope.ERROR_AWARDED_ALERT}"/>
    <html lang="en">
        <head>
            <meta charset="UTF-8" />
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <link rel="preconnect" href="https://fonts.googleapis.com" />
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
            <link
                href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap"
                rel="stylesheet"
                />
            <script
                src="https://kit.fontawesome.com/1b1fb57155.js"
                crossorigin="anonymous"
            ></script>
            <link rel="stylesheet" href="./styles/awardDashboard.css" />
            <title>Dashboard | FPT Blog</title>
        </head>
        <body>
            <!-- header  -->
            <!-- header  -->
            <!-- header  -->
            <header>
                <div class="container_header">
                    <div class="container_left">
                        <div class="toggle_sidebar" onclick="toggleSidebarPhone()">
                            <img src="./images/toggle_sidebar_icon.svg" />
                        </div>
                        <div class="container_logo">
                            <a href="loadBlogs">
                                <img
                                    src="https://i.chungta.vn/2017/12/22/LogoFPT-2017-copy-3042-1513928399.jpg"
                                    />
                            </a>
                        </div>
                        <div class="dropdown_category">
                            <div class="container_category">
                                <p>Categories</p>
                            </div>
                            <div class="dropdown_category_content">
                                <c:forEach var="cateDTO" items="${sessionScope.CATEGORY_LIST}">
                                    <div class="dropdown_category_item">
                                        <c:url var="cateLink" value="searchByCategory">
                                            <c:param name="categoryId" value="${cateDTO.ID}" />
                                        </c:url>
                                        <a href="${cateLink}">${cateDTO.name}</a>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="container_searchBar">
                            <form id="searchit" action="searchTitle">
                                <input placeholder="Search..." name="titleValue" />
                                <div class="container_icon" onclick="submit_form()">
                                    <i class="fas fa-search"></i>
                                </div>
                            </form>
                        </div>
                        <script>
                            function submit_form() {
                                var form = document.getElementById("searchit");
                                form.submit();
                            }
                        </script>
                    </div>
                    <div class="container_right">
                        <div class="container_button_register">
                            <button>
                                <a href="loadPendingPosts?postStatus=WFA">Pending Post</a>
                            </button>
                        </div>
                        <div class="icon_notification_container">
                            <img src="./images/notification_icon.svg" />
                        </div>
                        <div class="icon_notification_container">
                            <img src="./images/chat.svg" />
                        </div>
                        <div class="dropdown">
                            <div class="dropbtn">
                                <img src="${currentUser.avatar}" />
                            </div>
                            <div class="dropdown-content">
                                <div class="item-top">
                                    <a
                                        ><h2>${currentUser.name}</h2>
                                        <p>@${currentUser.name}</p></a
                                    >
                                </div>
                                <div style="padding: 0.5rem 0">
                                    <div class="item">
                                        <a href="loadProfile?email=${currentUser.email}"
                                           ><p>Profile</p></a
                                        >
                                    </div>
                                </div>
                                <div class="item-bottom">
                                    <a href="logout">Sign Out</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </header>
            <!-- container  -->
            <!-- container  -->
            <!-- container  -->
            <section class="container">
                <div class="left-menu">
                    <div class="navigation_left">
                        <div class="sidebar_navigation">
                            <h2 class="title_navigation">Menu</h2>
                            <a href="/">
                                <div class="container_item">
                                    <img src="./images/house_icon.svg" />
                                    <p>Home</p>
                                </div>
                            </a>
                            <a href="loadPendingPosts?postStatus=WFA">
                                <div class="container_item">
                                    <img src="./images/list_icon.svg" />
                                    <p>Pending Posts</p>
                                </div>
                            </a>
                            <a href="createPostPage">
                                <div class="container_item create-post">
                                    <img src="./images/create-blog.svg" />
                                    <p>Create Post</p>
                                </div>
                            </a>
                            <a href="loadDashboard">
                                <div class="container_item create-post">
                                    <img src="./images/dashborad.svg" />
                                    <p>Give Award</p>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="main-content">
                    <div class="title">
                        <h1>Award Dashboard</h1>
                    </div>
                    <div class="dashborad-tab">
                        <c:set var="tab" value="${requestScope.TAB_TYPE}"/>
                        <a class="tab_item ${tab == 'post' ? "tab-active" : ""}" href="loadDashboard?tab=post">Sort by posts</a>
                        <a class="tab_item ${tab == 'like' ? "tab-active" : ""}" href="loadDashboard?tab=like">Sort by likes</a>
                    </div>
                    <div class="award-dashboard-list">
                        <table>
                            <thead>
                                <tr>
                                    <th colspan="3">Information</th>
                                    <th>Total Post/Likes</th>
                                    <th>Award received</th>
                                    <th colspan="2">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="userList" value="${requestScope.USER_LIST}" />
                                <c:forEach var="user" items="${userList}">
                                <form action="giveAward" method="POST">
                                    <tr>
                                        <td class="avt-user">
                                            <img class="avt" src="${user.avatar}" alt="" />
                                        </td>
                                        <td class="email-td"><a href="loadProfile?email=${user.email}">${user.email}</a></td>
                                        <td class="name-td">${user.name}</td>
                                        <td>
                                            <span class="award-item">
                                                <i class="fas fa-pen-alt"></i> ${user.totalPosts}
                                            </span>
                                            <span class="award-item">
                                                <i class="fas fa-heart"></i> ${user.totalLikes}</span
                                            >
                                        </td>
                                        <td class="awarded-gr">
                                            <c:forEach var="award" items="${user.awards}">
                                                <c:if test="${award == 1}">
                                                    <img
                                                        class="awarded-icon"
                                                        src="./images/contribution-award.svg"
                                                        alt=""
                                                        />
                                                </c:if>
                                                <c:if test="${award == 2}">
                                                    <img
                                                        class="awarded-icon"
                                                        src="./images/heart-award.png"
                                                        alt=""
                                                        />
                                                </c:if>
                                                <c:if test="${award == 3}">
                                                    <img
                                                        class="awarded-icon"
                                                        src="./images/top-author.png"
                                                        alt=""
                                                        />
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td>
                                            <select name="awardID" class="select-award">
                                                <option value="0" style="display: none">
                                                    Select Award
                                                </option>
                                                <option value="1">Great Contributor</option>
                                                <option value="2">Like Collector</option>
                                                <option value="3">Excellent Writer</option>
                                            </select>
                                        </td>
                                        <td>
                                            <input type="hidden" name="email" value="${user.email}" />
                                            <button class="give-award-btn">Give award</button>
                                        </td>
                                    </tr>
                                </form>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>
            <!-- footer -->
            <!-- footer -->
            <!-- footer -->
            <footer>
                <div class="container_footer">
                    <p>
                        <span class="text_footer_strong">DEV Community</span> - A constructive
                        and inclusive social network for software developers. With you every
                        step of your journey.
                    </p>
                    <div style="margin: 0.25rem 0"></div>
                    <p>
                        Built on <span class="text_footer_strong">Forem</span> - the
                        <span class="text_footer_strong">open source</span> software that
                        powers DEV and other inclusive communities
                    </p>
                </div>
                <div class="text_footer_container">
                    <p class="text_footer">
                        Made with
                        <i class="fa fa-heart" style="color: rgb(255, 70, 50)"></i> by
                        <span class="text_footer_strong">Ân, An, Đan, Nam, Phương</span> ©
                        2021
                    </p>
                    <img src="./images/forem_icon.svg" />
                </div>
            </footer>

            <!-- error -->
            <div class="error-modal hidden">
                <img src="./images/error_alert.png" alt="">
                <h1>
                    <c:if test="${notify == 'error'}">Please select an award !!!</c:if>
                    <c:if test="${notify == 'error2'}">This user already has this award !!!</c:if>
                    <c:if test="${notify == 'unqualified-post'}">This user does not have enough post (3 or upper)</c:if>
                    <c:if test="${notify == 'unqualified-like'}">This user does not have enough like (5 or upper)</c:if>
                    </h1>
                    <button class="OKbtn-error-modal">Ok</button>
                </div>
                <div class="error-modal-overlay hidden"></div>

                <script>
                    const errorModal = document.querySelector(
                            ".error-modal"
                            );
                    const errorModalOverlay = document.querySelector(
                            ".error-modal-overlay"
                            );

                    document
                            .querySelector(".OKbtn-error-modal")
                            .addEventListener("click", () => {
                                errorModal.classList.toggle("hidden");
                                errorModalOverlay.classList.toggle("hidden");
                            });

                    errorModalOverlay.addEventListener("click", () => {
                        errorModal.classList.toggle("hidden");
                        errorModalOverlay.classList.toggle("hidden");
                    });
                <c:if test="${not empty notify}">
                    errorModal.classList.remove("hidden");
                    errorModalOverlay.classList.remove("hidden");
                </c:if>
            </script>
        </body>
    </html>
