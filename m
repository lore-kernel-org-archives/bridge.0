Date: Mon, 5 Sep 2011 22:58:07 +0800
From: Xiaochen Wang <wangxiaochen0@gmail.com>
Message-ID: <20110905145807.GA9179@chii>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] [PATCH] skip . and .. in accurately in isbridge()
Reply-To: Xiaochen Wang <wangxiaochen0@gmail.com>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@linux-foundation.org
Cc: Lennert Buytenhek <buytenh@gnu.org>, tephen Hemminger <shemminger@vyatta.com>

Hi all,

 In commit f88f8 "Skip . and .. in foreach_bridge test", the code skips
 all directories starting with dot.

 But if we create a bridge staring with dot, e.g. `.br0`, then `brctl show`
 cannot show this one.
 `.br0` should not be hidden, because we cannot find it except the command
 `brctl show .br0`.

Signed-off-by: Xiaochen Wang <wangxiaochen0@gmail.com>
---
 libbridge/libbridge_init.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/libbridge/libbridge_init.c b/libbridge/libbridge_init.c
index 1c1acbd..177a391 100644
--- a/libbridge/libbridge_init.c
+++ b/libbridge/libbridge_init.c
@@ -49,9 +49,12 @@ static int isbridge(const struct dirent *entry)
 	char path[SYSFS_PATH_MAX];
 	struct stat st;
 
-	if (entry->d_name[0] == '.')
+	if (entry->d_name[0] == '.'
+	    && (entry->d_name[1] == '\0'
+		|| (entry->d_name[1] == '.'
+		    && entry->d_name[2] == '\0')))
 		return 0;
-	
+
 	snprintf(path, SYSFS_PATH_MAX, 
 		 SYSFS_CLASS_NET "%s/bridge", entry->d_name);
 	return stat(path, &st) == 0 && S_ISDIR(st.st_mode);
-- 
1.7.2.3

