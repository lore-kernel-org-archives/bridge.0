Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795368829;
	b=BhWsYl4v59MjkvbhDSvZ/S86lYoqv1g3jdCvSpqt4kSMQIi1OZw8iNx5VI6EpRSk6nLp
	 GoF1Qz4q+ezywb048X3xKAGsNCTxRfIdma56VoLmm5c5owwlI+zMIDhuM2+C8tPqUCOGD
	 DkXhPwrgMhtID1x5qO4nTrMZeHNipM9XsmXeTStwR2n2/bFJ46V25VhyNmOwb+U/o5NbZ
	 KzEfUoWCjNJ0j1qFwuxNsFHZ92pIJ6IyveR9OdEU6PUHTZTJN9u9lZ5KdKSJw0RY5v4DA
	 MAeleZ9Cl6LVvLFEkDxSbYOUZ/XVcTGmjp9gm07mJeexMqqhhQVpiy0sqAje50Tf1SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795368829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0wBhVLTOMJhdiy998cb8V6v4J1DUca/LT9un/0P5QXs=;
	b=3vO8MRNEJsugQAyyn7riIVafmYi+V2TpWgAowKwryaxPQmTb6s3FO7Vzt51xUMttKofM
	 PTYXeq8THZ81a/tM3OJNmocftabeNJ4mvfIG8u2XV9PG8t1D+k3Nen0Xr/+CrObDbVpoc
	 5z0AqL8oeKl8DBvBpklKYthiC1fTNsL70frmv55l114i+nJfaaUDzCYC5DSg+7GN5c9Yd
	 /+/pS21gCsa+IPhGo5yulgPPcLVyp7FvJMQLnI3av6VXdehDX2b81qID18t2G407344Bt
	 +UAXrqajaIB9cMPsciqg+dE+RDUpXi3a1F9SmjqU70SwOBL+2NQ0oWjVh46Ituhrxkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b="dxR/UHIU";
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2C5606A32A
	for <bridge@lists.linux.dev>; Sun, 22 Nov 2026 17:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C2C5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=dxR/UHIU
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b86bbce3d1so3225466a12.0
        for <bridge@lists.linux.dev>; Sun, 22 Nov 2026 09:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1795368827; x=1795973627; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0wBhVLTOMJhdiy998cb8V6v4J1DUca/LT9un/0P5QXs=;
        b=dxR/UHIUp613LonEk49riMhbiDVzVBL8iG5UqPNB65WfKVubfwPIUOTy9IpZuqiGe6
         +eqfRojQ1uvC7NMLIXv7TTvOttgYRHJidCEc7WKKnceq0p55Egs9vXyxuxWZUi34L2ME
         AzjnO1XLCE1u9r5Cut7rigCxM9R0Hzr/uGYOoAqQzBUgJ2XZbsgN+mNRtx6EgPJdJ3td
         c6YgjwFtm/ppDZ+rlC0/vvVsanRLz+gIBl/d1f8LNQuvKNKgL+oNC9CK7xUU0ROGGRMN
         4lXmIh+mYixNtin28LIta/KtX58iKRveykoer5zQGbBpLTa5/mrL3HVKnRRmFnMSeTW8
         XmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795368827; x=1795973627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0wBhVLTOMJhdiy998cb8V6v4J1DUca/LT9un/0P5QXs=;
        b=QHK/jDIq+nCPoPIQpv+6dMub2lq68bvlmothzY5zTKrNX9rKfU7dMq0ZL3HpkPj0uJ
         dRJd5Y08HkgFOl1fv1ulMG3r8n/PUkyAZewrr0foSnE6qXInQWEfzNmAKVfJJsowJmSn
         Gy0aal9QHOBpoQKAu2t4U15kJ01MLEVQVAo4LUQWirmlEmph0xHvXjLDGLwZCzcQC3MG
         x1bbr1VIpLepEKAZcrU00AcbTzQ72CAoxW3qqofBdBT+usCrGVThxsN6v+AMB7pmYVPs
         9lEno4g5F8TJfyWr+kgKxlQXMyh2Ou8CVf5/+lpY+g9usQ5Gira4OBQb3+5KKtMup1Ah
         Ly5Q==
