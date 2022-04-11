Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=8qjm9wLjph4c7kZ9jfundVdGQ8PpnhtD4gzzvkqBGsw=;
 b=o88XnttxQH1grWq83aF2OyYu/OVtodv2bsFld55tVD1cJ7zPXGbYuugXvLyv7S+paa
 w0T63kWHbWtByKFbWpp1T7hfyoGLYImSlR+vYNnTiDx2UYFt/91qCMm3I/6XbtZgNuZo
 KQf3aXihjAxbi5uLLb0AEs63L+PANYYdNk0sAdnZCVm9cWq50FBqGHxSb0hAYyViqc/r
 a0YxqHm8hwzcwD6Vw/R33J0quvtAa0l4q2EeuW5scdocpR8W7MQtgM/U/zebSyh4nUXB
 AI0f2RRWbVh9JOQLwldxiBlXthrz5wUHe/pRZ3NY2yji2tiI5xNpSH5wKQ2qTWNTYvpp
 gU6w==
From: Joachim Wiberg <troglobit@gmail.com>
Date: Mon, 11 Apr 2022 15:38:29 +0200
Message-Id: <20220411133837.318876-6-troglobit@gmail.com>
In-Reply-To: <20220411133837.318876-1-troglobit@gmail.com>
References: <20220411133837.318876-1-troglobit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH RFC net-next 05/13] selftests: forwarding: add
	TCPDUMP_EXTRA_FLAGS to lib.sh
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Vladimir Oltean <vladimir.oltean@nxp.com>, Joachim Wiberg <troglobit@gmail.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

For some use-cases we may want to change the tcpdump flags used in
tcpdump_start().  For instance, observing interfaces without the PROMISC
flag, e.g. to see what's really being forwarded to the bridge interface.

Signed-off-by: Joachim Wiberg <troglobit@gmail.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 tools/testing/selftests/net/forwarding/lib.sh

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
old mode 100644
new mode 100755
index 664b9ecaf228..00cdcab7accf
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1369,7 +1369,13 @@ tcpdump_start()
 		capuser="-Z $SUDO_USER"
 	fi
 
-	$ns_cmd tcpdump -e -n -Q in -i $if_name \
+	if [ -z $TCPDUMP_EXTRA_FLAGS ]; then
+		extra_flags=""
+	else
+		extra_flags="$TCPDUMP_EXTRA_FLAGS"
+	fi
+
+	$ns_cmd tcpdump $extra_flags -e -n -Q in -i $if_name \
 		-s 65535 -B 32768 $capuser -w $capfile > "$capout" 2>&1 &
 	cappid=$!
 
-- 
2.25.1

