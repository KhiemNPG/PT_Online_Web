<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.List" %>
<%@ page import="model.entity.PersonalTrainer" %>
<%
List< PersonalTrainer> personalTrainerList = (List< PersonalTrainer>) request.getAttribute("topPersonalTrainerList");
    %>

    <div class="bento-card p-0 overflow-hidden">
        <div class="p-4 d-flex justify-content-between align-items-center border-bottom border-secondary border-opacity-10">
            <h5 class="fw-bold text-white mb-0">Top PT xuất sắc nhất</h5>
            <button class="btn btn-link text-info text-decoration-none p-0 d-flex align-items-center gap-1 small fw-bold">
                Xem tất cả <span class="material-symbols-outlined fs-6">arrow_forward</span>
            </button>
        </div>

        <div class="table-responsive">
            <table class="table table-dark table-borderless align-middle mb-0">
                <thead>
                <tr>
                    <th class="px-4 py-3 text-center">CHUYÊN GIA</th>
                    <th class="px-4 py-3 text-center">TAGS</th>
                    <th class="px-4 py-3 text-center">HỌC VIÊN</th>
                    <th class="px-4 py-3 text-center">TRẠNG THÁI</th>
                </tr>
                </thead>
                <tbody>
                <%
                if (personalTrainerList != null && !personalTrainerList.isEmpty()) {
                for (PersonalTrainer p : personalTrainerList) {
                %>
                <tr class="hover-row">
                    <td class="px-4 py-3">
                        <div class="d-flex align-items-center gap-3">
                            <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuCtrWVT0gsMsOSXRmkjMHVDA5Ukl1VttzrLeGaNTzQHN02oQIbUmJL0USsW7Ep4JuIGT3CmA6lA1QcWEBPukNSQz03r1CsucIuXUQwgcpX3S8GH60ndNZCQfmhgFSfl4VqCAel_J1hKIeVufGJupjOB5q5dfEhNY8moLijM1j5ArqeongycH9B7vKUHoplwtq1rJZje8n52T12BasPR7Sg_j4ptm0Dcf0vfj3z9GQC2TFsIthfI3QAmDZZDBVYAk7OK3va6Jv6yCF4"
                                 class="rounded-circle" style="width: 40px; height: 40px; object-fit: cover;">
                            <div>
                                <div class="fw-bold text-white small"><%= p.getName() %></div>
                                <div class="text-muted-custom" style="font-size: 10px;">ID: PT-<%= p.getPtId() %></div>
                            </div>
                        </div>
                    </td>

                    <td class="px-4 py-3">
                        <span class="badge rounded-pill" style="background: rgba(255, 255, 255, 0.05); color: #fff; font-size: 9px; border: 1px solid rgba(255,255,255,0.1);">
                            MASTER TRAINER
                        </span>
                    </td>

                    <td class="px-4 py-3 text-center fw-bold text-white"><%= p.getSuccessfulStudents() %></td>

                    <td class="px-4 py-3 text-center">
                        <span class="badge bg-success bg-opacity-10 text-success border border-success border-opacity-25 rounded-pill px-3" style="font-size: 10px;">
                            ACTIVE
                        </span>
                    </td>
                </tr>
                <%
                }
                } else {
                %>
                <tr>
                    <td colspan="4" class="text-center py-4 text-muted-custom">Chưa có dữ liệu PT xuất sắc</td>
                </tr>
                <%
                }
                %>
                </tbody>
            </table>
        </div>
    </div>