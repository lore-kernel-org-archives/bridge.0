Return-Path: <john.fastabend@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=subject:to:from:cc:date:message-id:user-agent:mime-version
	:content-type:content-transfer-encoding;
	bh=ACbjZkPhqT+OwjkT3Laqus0wJeNhyCPlhw9nlvqe6s8=;
	b=tYFh5RzB6Yr8w8lOHpB3sn7AAdDwWkFCpND/lgv7c5UX9pWF1OUqPdOCW8MgdZzqud
	BYUzftcLc3PMF7v00aZ35HS1bOdYNumYNswWR4BUvwIBInXC0n0iqSpePeXoLYVmtPjy
	GtnUjsrzm/5cDIYcfYMZcZIjRUxfBG42FAnSHGHpwReJdkajghyW3UCDstaAeOnsHSI1
	8tupDTz3sr49FV14xTjvqbOvF/IY0EZZ0oFbpoPSyI8Bpc9em9u/M2TjUKPXhGsjR7wS
	Mrj07ey7Pm6GqSvt8N5jPVrfCYaID5OY06SNJyaWGOcLTNsX0AHxmCjb1zV2Ni05uImP
	C5Pw==
From: John Fastabend <john.fastabend@gmail.com>
Date: Wed, 29 May 2013 09:20:53 -0700
Message-ID: <20130529162044.25906.79115.stgit@nitbit.x32>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] iproute2: bridge: fix 'bridge link'
	setlink/getlink parsing
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stephen@networkplumber.org
Cc: vyasevic@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org

Use IFLA_AF_SPEC nested attributes to lookup bridge mode and when
doing strcmp() check for equality.

These appear to be typos from the original commit,

commit 64108901b737b95247b53dec8c1b8217ca8505b7
Author: Vlad Yasevich <vyasevic@redhat.com>
Date:   Fri Mar 15 10:01:28 2013 -0700

    bridge: Add support for setting bridge port attributes

Also set flags to BRIDGE_FLAGS_SELF instead of using OR operation.
This allows setting the bridge mode when not being used with a
master device.

To allow setting both master and self devices simultaneously we
will need to add a {self|master} field similar to fdb commands.
For now the command sets are mutually exclusive as noted in the
original commit.

With this patch 'bridge link set' works now,

# ./bridge/bridge link set dev veth1 cost 3
# ./bridge/bridge link show
10: veth1 state UP : <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master bridge0 state forwarding priority 3 cost 3

CC: Vlad Yasevich <vyasevic@redhat.com>
Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
---
 bridge/link.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/bridge/link.c b/bridge/link.c
index 3188b85..38dfaea 100644
--- a/bridge/link.c
+++ b/bridge/link.c
@@ -198,8 +198,8 @@ int print_linkinfo(const struct sockaddr_nl *who,
 
 		parse_rtattr_nested(aftb, IFLA_BRIDGE_MAX, tb[IFLA_AF_SPEC]);
 
-		if (tb[IFLA_BRIDGE_MODE])
-			print_hwmode(fp, rta_getattr_u16(tb[IFLA_BRIDGE_MODE]));
+		if (aftb[IFLA_BRIDGE_MODE])
+			print_hwmode(fp, rta_getattr_u16(aftb[IFLA_BRIDGE_MODE]));
 	}
 
 	fprintf(fp, "\n");
@@ -281,18 +281,18 @@ static int brlink_modify(int argc, char **argv)
 			NEXT_ARG();
 			if (!on_off("root_block", &root_block, *argv))
 				exit(-1);
-		} else if (strcmp(*argv, "cost")) {
+		} else if (strcmp(*argv, "cost") == 0) {
 			NEXT_ARG();
 			cost = atoi(*argv);
-		} else if (strcmp(*argv, "priority")) {
+		} else if (strcmp(*argv, "priority") == 0) {
 			NEXT_ARG();
 			priority = atoi(*argv);
-		} else if (strcmp(*argv, "state")) {
+		} else if (strcmp(*argv, "state") == 0) {
 			NEXT_ARG();
 			state = atoi(*argv);
-		} else if (strcmp(*argv, "hwmode")) {
+		} else if (strcmp(*argv, "hwmode") == 0) {
 			NEXT_ARG();
-			flags |= BRIDGE_FLAGS_SELF;
+			flags = BRIDGE_FLAGS_SELF;
 			if (strcmp(*argv, "vepa") == 0)
 				mode = BRIDGE_MODE_VEPA;
 			else if (strcmp(*argv, "veb") == 0)

