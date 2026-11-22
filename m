Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795369477;
	b=Fef6rtRiDJZEEZgZxiIMySU+VVcdZn4cAp21tJcRwoyy7Zmm6ejK6F/6PUybUKm8vdJr
	 byGK+iDTogPgeH1Xm3djYIxVkpaP+39Km9YDwc3bVc2dxRnofMKnu1xyanURcqORtROMG
	 wFGmQdqj0PBu+hidXHo4q4dFlrSok6VL8YhpaZdfZ2M97WtE7BN2O9ooWTua2ZgIZIHbz
	 mty4CVKnF+tmb8M55YoX6bi4iuwsw6quXrfRE+LSH8Eh9YHCvFrvl+670WKvlkP/c5LMs
	 5whMd6n1A1pHoGq+dntyRsrxIKSyXxUH8OsZuJJk2jdEfXSW22/QG5Pwwqt/ZnVTNoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795369477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cLbZ9xw43NyHfpQP28G4sSIRyISVnGyD/qZutlGH6h4=;
	b=BtUDUMJaBdJEiAZGTWonp0HdxQm6WLe3fse2dYuay/NzZSAwuCDgbfpciEkSZKaFHoxi
	 9f5I5rMvx7+ENwnwAuIeRvo6ha6Yv2PfNskHEYB/VewJU/ZAts484vfPqFCq0Dn/3RkhI
	 12vtEClVzm4L9o4v9rA0yDjJEpKP4j22A8PIYKeAB6ts46YI/7Zw9J7ZHyDxElBXhOL0T
	 JG6IVfmx9aqqglMu3YnnALM8TCh3Dmb8vo96SJRzr/kSjDJRZrVCqHG/LUtnNQFsejAx7
	 n6NVM3bddYfOfLpnE3ScqJOvnSkyTRhaxTGl0GNUMICKQi/xG3B1dXdggsICAJIpqiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=FR4bKocE;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1AC606A6B6
	for <bridge@lists.linux.dev>; Sun, 22 Nov 2026 17:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B1AC606A6B6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=FR4bKocE
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c5126505cb3so325810666b.0
        for <bridge@lists.linux.dev>; Sun, 22 Nov 2026 09:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1795369473; x=1795974273; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cLbZ9xw43NyHfpQP28G4sSIRyISVnGyD/qZutlGH6h4=;
        b=FR4bKocEqwZbB2Z11oBcnWsqMkosfkEtrRjgRANlB6xWbhM4UY5kMXZDZOPjk3/pRO
         n+syCQ6ETG93M3+AmzgpERfcU9yprP+iweyGvCMUvWBTn7Hm0KulcHNEbuGy0vKY2lXe
         o/Ku9a/U38hicqpZ0XWqqfIjO1ydyPRCKCBkEjWa7xLaEvWpnT+zpnJytiDicaV80nhi
         huUdtY0t5USOpTJccWKzEyLnuWJn5NyNRN4nxEvcMCkGgGLwvCtqHrfUxgfPNFXyxm4R
         C/K1w+oMyg4U4+Lqv3WCKGU5hmEiQf/pmrF3sMTEfyqkVozlWW4CGT8YViLpEnW1fZOl
         j3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795369473; x=1795974273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cLbZ9xw43NyHfpQP28G4sSIRyISVnGyD/qZutlGH6h4=;
        b=swwj1BrtHzO/eWHqqNAV61+8IBreosDfshj5AUjkjdyvnlwvIZJo8jgMb/Rq3iL4tV
         MDx6KJE6u4S+7649iEivUwhNwWo5CTWntsR5zNVbPSksql2y8l903B2jl07kflLnM2KB
         QBIEVtHFYTUA4GPKU1/VrTTtPWo0fhngmI84DBssEJkgWgqSvbbN/Ji9M/YoenpbORUl
         TNSjQAOujL7Q326NDWSPcD5jff+F47VBJWnWz0wwZrdL3qb5mFws3NDIREhTVOKARYvL
         eO2afNXTA0Zw3YRBT4koLHnc3e46cG8AskK6lbnhRFajbV9Ww5v3SKLDAHED5bHPTANV
         dhtA==
X-Forwarded-Encrypted: i=1; AL+hErFUqwrrL8J1oe112pN9xX3BHHA/tF1u64cL7e1UMUHpiiEmSYrZYFCMLxyd/iSYCEcuvQq5ddw=@lists.linux.dev
X-Gm-Message-State: APuU4Z+M0bBGMInRY+opVoxqj0zfF74YaCzqxbODWATm/ZDgL1QQoyW2
	I2E1DcIcUMZeNP7q3u87trTre3fKD8fAZE7BL/4spu8QEb0rOyQ7HCysRu82BMpAhw==
