// ============================================================
// Jenkinsfile — Portfolio Website CI/CD Pipeline
// Author: Muaz Bhutta | muazbhutta.online
//
// What this pipeline does:
//   1. Checks out the current branch (multibranch pipeline)
//   2. Installs lint/test tools via npm (no global installs)
//   3. Validates HTML syntax        (html-validate)
//   4. Validates CSS syntax         (stylelint)
//   5. Validates JS syntax + logic  (node --check + eslint no-undef)
//   6. Generates a PDF report of all results (pdfkit)
//   7. ONLY on 'test' branch: if all checks pass AND test has
//      commits that main doesn't, merge test -> main and push.
//      If no changes, it just tests and stops.
// ============================================================

pipeline {
    agent any

    options {
        timestamps()
        buildDiscarder(logRotator(numToKeepStr: '15'))
        disableConcurrentBuilds()
    }

    environment {
        REPORT_DIR = 'reports'
        // Jenkins credential ID for GitHub PAT (username/password type)
        GIT_CREDS  = 'github-pat'
        REPO_URL   = 'github.com/YOUR_USERNAME/YOUR_PORTFOLIO_REPO.git'
    }

    stages {

        // --------------------------------------------------------
        stage('Checkout & Info') {
            steps {
                sh '''
                    echo "Branch  : $BRANCH_NAME"
                    echo "Commit  : $(git rev-parse --short HEAD)"
                    echo "Author  : $(git log -1 --pretty=%an)"
                    echo "Message : $(git log -1 --pretty=%s)"
                    mkdir -p ${REPORT_DIR}
                '''
            }
        }

        // --------------------------------------------------------
        stage('Install Test Tools') {
            steps {
                sh '''
                    # Local install only — keeps Jenkins workspace clean
                    npm install --no-save --no-fund --no-audit \
                        eslint@8 \
                        stylelint stylelint-config-standard \
                        html-validate \
                        pdfkit

                    # Write lint configs on the fly (repo stays clean)
                    cat > .eslintrc.json << 'EOF'
{
  "env": { "browser": true, "es2021": true },
  "parserOptions": { "ecmaVersion": 2021, "sourceType": "script" },
  "rules": {
    "no-undef": "error",
    "no-unused-vars": "warn",
    "no-dupe-keys": "error",
    "no-unreachable": "error"
  }
}
EOF

                    cat > .stylelintrc.json << 'EOF'
{
  "extends": "stylelint-config-standard",
  "rules": {
    "no-descending-specificity": null,
    "selector-class-pattern": null,
    "custom-property-pattern": null
  }
}
EOF

                    cat > .htmlvalidate.json << 'EOF'
{
  "extends": ["html-validate:recommended"],
  "rules": {
    "no-trailing-whitespace": "off",
    "no-inline-style": "off"
  }
}
EOF
                '''
            }
        }

        // --------------------------------------------------------
        stage('HTML Syntax Check') {
            steps {
                // catchError: mark stage failed but keep pipeline
                // running so the PDF report always gets generated
                catchError(buildResult: 'FAILURE', stageResult: 'FAILURE') {
                    sh '''
                        echo "== HTML VALIDATION ==" | tee ${REPORT_DIR}/html.log
                        FILES=$(find . -name "*.html" -not -path "./node_modules/*")
                        if [ -z "$FILES" ]; then
                            echo "No HTML files found." | tee -a ${REPORT_DIR}/html.log
                        else
                            npx html-validate $FILES 2>&1 | tee -a ${REPORT_DIR}/html.log
                            exit ${PIPESTATUS:-$?}
                        fi
                    '''
                }
            }
        }

        // --------------------------------------------------------
        stage('CSS Syntax Check') {
            steps {
                catchError(buildResult: 'FAILURE', stageResult: 'FAILURE') {
                    sh '''
                        echo "== CSS VALIDATION ==" | tee ${REPORT_DIR}/css.log
                        FILES=$(find . -name "*.css" -not -path "./node_modules/*")
                        if [ -z "$FILES" ]; then
                            echo "No CSS files found." | tee -a ${REPORT_DIR}/css.log
                        else
                            npx stylelint $FILES 2>&1 | tee -a ${REPORT_DIR}/css.log
                        fi
                    '''
                }
            }
        }

        // --------------------------------------------------------
        stage('JS Syntax Check') {
            steps {
                catchError(buildResult: 'FAILURE', stageResult: 'FAILURE') {
                    sh '''
                        echo "== JS VALIDATION ==" | tee ${REPORT_DIR}/js.log

                        FILES=$(find . -name "*.js" -not -path "./node_modules/*" -not -name ".eslintrc*")
                        if [ -z "$FILES" ]; then
                            echo "No JS files found." | tee -a ${REPORT_DIR}/js.log
                            exit 0
                        fi

                        # Pass 1: pure syntax parse (catches broken syntax fast)
                        echo "--- node --check (syntax parse) ---" | tee -a ${REPORT_DIR}/js.log
                        SYNTAX_FAIL=0
                        for f in $FILES; do
                            if node --check "$f" 2>>${REPORT_DIR}/js.log; then
                                echo "OK   $f" | tee -a ${REPORT_DIR}/js.log
                            else
                                echo "FAIL $f" | tee -a ${REPORT_DIR}/js.log
                                SYNTAX_FAIL=1
                            fi
                        done

                        # Pass 2: ESLint — catches undefined variables etc.
                        # (node --check alone misses no-undef errors!)
                        echo "--- eslint (no-undef, unused vars) ---" | tee -a ${REPORT_DIR}/js.log
                        npx eslint $FILES 2>&1 | tee -a ${REPORT_DIR}/js.log
                        ESLINT_EXIT=${PIPESTATUS:-$?}

                        [ "$SYNTAX_FAIL" = "1" ] && exit 1
                        exit $ESLINT_EXIT
                    '''
                }
            }
        }

        // --------------------------------------------------------
        stage('Generate PDF Report') {
            steps {
                sh '''
                    cat > gen-report.js << 'EOF'
const PDFDocument = require('pdfkit');
const fs = require('fs');

const doc = new PDFDocument({ margin: 40 });
doc.pipe(fs.createWriteStream('reports/test-report.pdf'));

// ---- Header ----
doc.fontSize(20).text('Portfolio CI Test Report', { align: 'center' });
doc.moveDown(0.5);
doc.fontSize(10).fillColor('#555')
   .text(`Branch: ${process.env.BRANCH_NAME || 'unknown'}   |   Build: #${process.env.BUILD_NUMBER || '?'}   |   ${new Date().toUTCString()}`,
         { align: 'center' });
doc.moveDown(1);

// ---- Sections ----
const sections = [
  { title: 'HTML Validation', file: 'reports/html.log' },
  { title: 'CSS Validation',  file: 'reports/css.log'  },
  { title: 'JS Validation',   file: 'reports/js.log'   },
];

for (const s of sections) {
  doc.fontSize(14).fillColor('#000').text(s.title, { underline: true });
  doc.moveDown(0.3);
  let content = 'No log produced.';
  try { content = fs.readFileSync(s.file, 'utf8'); } catch (e) {}
  if (content.trim().length === 0) content = 'Clean — no issues reported.';
  doc.fontSize(8).font('Courier').fillColor('#333')
     .text(content, { width: 515 });
  doc.font('Helvetica').moveDown(1);
}

// ---- Verdict ----
const failed = (process.env.BUILD_FAILED === 'true');
doc.fontSize(16)
   .fillColor(failed ? '#cc0000' : '#008800')
   .text(failed ? 'RESULT: FAILED' : 'RESULT: PASSED', { align: 'center' });

doc.end();
console.log('PDF report written to reports/test-report.pdf');
EOF

                    BUILD_FAILED=$([ "$(echo ${currentBuild_result:-SUCCESS})" = "FAILURE" ] && echo true || echo false)
                    export BUILD_FAILED
                    node gen-report.js
                '''
                archiveArtifacts artifacts: 'reports/*', fingerprint: true
            }
        }

        // --------------------------------------------------------
        // Runs ONLY on 'test' branch, ONLY if all stages passed.
        // Merges into main ONLY if test actually has new commits.
        // --------------------------------------------------------
        stage('Merge test -> main') {
            when {
                branch 'test'
                expression { currentBuild.currentResult == 'SUCCESS' }
            }
            steps {
                withCredentials([usernamePassword(
                    credentialsId: env.GIT_CREDS,
                    usernameVariable: 'GIT_USER',
                    passwordVariable: 'GIT_TOKEN'
                )]) {
                    sh '''
                        git config user.name  "jenkins-ci"
                        git config user.email "jenkins@muazbhutta.online"

                        git fetch origin main test

                        # How many commits does test have that main doesn't?
                        NEW_COMMITS=$(git rev-list --count origin/main..origin/test)
                        echo "New commits in test not in main: $NEW_COMMITS"

                        if [ "$NEW_COMMITS" -eq 0 ]; then
                            echo ">> No changes to merge. Tests passed — nothing else to do."
                            exit 0
                        fi

                        echo ">> Changes detected. Merging test into main..."
                        git checkout -B main origin/main
                        git merge --no-ff origin/test \
                            -m "CI: auto-merge test -> main (build #${BUILD_NUMBER}, all checks passed)"

                        git push "https://${GIT_USER}:${GIT_TOKEN}@${REPO_URL}" main
                        echo ">> Merged and pushed to main successfully."
                    '''
                }
            }
        }
    }

    // ------------------------------------------------------------
    post {
        success {
            echo "✅ Build #${BUILD_NUMBER} on ${BRANCH_NAME}: ALL CHECKS PASSED"
        }
        failure {
            echo "❌ Build #${BUILD_NUMBER} on ${BRANCH_NAME}: CHECKS FAILED — see reports/test-report.pdf"
        }
        always {
            cleanWs(deleteDirs: true, notFailBuild: true,
                    patterns: [[pattern: 'node_modules/**', type: 'INCLUDE']])
        }
    }
}
