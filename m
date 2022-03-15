Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=A06tchB5P3xNuM8C6LfTzO8n4EM355S64hg7ZjA31l8=;
 b=J3HeoXTX/1HQ/6fEPZfupMGyBSjjAVjNhAIGypTRot8ER1tjFtwitWetTcMFZbo3db
 ZXGnrTNHS0d6QE9+6OgLCBbBRQdzmB9Y85dGdKi8loVMxwA0oqiqO9BZz3DwriPCitKK
 /oditpPfg9L2HtXrJVdMGLHXqNxJljj9EeyskVNqaDpyMcT7KrFWcyB6Rp3fe6ZCAIEJ
 Q1wPxEMqIJ/mzrINSlk5CHpneIQZ7ein7mVmhxZzqQMY6NZU+8vdBchc6EKzRfZj0fJQ
 RjoHORQCr0Pr+olXPepADfK/fb8fGqR7liG8OYsmXYSt5jALOHXh+w0wz39ZshDJolI1
 cc0w==
From: Tobias Waldekranz <tobias@waldekranz.com>
Date: Tue, 15 Mar 2022 01:25:37 +0100
Message-Id: <20220315002543.190587-10-tobias@waldekranz.com>
In-Reply-To: <20220315002543.190587-1-tobias@waldekranz.com>
References: <20220315002543.190587-1-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v4 net-next 09/15] net: dsa: Never offload FDB
	entries on standalone ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, Matt Johnston <matt@codeconstruct.com.au>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

If a port joins a bridge that it can't offload, it will fallback to
standalone mode and software bridging. In this case, we never want to
offload any FDB entries to hardware either.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 net/dsa/slave.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index a61a7c54af20..647adee97f7f 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -2624,6 +2624,9 @@ static int dsa_slave_fdb_event(struct net_device *dev,
 	if (ctx && ctx != dp)
 		return 0;
 
+	if (!dp->bridge)
+		return 0;
+
 	if (switchdev_fdb_is_dynamically_learned(fdb_info)) {
 		if (dsa_port_offloads_bridge_port(dp, orig_dev))
 			return 0;
-- 
2.25.1

