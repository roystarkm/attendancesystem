<?php
require_once __DIR__ . '/includes/config.php';

if (isLoggedIn()) {
    redirect('index.php');
}

$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';
    $csrfToken = $_POST['csrf_token'] ?? '';

    if (!verifyCsrfToken($csrfToken)) {
        $error = 'Invalid or expired security token. Please refresh and try again.';
    } elseif ($username === '' || $password === '') {
        $error = 'Please enter both username and password.';
    } else {
        $stmt = $pdo->prepare('SELECT user_id, username, password, full_name, email, role FROM users WHERE username = ? LIMIT 1');
        $stmt->execute([$username]);
        $user = $stmt->fetch();

        if ($user && password_verify($password, $user['password'])) {
            session_regenerate_id(true);

            $_SESSION['user_id']   = (int) $user['user_id'];
            $_SESSION['username']  = $user['username'];
            $_SESSION['full_name'] = $user['full_name'];
            $_SESSION['role']      = $user['role'];
            $_SESSION['email']     = $user['email'];

            logActivity('User logged in');
            setFlash('success', 'Welcome back, ' . $user['full_name'] . '!');

            if ($user['role'] === 'admin') {
                redirect('admin/dashboard.php');
            } else {
                redirect('lecturer/dashboard.php');
            }
        } else {
            $error = 'Invalid username or password.';
        }
    }
}

$pageTitle = 'Sign In';
include __DIR__ . '/includes/header.php';
?>

<div class="row justify-content-center">
    <div class="col-md-6 col-lg-5">
        <div class="card shadow-sm">
            <div class="card-header bg-white py-3 text-center">
                <img src="<?php echo e(ASSET_PATH); ?>assets/images/logo.png" alt="Ndejje University Logo" height="60" class="mb-2">
                <h4 class="card-title mb-0"><i class="bi bi-lock me-2 text-primary"></i>Sign In to Portal</h4>
            </div>
            <div class="card-body p-4">
                <?php if ($error !== ''): ?>
                    <div class="alert alert-danger"><?php echo e($error); ?></div>
                <?php endif; ?>

                <form method="POST" action="">
                    <?php echo csrfField(); ?>

                    <div class="mb-3">
                        <label for="username" class="form-label">Username</label>
                        <input type="text" class="form-control" id="username" name="username" value="<?php echo e($_POST['username'] ?? ''); ?>" placeholder="Enter your username" autocomplete="username" required autofocus>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <div class="input-group">
                            <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" autocomplete="current-password" required>
                            <button class="btn btn-outline-secondary toggle-password" type="button" aria-label="Show or hide password">
                                <i class="bi bi-eye"></i>
                            </button>
                        </div>
                    </div>

                    <div class="d-grid mt-4">
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-box-arrow-in-right me-1"></i>Sign In
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<?php include __DIR__ . '/includes/footer.php'; ?>