X-Gm-Gg: AZFdTZcVk3Ym2x+N4WSPu8IF0WRfOLOcTgLmvrLuBkRhzocYpMMxwF+qKOPD+dHNb6j
	bwATd+iwisuleNj1V/Kb5xnFNvHalPJ8wQQZVvzuOHhrfN3iDNOvy9O/3ZqsUVhsRNZo+mL3n6n
	4N2j/kPHv/mg/Hcp3BoTkZLjlzdgTriRdbNrw+K2giJJqiTThVmXAaBCoZaK8FJ0Z+qtWFXpbEj
	YvhxUPDaq6yWgt8zQdYoGE47DndhYJPIKLmv6+nCjL7d1Z7vyetRcvW7vvSVzYcmpfgurzzxHjz
	zzrsI9yOYp06WVdrDMiKFmoP0XMNNUszx+xmZ6okMTFfeyiJlWmT3YzmQXabz3ofG/AG2lPdlcR
	9GKii6TnQmjuYc8DA6OJHAFeWxDEwQNU721dlZtPLjCX+VPHETzw7rDVE4DzPrG7f+9B7m9rLjj
	tRiE5DSsRNKISCIu8Fghxavr+rtnjTh4RnXhDbdERGot0YasqpnWNx73OBsXLyHjHWKPmr2Ydys
	gC3x0PKU4I6+3SFwh067z0zEGr8CRiMzzL5ZG90juSHAfWjcDpQUQiwdOw/xsFZarrrtfYaW2Df
	QSTIKC3W8G+PYPCGtOOqJBkh71KS/D/mRP95mhZWWNmEFMVv05QJwjTuz/yBbf01lQ9H7Auk5t5
	97aOcPjYKHE2EAlYLwEyh42m3MoFNMXhMxFw3EQE/a9m2r+SY28E/EwtAN32j9mX0/ky28Nys/S
	d/yeU+F5SlbCyS0eR/xfCUKNlOLXIagIfHJ19w+jwI51AOJzWk1POs5fsi0Kj71/Qnd1VcMhu/q
	+ROV8LC4sr7OlcY1GuQuV7XkmhVALlEd7aknkiP6rlevNWmRvJsSePW3xyT+N+gFIt+BE9ZzOqf
	rDrEzxTpt7NrobwszqC/CjgMIAtvKy2l68MGYTsJ++6HvLcke2hOOgGSUJ0Sf5QQ76EPSAYuNhU
	=
X-Received: by 2002:a17:906:66c1:b0:c50:5ee3:e5d8 with SMTP id a640c23a62f3a-c513aaffcfcmr587681866b.24.1795369472716;
        Sun, 22 Nov 2026 09:44:32 -0800 (PST)
