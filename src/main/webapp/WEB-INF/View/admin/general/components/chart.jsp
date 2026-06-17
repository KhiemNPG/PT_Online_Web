<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page import="java.text.DecimalFormat" %>
<%
Object totalAccountCustomerObj = request.getAttribute("totalAccountCustomer");
int totalAccountCustomer = (totalAccountCustomerObj != null) ? (int) totalAccountCustomerObj : 0;

Object totalAccountProObj = request.getAttribute("totalAccountPro");
int totalAccountPro = (totalAccountProObj != null) ? (int) totalAccountProObj : 0;

// 🔥 FIX: Tính số account Free (Customer - Pro)
int totalAccountFree = totalAccountCustomer - totalAccountPro;

// Tổng = totalAccountCustomer (vì Pro đã nằm trong Customer)
int totalAccounts = totalAccountCustomer;

// Tính phần trăm
double percentFree = 0;
double percentPro = 0;
if (totalAccounts > 0) {
percentFree = (totalAccountFree * 100.0) / totalAccounts;
percentPro = (totalAccountPro * 100.0) / totalAccounts;
}

// Optional: Làm tròn 1 chữ số thập phân cho đẹp
percentFree = Math.round(percentFree * 10.0) / 10.0;
percentPro = Math.round(percentPro * 10.0) / 10.0;

// Format số
DecimalFormat numberFormat = new DecimalFormat("#,###");
String totalAccountsFormatted = numberFormat.format(totalAccounts);
String totalCustomerFormatted = numberFormat.format(totalAccountCustomer);
String totalProFormatted = numberFormat.format(totalAccountPro);

// Format phần trăm
DecimalFormat percentFormat = new DecimalFormat("#.#");
String percentFreeFormatted = percentFormat.format(percentFree);
String percentProFormatted = percentFormat.format(percentPro);

// Tính điểm kết thúc cho conic-gradient
double freeEnd = percentFree;
double proEnd = percentFree + percentPro;
%>

<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        :root {
            --bg-main: #0b0f19;
            --bg-surface: #111622;
            --text-muted: #64748b;
            --color-primary: #10b981;
            --color-tech-blue: #38bdf8;
            --color-warning: #f59e0b;
        }

        body { background-color: var(--bg-main) !important; color: #f8fafc !important; font-family: sans-serif; }

        .bento-card {
            background-color: var(--bg-surface);
            border: 1px solid rgba(100, 116, 139, 0.15);
            border-radius: 1rem;
            padding: 1.5rem;
        }

        .chart-container {
            height: 200px;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        .text-muted-custom { color: var(--text-muted) !important; font-size: 0.85rem; }

        .pie-chart {
            width: 200px;
            height: 180px;
            border-radius: 50%;
            background: conic-gradient(
                #00a3ff 0% <%= percentFreeFormatted %>%,           /* Free Plan */
                #e9c400 <%= percentFreeFormatted %>% 100%          /* Pro Plan - đến 100% */
            );
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .pie-chart::after {
            content: "";
            position: absolute;
            width: 75%;
            height: 75%;
            background-color: var(--bg-surface);
            border-radius: 50%;
        }
    </style>
</head>
<body>

<div class="container-fluid p-4" style="padding: 0!important;">
    <div class="row g-4">
        <div class="col-12 col-md-12">
            <div class="bento-card h-100 d-flex flex-column">
                <h4 class="h5 fw-bold text-white mb-4">Phân bổ Gói dịch vụ</h4>

                <div class="flex-grow-1 d-flex flex-column align-items-center justify-content-center">

                    <div class="chart-container mb-3">
                        <div class="pie-chart">
                            <div class="text-center position-relative" style="z-index: 1;">
                                <div style="font-size: 9px; color: var(--text-muted);">TỔNG CỘNG</div>
                                <div class="fw-bold fs-4"><%= totalAccountsFormatted %></div>
                            </div>
                        </div>
                    </div>

                    <div class="w-100 mt-3">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <div class="d-flex align-items-center gap-2">
                                <span class="rounded-circle" style="width: 10px; height: 10px; background-color: #00a3ff;"></span>
                                <span class="text-muted-custom">Free Plan</span>
                            </div>
                            <span class="small fw-bold"><%= totalAccountFree %> (<%= percentFreeFormatted %>%)</span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <div class="d-flex align-items-center gap-2">
                                <span class="rounded-circle" style="width: 10px; height: 10px; background-color: #e9c400;"></span>
                                <span class="text-muted-custom">Pro Plan</span>
                            </div>
                            <span class="small fw-bold"><%= totalProFormatted %> (<%= percentProFormatted %>%)</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>