X-Forwarded-Encrypted: i=1; AL+hErHPfxyclVn3deaMfzvuNHBRzq1jIn1azP1s0GkpPYhIqoi+yoGIf6p+1Gm5qAWcvdR3+aTFn44=@lists.linux.dev
X-Gm-Message-State: APuU4Z/0nUOOA4Pxcb1ZoyZBzyA7LKSVQKS1Zz4ss0zdO7LH/HAC2xdt
	/FUXztkQzczNd7+ekBHAust8kc1svU/oFP4tV/6m0A5M5eSTTjNGKjXkOTDd/S6Jrg==
X-Gm-Gg: AZFdTZdL2u5uRlOrCp9XgNmSe+mONOs35KBRYRKgVh+FCsya1twWgWSBkBuJzvCy1ll
	FFGwCl4hfX1aZf9NnLZ61bHZR/lzE03wzcDx0M/h9QXomt2+rhYtlNw1yiduXupamIA2D4sJMjd
	SdOqAFzDh70HMyIh4vDmShSqxozORAmtO/OoQ78ORvd0xY/gikKPlmQdCmy3FhCJFsYmysAinEJ
	OAf3Olheq6TsF/ewkG1+K92UhbJEKOH3kfgSzacHavUfFtJzxSsKJ2b9WU+WmluxXSMvtfSjf3H
	49IlT6HRGcf5DC7ix7XYm38/iy05iiRAf+PAqF1ybAS2f9nUQFXK+G+FP6agbgO3hShmALbE2e8
	HJ7dXIuS6bWDyQEQB4lGyT45AGQkettg4wusf2+RZM3FiVXvawAK+MXOqd+q/KXwST23KVjNo6U
	MjvZ+2AYcMvK6bK96a/OhTetd55M4P2mlw5byGRt4Q8c0WCkV7URE6037RcMuq2s2Fnho4Qpbmb
	wQGJCMNWrR+MmA70zvAIBbij3Y3IR9S3+CnxTzCB+qi2BGfQrnLdcBqJWXA7NaqCsVfVy3etmll
	3DhbEMycd554F/9dc7UoQAuddVDXn5O0oyBIEe/LXNcbdbfg3Dvokiqzo5czUlPaZaRBdQeBbYh
	DgtiPjaJN6B98BqjNYYy/huOMao0dkeWfaOUeUiCOSCzxnImRxr49ejtWxWlP1mbmsKwWgMQAvn
	JyMsU6Kvp39P29Yla8uOM8PMlmrKQ26z0+DUjmOtsZHb/joVmOkbUJD/5Y3zjctpdT6fjYfTMa9
	6EOwK+Q9/0FDo/GaU6wt1+zju+0VP5hxc1b8ZXXFKt82U9GftIo687OXy09S0rjI6mCfzsYoCNj
	fpOR+9qy+I8i+5uNPuaPe5F9yPWfpL+YD5nExdJM2lD+Q4CXJCX5JqxiM7IZTu65+dIbMLxfNQn
	q
X-Received: by 2002:a05:6402:360a:b0:6b5:96e9:ae97 with SMTP id 4fb4d7f45d1cf-6ba37ea37c3mr6312108a12.34.1795368826644;
        Sun, 22 Nov 2026 09:33:46 -0800 (PST)
Received: from Desktop.tail070c67.ts.net (p200300f2471361000000000000000a27.dip0.t-ipconnect.de. [2003:f2:4713:6100::a27])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370e8adbsm4233364a12.17.2026.11.22.09.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 09:33:45 -0800 (PST)
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
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net] net: dsa: hold the device a queued FDB event is reported to
Date: Sun, 22 Nov 2026 18:33:47 +0100
Message-ID: <20261122173347.791590-1-julius@bairaktaris.de>
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

