<?php
require_once __DIR__ . '/includes/config.php';

$pageTitle = 'About System';
include __DIR__ . '/includes/header.php';
?>

<div class="row">
    <div class="col-lg-9 mx-auto">
        <div class="card shadow-sm">
            <div class="card-header bg-white py-3 d-flex align-items-center">
                <img src="<?php echo e(ASSET_PATH); ?>assets/images/logo.png" alt="Ndejje University Logo" height="40" class="me-3">
                <h4 class="card-title mb-0"><i class="bi bi-info-circle me-2 text-primary"></i>About the Attendance Management System</h4>
            </div>
            <div class="card-body p-4">
                <p class="lead">The <strong>Ndejje University Attendance Management System</strong> automates lecture attendance tracking, academic compliance monitoring, and examination eligibility reporting.</p>

                <h5 class="mt-4"><i class="bi bi-check2-circle text-success me-2"></i>Core Capabilities</h5>
                <ul>
                    <li><strong>Role-Based Access Control:</strong> Dedicated portals for Academic Administrators and Course Lecturers.</li>
                    <li><strong>Digital Roll Call:</strong> Lecturers record attendance per lecture session with <em>Present</em>, <em>Late</em>, and <em>Absent</em> statuses.</li>
                    <li><strong>75% Examination Eligibility Policy:</strong> Automated calculation of student attendance percentages across courses to verify examination eligibility (&ge; 75% required).</li>
                    <li><strong>Comprehensive Reporting &amp; Export:</strong> Filter attendance analytics by course, individual student, or date range and export reports directly to Excel.</li>
                </ul>

                <h5 class="mt-4"><i class="bi bi-building text-primary me-2"></i>Campus Information</h5>
                <p class="mb-1"><strong>Location:</strong> Kampala Campus, Along Balintuma Road near Mengo Hospital, Kampala, Uganda</p>
                <p class="mb-1"><strong>Telephone:</strong> +256 392 730324</p>
                <p class="mb-3"><strong>Email:</strong> <a href="mailto:info@ndejjeuniversity.ac.ug">info@ndejjeuniversity.ac.ug</a></p>

                <a href="<?php echo e(ASSET_PATH); ?>login.php" class="btn btn-primary">
                    <i class="bi bi-box-arrow-in-right me-1"></i>Proceed to Sign In
                </a>
            </div>
        </div>
    </div>
</div>

<?php include __DIR__ . '/includes/footer.php'; ?>
