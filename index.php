<?php
require_once __DIR__ . '/includes/config.php';

if (isLoggedIn()) {
    if (($_SESSION['role'] ?? '') === 'admin') {
        redirect('admin/dashboard.php');
    } else {
        redirect('lecturer/dashboard.php');
    }
}

$pageTitle = 'Welcome';
include __DIR__ . '/includes/header.php';
?>

<div class="row">
    <div class="col-lg-9 mx-auto">
        <div class="card border-0 shadow-sm">
            <div class="card-body text-center p-4 p-md-5">
                <img src="<?php echo e(ASSET_PATH); ?>assets/images/logo.png" alt="Ndejje University Emblem" class="img-fluid mb-4" style="max-height: 140px;">
                <h2 class="mb-3 fw-bold">Welcome to Ndejje University Attendance System</h2>
                <p class="lead text-muted mb-4">Track student class attendance, monitor academic compliance, and generate examination eligibility reports.</p>

                <div class="row mt-4 g-4 text-start">
                    <div class="col-md-6">
                        <div class="card h-100 border">
                            <div class="card-body d-flex flex-column p-4">
                                <div class="mb-2 text-primary fs-3"><i class="bi bi-shield-lock"></i></div>
                                <h4 class="card-title">For Administrators</h4>
                                <p class="card-text text-muted flex-grow-1">Register students, configure courses, assign lecturers, manage user accounts, and export exam-eligibility reports.</p>
                                <a href="<?php echo e(ASSET_PATH); ?>login.php" class="btn btn-primary mt-2">
                                    <i class="bi bi-box-arrow-in-right me-1"></i>Sign In as Admin
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="card h-100 border">
                            <div class="card-body d-flex flex-column p-4">
                                <div class="mb-2 text-success fs-3"><i class="bi bi-clipboard2-check"></i></div>
                                <h4 class="card-title">For Lecturers</h4>
                                <p class="card-text text-muted flex-grow-1">Schedule lecture sessions, mark student roll-call attendance (Present, Late, Absent), and review course attendance analytics.</p>
                                <a href="<?php echo e(ASSET_PATH); ?>login.php" class="btn btn-success mt-2">
                                    <i class="bi bi-box-arrow-in-right me-1"></i>Sign In as Lecturer
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="mt-4 pt-3 border-top text-muted small">
                    <p class="mb-0">Need technical assistance? Contact the IT department at <a href="mailto:it@ndejjeuniversity.ac.ug">it@ndejjeuniversity.ac.ug</a></p>
                </div>
            </div>
        </div>
    </div>
</div>

<?php include __DIR__ . '/includes/footer.php'; ?>