dsa_user_fdb_event() queues an FDB event on the DSA workqueue together
with the device the event was emitted for (orig_dev), and
dsa_user_switchdev_event_work() reports an added entry to that device
with SWITCHDEV_FDB_OFFLOADED once the switch is programmed. No
reference is held on orig_dev. It is a DSA user port only when the
entry is on one: for an entry on another port of the bridge, which DSA
installs as a host address, it is that port. DSA flushes its workqueue
before one of its own ports leaves the bridge, but nothing waits for
the queue when a foreign bridge port is unregistered, and a work that
runs after the device was freed reads it in br_switchdev_event():

  BUG: KASAN: slab-use-after-free in br_switchdev_event+0x41b/0x550
  Read of size 8 at addr ffff888004d00000 by task kworker/u16:0/13
  Workqueue: dsa_ordered dsa_user_switchdev_event_work
  Call Trace:
   br_switchdev_event+0x41b/0x550
   notifier_call_chain+0x9a/0x2a0
   atomic_notifier_call_chain+0x5a/0x110
   dsa_user_switchdev_event_work+0x32c/0x4c0
   process_one_work+0x8e1/0x1640
  Freed by task 139:
   kfree+0x1b7/0x550
   device_release+0xca/0x250

Hold a reference on orig_dev while the event is queued, as mlxsw,
prestera, sparx5 and cpsw do for the device of their deferred FDB
events. Unregistering the device then waits for the work, which does
not take RTNL.

DSA held the device until commit 425d19cedef8 ("net: dsa: stop calling
dev_hold in dsa_slave_fdb_event"), when the report still went to the
DSA user port.

In QEMU with KASAN, with dsa_loop given FDB operations, assisted
learning on the CPU port and a 500 ms delay in its FDB add (test-only
changes), deleting a veth bridge port right after an address was
learned on it gives the report above in 3 of 3 boots, and nothing with
this change in 3 of 3 boots.

Fixes: 93c798230af5 ("net: dsa: call SWITCHDEV_FDB_OFFLOADED for the orig_dev")
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
This and "[PATCH net] net: dsa: do not run queued FDB events after the
port left the bridge" <20261121185821.1471559-1-julius@bairaktaris.de>
both change the end of dsa_user_switchdev_event_work(). Applied
together, that patch's out: label goes above the netdev_put() added
here, so that an event it drops still releases the device.

I used Claude (Anthropic) to help write these patches.

 net/dsa/user.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 041f9060c8ef..5e72fb34e308 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -35,6 +35,7 @@
 struct dsa_switchdev_event_work {
 	struct net_device *dev;
 	struct net_device *orig_dev;
+	netdevice_tracker orig_dev_tracker;
 	struct work_struct work;
 	unsigned long event;
 	/* Specific for SWITCHDEV_FDB_ADD_TO_DEVICE and
@@ -3686,6 +3687,7 @@ static void dsa_user_switchdev_event_work(struct work_struct *work)
 		break;
 	}
 
+	netdev_put(switchdev_work->orig_dev, &switchdev_work->orig_dev_tracker);
 	kfree(switchdev_work);
 }
 
@@ -3764,6 +3766,10 @@ static int dsa_user_fdb_event(struct net_device *dev,
 	switchdev_work->event = event;
 	switchdev_work->dev = dev;
 	switchdev_work->orig_dev = orig_dev;
+	/* The work reports to orig_dev, which can be a foreign bridge port
+	 * that is unregistered before the work runs
+	 */
+	netdev_hold(orig_dev, &switchdev_work->orig_dev_tracker, GFP_ATOMIC);
 
 	ether_addr_copy(switchdev_work->addr, fdb_info->addr);
 	switchdev_work->vid = fdb_info->vid;

base-commit: af6737b9066832a2017c281159950ba92385ce00
-- 
2.53.0

