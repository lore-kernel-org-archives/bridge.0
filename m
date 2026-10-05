Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFCB4908A6
	for <bridge@lists.linux.dev>; Mon,  5 Oct 2026 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211216; cv=none; b=bJv6VHpEIP660No6v8Lv4zHfwNAyvBnNP0IkGQn7T+D4a9nLyP87Uj8llvdc9pzY4TEjCtZ2XNcQ7CMuwd/pzpkGC4Vp4exyOKzf62THRIP+VJrXgRGSDCqWyzXwsT27aHcNx3dDpQ3hbzrKpn4j56irvQR9BZC55JA4FpqGp+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211216; c=relaxed/simple;
	bh=H8zWpkte+IOGXQWFkinQYrDB24Tm5Xwfoc8Gd9TV/vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTDfbWHDTx33GzBjIo1HGruMteMWAY9VVVR2aaRuwhVZ5luc+yhDcAJw6wRvvasfFgxBIeS+hW9yyI9M4BHKNyL0Wy0PsMAs+GQzIHTr3vtR49CkG+4/EFedGxrhluRCnLskD00RI0rKsggyqCE1AG/L1IbNqv9ZX0i2FhMix7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=BirsCfWU; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="BirsCfWU"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48afd5b1678so1102984f8f.2
        for <bridge@lists.linux.dev>; Mon, 05 Oct 2026 07:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1791211197; x=1791815997; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wgLhbPYJl1k11TkewywLYOwqHseFbWKlBdyOUhqVzJc=;
        b=BirsCfWUv2qjnh7Zq/BeVvbPt0sAWw6mGWkRid6F9hKUVp8DgIZUTJdPep9f05b/jY
         y3/Uk0DHnBknxt5EtY2kAJNByTCJUEtGLDxBYc6Zl41PGgXCSrAC/57RbTVWpVDHdEr5
         FOKMBGf1DWxjDiZXufjJTHByXGYSclX2spU/N4+m/2BX+RnFjRMUyawAs0KMbFM5EfLm
         eFS3yO3d4AP8TloSaT3A5qtYAk3TkEReY/u1jFznMkKJON2x1XOObIZ+4kAV18l2tbMR
         cLv2xcIaYcaEN1LVUUIN3rcKjVogs3N4WzmjUmcwQ6uZ4HXW2by8NbZ+9+xJ2Kg2+f+0
         n9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791211197; x=1791815997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wgLhbPYJl1k11TkewywLYOwqHseFbWKlBdyOUhqVzJc=;
        b=fz4OTb2qC90YttR5/29mY57w/qZfzMKXqIHEyENATR4dksbt9+oT13iZ3qCHuCpZ2A
         2KRVDCrTLYt6Y5CkDWYa8FzrP1YGwqH8jDP6/NFjfBeMywzb7GGiKKPJUCmrWMXLCg43
         AKd6CDbFaxiVtYpVOgenVbLnh/axnDbv+Cf9HH9T0+9yMlQ0aMs2uFaQGOUWWgQWVcVP
         G86MKwu77FG79rXwwe45RH/TjH6BnbtewCJb9V6eaBuLlRfIEhEfiy7aEhRYxwFa7z9D
         RBzD5BrCS8q5Z3spMYybjCVTu88Wo/WUsnlcZ+C1l8vYMDZPZG6KEpv33Fsg7zMARk8S
         fHog==
X-Forwarded-Encrypted: i=1; AKwUvBzLF03tGYY1ZHYja7fW7bQd9zH/o9sHY0teznNVjAm0Nqn0ZE0Hw1eVvj3KOLiJNOjxX6e0VYg=@lists.linux.dev
X-Gm-Message-State: AFq9FYJXPLD1bCpBtaSo0ch1M1f87RKpNeUsWLzws//fkhG3o/PcAi7J
	gmzx5RqPJyvVLb78lJh/S46PrhOcyEaimttMSQGfuNzSdED1+u3Vxi+rU17jmhI5tjY=
X-Gm-Gg: AYBFou24vex8wgdIIRpafmV8R/QUgGMIbI4GzYedddXXEJpt51G0llgV1y7gWMKF8Bx
	hQJ3seHkHKmP01P6PNI7gdGYEOmiVjwd9jxBDzeblWlrtUUs7TFr3rBmob8YI3uM9IC4CABfL7L
	F+bJBz+9Y2dl8ektF/nn5radxTejhjiv02zK6jribht86UXiXgz/0rJXgtx/Ilk7/u+WF34axua
	hFOwM6Ckel6Z6MRdVPNhwLLIil6W6HTZTEr8xc+k67H6icW6xbPpE1C4SXcyql8Hw0ze/0OIkNA
	Ms8F1Lrw9ewyEcWbVkzj7aeLykewTKlJPw2WzfGz6oxGDeDRw55VqOjnSVCxgxmcEcv4Er1S941
	IT2dsennUixkadN2ATC5X8O+2sO3XJsFYYGehFCPF7wL8tHBTDW3dsOSjbo/c9fpMW9edG2yyUJ
	XBljPAgCDae+DZqUfi9izhFmHjOvI6pxqDLG4PvlRuH1tufzIObhChIVDahOjaJX64p19duNv33
	5KV5FmPgp0YidmUwyA7
X-Received: by 2002:a5d:6f0a:0:b0:48c:4f83:f42f with SMTP id ffacd0b85a97d-48c4f83f5bbmr12807658f8f.8.1791211197624;
        Mon, 05 Oct 2026 07:39:57 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48c642b42d6sm2910942f8f.9.2026.10.05.07.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:39:57 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 3/6] net: bridge: vlan: share VLAN validation in br_should_learn
Date: Mon,  5 Oct 2026 17:39:34 +0300
Message-ID: <20261005143937.877466-4-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005143937.877466-1-razor@blackwall.org>
References: <20261005143937.877466-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both the pvid and tagged paths now resolve a VLAN entry. Select the entry
first and share the state check and output assignment.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_vlan.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 0675f74cf1b9..dcf783e1a440 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -742,21 +742,16 @@ bool br_should_learn(struct net_bridge_port *p, struct sk_buff *skb,
 	if (!br_vlan_get_tag(skb, &vid) && skb->vlan_proto != br->vlan_proto)
 		vid = 0;
 
-	if (!vid) {
+	if (vid)
+		v = br_vlan_find(vg, vid);
+	else
 		v = rcu_dereference(vg->pvid);
-		if (!v || !br_vlan_state_allowed(br_vlan_get_state(v), true))
-			return false;
-		*vlan = v;
-		return true;
-	}
 
-	v = br_vlan_find(vg, vid);
-	if (v && br_vlan_state_allowed(br_vlan_get_state(v), true)) {
-		*vlan = v;
-		return true;
-	}
+	if (!v || !br_vlan_state_allowed(br_vlan_get_state(v), true))
+		return false;
 
-	return false;
+	*vlan = v;
+	return true;
 }
 
 static int br_vlan_add_existing(struct net_bridge *br,
-- 
2.47.3