Received: from Desktop.tail070c67.ts.net (p200300f247138e0029c66979a611ac3c.dip0.t-ipconnect.de. [2003:f2:4713:8e00:29c6:6979:a611:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513b001172sm336293466b.79.2026.11.22.09.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 09:44:32 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next] net: dsa: report a deleted FDB entry as no longer offloaded
Date: Sun, 22 Nov 2026 18:44:34 +0100
Message-ID: <20261122174434.975426-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dsa_user_switchdev_event_work() reports SWITCHDEV_FDB_OFFLOADED with
offloaded=true once it has added an FDB entry to the switch, and reports
nothing once it has deleted one. The bridge sets BR_FDB_OFFLOADED on the
entry when it gets the report, so an entry that the bridge keeps after
DSA deleted it from the switch is still shown as offloaded, and matched
as such by "bridge fdb flush ... offloaded", while the switch no longer
holds it.

The bridge keeps such an entry when the address moves: an address
learned on a foreign port of the bridge, which DSA installs as a host
address on the CPU port when the switch asks for assisted learning, is
deleted from the CPU port when it is then learned on a user port, where
DSA does not install it. The flag is also left set when an addition is
still queued while the bridge withdraws the entry: the work items run in
order on the ordered DSA workqueue, so the addition reports the entry
as offloaded after the bridge withdrew it, and the deletion queued
behind it reports nothing.

Report offloaded=false when a deletion the bridge asked for succeeds.
Such a deletion reaches every DSA port that can hold the entry: the
user port it is on, each port of a LAG, or for a host address each user
port in the bridge. The reports come from the work items in the order
the switch was changed, so the last one for an entry gives the state
the switch was left in. A deletion replayed for one port that leaves
the bridge or a LAG is not reported, since a host address or a LAG
entry can still be held for the other ports. When the last port of the
switch leaves, the flag of the entries it held stays set, as before.
DSA's reports are ordered against each other, not against those of
another switchdev driver in the same bridge: a deletion still queued
here can clear the flag that driver set on an entry re-created on one
of its ports, as a queued addition could already set it.

The addition has been reported since commit c9eb3e0f8701 ("net: dsa: Add
support for learning FDB through notification"); a deletion never was.

Found by an LLM review of v1 of "net: bridge: withdraw the
switchdev entry of an fdb entry made dynamic".

In QEMU with KASAN, with dsa_loop given FDB operations and assisted
learning on the CPU port, and a tc mirred redirect that delivers frames
to a dsa_loop user port (test-only setup): an address learned on a veth
port of the bridge and then on the user port, and a static entry on the
user port that is deleted while its addition is still queued (dsa_loop
delays it by 500 ms) and whose address is then learned on that port, are
both still shown as offloaded without this change, in 3 of 3 boots
each. With it, neither is, in 3 of 3 boots each, and a host address
that stays on the CPU port when one of two user ports leaves the bridge
is still shown as offloaded, in 3 of 3 boots.

Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
This depends on "[PATCH net] net: dsa: hold the device a queued FDB event
is reported to" (https://lore.kernel.org/netdev/20261122173347.791590-1-julius@bairaktaris.de/,
the prerequisite-patch-id below), which keeps the device alive that the
report added here goes to.

Trigger: an address that DSA installed as a host address moves to a
user port, or an entry is withdrawn while its addition is still queued.
Impact: a wrong "offload" flag in the bridge's view only. CVSS 3.1 0.0.
Until the fix: the flag goes when the entry is deleted or ages out.

I used Claude (Anthropic) to help write these patches.

 net/dsa/user.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 5e72fb34e308..7bcf8d3b5fcd 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -44,6 +44,7 @@ struct dsa_switchdev_event_work {
 	unsigned char addr[ETH_ALEN];
 	u16 vid;
 	bool host_addr;
+	bool replayed;
 };
 
 enum dsa_standalone_event {
@@ -3629,13 +3630,14 @@ static int dsa_user_netdevice_event(struct notifier_block *nb,
 }
 
 static void
-dsa_fdb_offload_notify(struct dsa_switchdev_event_work *switchdev_work)
+dsa_fdb_offload_notify(struct dsa_switchdev_event_work *switchdev_work,
+		       bool offloaded)
 {
 	struct switchdev_notifier_fdb_info info = {};
 
 	info.addr = switchdev_work->addr;
 	info.vid = switchdev_work->vid;
-	info.offloaded = true;
+	info.offloaded = offloaded;
 	call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED,
 				 switchdev_work->orig_dev, &info.info, NULL);
 }
@@ -3668,7 +3670,7 @@ static void dsa_user_switchdev_event_work(struct work_struct *work)
 				dp->index, addr, vid, err);
 			break;
 		}
-		dsa_fdb_offload_notify(switchdev_work);
+		dsa_fdb_offload_notify(switchdev_work, true);
 		break;
 
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
@@ -3682,8 +3684,13 @@ static void dsa_user_switchdev_event_work(struct work_struct *work)
 			dev_err(ds->dev,
 				"port %d failed to delete %pM vid %d from fdb: %d\n",
 				dp->index, addr, vid, err);
+			break;
 		}
-
+		/* A deletion replayed for this port alone, as it leaves the
+		 * bridge or a LAG, can leave the entry held for other ports
+		 */
+		if (!switchdev_work->replayed)
+			dsa_fdb_offload_notify(switchdev_work, false);
 		break;
 	}
 
@@ -3774,6 +3781,7 @@ static int dsa_user_fdb_event(struct net_device *dev,
 	ether_addr_copy(switchdev_work->addr, fdb_info->addr);
 	switchdev_work->vid = fdb_info->vid;
 	switchdev_work->host_addr = host_addr;
+	switchdev_work->replayed = !!ctx;
 
 	dsa_schedule_work(&switchdev_work->work);
 

base-commit: eb6d6c80d35449c27471b1874f13066c09a8964d
prerequisite-patch-id: 7d26d57478287c871bcb5eb5837534cf4a2b48a3
-- 
2.53.0

