Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=KISU59S6Jwk96Vv5F0HE6moYC8ByOnQ/kZMSyIcAkPw=;
	b=cujpwfDBeMBwlKZHu3RN3jBIsCN2+huX0KIGZGSG+/3/DcowfSbMHY6/F89E2JITGZ
	Hl3SfoNRp6sAALCwaFVkg1/MbFz7FlS98R68SetyPoNl49PE4h9/uDXDTr8wSlmavvKF
	taNv0Ig3w/cMwBl2VzITIfETeJD09psSnp4Zc=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Sun, 30 Dec 2018 14:33:20 +0200
Message-Id: <20181230123320.32484-1-nikolay@cumulusnetworks.com>
In-Reply-To: <663bc6d0-f6ec-796d-54bb-b9afa3c0bce1@cumulusnetworks.com>
References: <663bc6d0-f6ec-796d-54bb-b9afa3c0bce1@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net] net: rtnetlink: address is mandatory for
	rtnl_fdb_get
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, David Ahern <dsa@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, davem@davemloft.net

We must have an address to lookup otherwise we'll derefence a null
pointer in the ndo_fdb_get callbacks.

CC: Roopa Prabhu <roopa@cumulusnetworks.com>
CC: David Ahern <dsa@cumulusnetworks.com>
Reported-by: syzbot+017b1f61c82a1c3e7efd@syzkaller.appspotmail.com
Fixes: 5b2f94b27622 ("net: rtnetlink: support for fdb get")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/core/rtnetlink.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 48f61885fd6f..5ea1bed08ede 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4104,6 +4104,11 @@ static int rtnl_fdb_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
+	if (!addr) {
+		NL_SET_ERR_MSG(extack, "Missing lookup address for fdb get request");
+		return -EINVAL;
+	}
+
 	if (brport_idx) {
 		dev = __dev_get_by_index(net, brport_idx);
 		if (!dev) {
-- 
2.19.2

