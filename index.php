<?php
require_once 'includes/config.php';

if (isLoggedIn()) {
    if ($_SESSION['role'] == 'admin') {
        redirect('admin/dashboard.php');
    } else {
        redirect('lecturer/dashboard.php');
    }
}

$cssPath = $_SERVER['DOCUMENT_ROOT'] . '/attendance_system/assets/css/style.css';?>

<!DOCTYPE html>
<head>
<style>
<?php
if(file_exists($cssPath)) {
	readfile($cssPath);
} else {
	echo "/* CSS file not found at: $cssPath*/";
}
?>
</style>

<?php include 'includes/header.php'; ?>

<div class="row">
    <div class="col-md-8 mx-auto">
        <div class="card">
            <div class="card-body text-center">
                <img src="<?php echo BASE_URL; ?>assets/images/logo.png" alt="Ndejje University" class="img-fluid mb-4" style="max-height: 150px;">
                <h2 class="mb-4">Welcome to Ndejje University Attendance System</h2>
                <p class="lead mb-4">An automated system for tracking student attendance and generating reports.</p>
                
                <div class="row mt-5">
                    <div class="col-md-6 mb-4">
                        <div class="card h-100">
                            <div class="card-body">
                                <h4 class="card-title">For Administrators</h4>
                                <p class="card-text">Manage students, courses, users, and generate comprehensive reports.</p>
                                <a href="login.php" class="btn btn-primary">Admin Login</a>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-6 mb-4">
                        <div class="card h-100">
                            <div class="card-body">
                                <h4 class="card-title">For Lecturers</h4>
                                <p class="card-text">Record attendance, manage classes.</p>
                                <a href="login.php" class="btn btn-primary">Lecturer Login</a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="mt-4">
                    <p>Need help? Contact the IT department at <a href="mailto:it@ndejjeuniversity.ac.ug">it@ndejjeuniversity.ac.ug</a></p>
                </div>
            </div>
        </div>
    </div>
</div>

<?php include 'includes/footer.php'; ?>