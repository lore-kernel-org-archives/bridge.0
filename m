Return-Path: <mcgrof@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Message-Id: <20200610154923.27510-2-mcgrof@kernel.org>
In-Reply-To: <20200610154923.27510-1-mcgrof@kernel.org>
References: <20200610154923.27510-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 1/5] selftests: kmod: Use variable NAME in
	kmod_test_0001()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Wed, 10 Jun 2020 15:49:28 -0000
To: gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, philipp.reisner@linbit.com, lars.ellenberg@linbit.com, axboe@kernel.dk, bfields@fieldses.org, chuck.lever@oracle.com, roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, serge@hallyn.com, christian.brauner@ubuntu.com
Cc: linux-nfs@vger.kernel.org, chainsaw@gentoo.org, ravenexp@gmail.com, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, josh@joshtriplett.org, slyfox@gentoo.org, ast@kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>, keescook@chromium.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

Use the variable NAME instead of "\000" directly in kmod_test_0001().

Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tools/testing/selftests/kmod/kmod.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftests/kmod/kmod.sh
index 3702dbcc90a7..da60c3bd4f23 100755
--- a/tools/testing/selftests/kmod/kmod.sh
+++ b/tools/testing/selftests/kmod/kmod.sh
@@ -341,7 +341,7 @@ kmod_test_0001_driver()
 
 	kmod_defaults_driver
 	config_num_threads 1
-	printf '\000' >"$DIR"/config_test_driver
+	printf $NAME >"$DIR"/config_test_driver
 	config_trigger ${FUNCNAME[0]}
 	config_expect_result ${FUNCNAME[0]} MODULE_NOT_FOUND
 }
@@ -352,7 +352,7 @@ kmod_test_0001_fs()
 
 	kmod_defaults_fs
 	config_num_threads 1
-	printf '\000' >"$DIR"/config_test_fs
+	printf $NAME >"$DIR"/config_test_fs
 	config_trigger ${FUNCNAME[0]}
 	config_expect_result ${FUNCNAME[0]} -EINVAL
 }
-- 
2.26.2

