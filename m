Return-Path: <amwang@redhat.com>
From: Cong Wang <amwang@redhat.com>
Date: Thu, 20 Dec 2012 22:31:54 +0800
Message-Id: <1356013915-20835-2-git-send-email-amwang@redhat.com>
In-Reply-To: <1356013915-20835-1-git-send-email-amwang@redhat.com>
References: <1356013915-20835-1-git-send-email-amwang@redhat.com>
Subject: [Bridge] [PATCH 2/3] iproute2: update help info of bridge command
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org, Cong Wang <amwang@redhat.com>

Cc: Stephen Hemminger <shemminger@vyatta.com>
Signed-off-by: Cong Wang <amwang@redhat.com>
---
 bridge/bridge.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bridge/bridge.c b/bridge/bridge.c
index 1fcd365..1d59a1e 100644
--- a/bridge/bridge.c
+++ b/bridge/bridge.c
@@ -27,7 +27,7 @@ static void usage(void)
 {
 	fprintf(stderr,
 "Usage: bridge [ OPTIONS ] OBJECT { COMMAND | help }\n"
-"where  OBJECT := { fdb |  monitor }\n"
+"where  OBJECT := { fdb |  mdb | monitor }\n"
 "       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails]\n" );
 	exit(-1);
 }
-- 
1.7.7.6

