Return-Path: <aclaudi@redhat.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D258E40159
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16621400CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694627930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LEtiwNiM9PzpjRqi6jakAaaVv0eVpRImxmmfOJbw9+M=;
 b=E4nWVITvjdg6c9psb7qda+ghFKEQLGFyXAxc/06WTgsSGi5gC+uEvc2Dk6XyZRFZoU62NQ
 six6y1li9DU35Q9PuQd5J7rx4lOmi203n+UWo9o2hflcUGZZc8j0KHSIKUGwJ+liHqwcd5
 R97rIyFvvG/O9EQxZ444K+0vJPvZdbI=
From: Andrea Claudi <aclaudi@redhat.com>
Date: Wed, 13 Sep 2023 19:58:26 +0200
Message-ID: <ccc21b33a1a338bc943ac5d0fb40a5bb7ad5fa43.1694625043.git.aclaudi@redhat.com>
In-Reply-To: <cover.1694625043.git.aclaudi@redhat.com>
References: <cover.1694625043.git.aclaudi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH iproute2-next 2/2] treewide: use configured value
	as the default color output
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, David Ahern <dsahern@gmail.com>, Roopa Prabhu <roopa@nvidia.com>

With Makefile providing -DCONF_COLOR, we can use its value as the
default color output.

This effectively allow users and packagers to define a default for the
color output feature without using shell aliases, and with minimum code
impact.

Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 bridge/bridge.c | 3 ++-
 ip/ip.c         | 2 +-
 tc/tc.c         | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/bridge/bridge.c b/bridge/bridge.c
index 704be50c..339101a8 100644
--- a/bridge/bridge.c
+++ b/bridge/bridge.c
@@ -23,7 +23,6 @@ int preferred_family = AF_UNSPEC;
 int oneline;
 int show_stats;
 int show_details;
-static int color;
 int compress_vlans;
 int json;
 int timestamp;
@@ -103,6 +102,8 @@ static int batch(const char *name)
 int
 main(int argc, char **argv)
 {
+	int color = CONF_COLOR;
+
 	while (argc > 1) {
 		const char *opt = argv[1];
 
diff --git a/ip/ip.c b/ip/ip.c
index 8c046ef1..860ff957 100644
--- a/ip/ip.c
+++ b/ip/ip.c
@@ -168,7 +168,7 @@ int main(int argc, char **argv)
 	const char *libbpf_version;
 	char *batch_file = NULL;
 	char *basename;
-	int color = 0;
+	int color = CONF_COLOR;
 
 	/* to run vrf exec without root, capabilities might be set, drop them
 	 * if not needed as the first thing.
diff --git a/tc/tc.c b/tc/tc.c
index 25820500..082c6677 100644
--- a/tc/tc.c
+++ b/tc/tc.c
@@ -35,7 +35,6 @@ int use_iec;
 int force;
 bool use_names;
 int json;
-int color;
 int oneline;
 int brief;
 
@@ -254,6 +253,7 @@ int main(int argc, char **argv)
 {
 	const char *libbpf_version;
 	char *batch_file = NULL;
+	int color = CONF_COLOR;
 	int ret;
 
 	while (argc > 1) {
-- 
2.41.0

