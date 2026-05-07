Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC48B361DDC
	for <bridge@lists.linux.dev>; Thu,  7 May 2026 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778161709; cv=none; b=fu6i26kGt/1kDAanYC4nyUOZV4+KeBRLwnvAyWndu0lx5wuH80op+83g/ZGFe5M6xGujmAyIS9UZALgUgW7SRxSxJ5cWiGjhlSGswJpF0cHtDG5zROMYDTOf5cgq6tgYxG16b3dYiLRYX8mzu+m/Vffo1PEm4xdG4MlcVxgbJR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778161709; c=relaxed/simple;
	bh=VFRgu2cJwqXZgxOEu/B3E6yAKtvNoFeFdDZSZ+K47YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dkn5SyZAqAzD6oHXPoXcOVy4jr/huTu6fxH/XZS8Tvf5hyHUj9v7YAsnTZ/wSISMzlMUTlgdMIWl56E4m0YJ/Bfp8gNdfxnFhvWwbA5Mns3V/GyLZk4ivGHBtGQUs0MT80nrH5MrY5X0JBORcs2iD7tH+dWOqYX7/90wQ7Kjopk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b/g0aLzE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b/g0aLzE"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so13030105e9.2
        for <bridge@lists.linux.dev>; Thu, 07 May 2026 06:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778161706; x=1778766506; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WoAsiMhHn+IE4y5ZbpU36N8ZnmK7jeWLatv0EXI80UA=;
        b=b/g0aLzEMA9k8QfxvM8H8WaUV5NxKsWMuIEsPHSFIsC+ODRkW2ei5shd+yAB3GvY57
         RGGTIRqMZjoIOGHrG2FmjwzpuL78b2ayR5tH0olIVTMtwISOtKbwQbyZLxQZmblXw7gb
         IQ0rh8XcC30rVsi9HOfFrpY6NOIeqh+7Em1Xbjx/LsSxhfyK7MKh1SDta1z2hX02ePnz
         o7d00/CeIlqycjkn7N2N9hQVVQ71ubsjqHnoUCXrOEyH6vK9CigGpmVFnPXINlxVNm02
         bnzE+keU1MJQZAydykCMaPKIA8NTK/DViRJU9+2cV8UMfegqovDh9hHWwoYdge/7jCN+
         2zgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778161706; x=1778766506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoAsiMhHn+IE4y5ZbpU36N8ZnmK7jeWLatv0EXI80UA=;
        b=b69Hzw0+Z181NEFOuIEp92WxGjOjUMcWXYRo7WcIYyH1BRLEAx2U4uYm54g2obLIzm
         V/X/iYoLp7y5i7RXnAPkAaRBOJQOXSwOECbO2JhTfsSHQ4p9cqAK5jEfu0wXlHue5MDb
         PHmkBtDaP6z+cDM3fdYtUWeawVP9+26RZvKlKTW/HVCFLCkDTWhvvCTN5P9/XsRJ6+eB
         WtSKdvQXU99DyGac7CbACvPHMq8yD4lnvK1/R4hQ/U2QyIRioU0ql6onT5jjGFYTCM7O
         1sWZUzyZDJ8pPGMtZ5jYISddmPmK7StSGLJlBj9JyCtLQVAI1mX3L+I5rXx8qVgbnUnc
         MOKw==
X-Forwarded-Encrypted: i=1; AFNElJ8Yn/YWSQw9Gex+9AiXhh1ZuLLC9/OUhPrN+3bgfUZuHUc0sOwk8bILkfmKa4HHaUJJ4A8Op0g=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw75NP7nd1t87NLWH5p1qdHk+YQGKemE3as2tmYzWNmrK9eVHYB
	MemlnMgJUVFFzriQQvWXd2j++PT1agjG0j4CkcmiIF63VKT7CSyhoOHlG2PhWZyhhqw=
X-Gm-Gg: AeBDiesXL1UIrPk8K3KQy2j5WKb3q5Z9hV85RRDSVgwF9gPzSCnnEgwGJH05LzliVVX
	fHw8PlAmUrIROcx65AEckZPgHcSU2GrokdGUarGPdcZJBvzoB9j89OegqYBUn4KGAe0LiZjJqlM
	jdoENgmba/04IE7wEwHQ5tDI6uGhKPiuVBwJEp8Ifw/rNDysJOINzkBYPaxvfpIBIDzKZSkttuS
	G1lU6xWFbRdmLKMBlS4zqtXCguoICFC+JTc9OrejAoFkaGDcqqrFcaCCMHbl4Og2Et05uaIngFM
	u4eIJ/xqX5ni+LV5YUtw3TmVn/UF4ZY/Mq0qaWTV3YKpBRf6lPEOooszEo/0ywRrE6aj6jg1x32
	XMf3d+Bs3O8z5E57EtcV94+hAN7O0XtEtKLMtt2S3wjwv5fBN5Qa8ZzvaHbFRtcKRp6hum2xGMf
	S6ThavHuRWoEO9rKikHuZ9FyllirNVRqdXQpyNJkiDl8/HPi+XQn2x4byD9A==
X-Received: by 2002:a05:600c:c494:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-48e51f32c35mr127316915e9.13.1778161705907;
        Thu, 07 May 2026 06:48:25 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e52f5c1cfsm82872855e9.0.2026.05.07.06.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 06:48:25 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Simon Horman <horms@verge.net.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [RFC PATCH net-next] net: bridge: Move long delayed work on system_dfl_long_wq
Date: Thu,  7 May 2026 15:48:15 +0200
Message-ID: <20260507134815.295588-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently the code enqueue work items using {queue|mod}_delayed_work(),
using system_long_wq. This workqueue should be used when long works are
expected and it is a per-cpu workqueue.

The function(s) end up calling __queue_delayed_work(), which set a global
timer that could fire anywhere, enqueuing the work where the timer fired.

Unbound works could benefit from scheduler task placement, to optimize
performance and power consumption. Long work shouldn't stick to a single
CPU.

Recently, a new unbound workqueue specific for long running work has
been added:

    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")

Since the workqueue work doesn't rely on per-cpu variables, there is no
obvious reason that justify the use of a per-cpu workqueue. So change
system_long_wq with system_dfl_long_wq so that the work may benefit from
scheduler task placement.

Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 net/bridge/br_fdb.c    | 2 +-
 net/bridge/br_stp.c    | 2 +-
 net/bridge/br_stp_if.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index ac81e58d5f70..14c7943d59a1 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -583,7 +583,7 @@ void br_fdb_cleanup(struct work_struct *work)
 
 	/* Cleanup minimum 10 milliseconds apart */
 	work_delay = max_t(unsigned long, work_delay, msecs_to_jiffies(10));
-	mod_delayed_work(system_long_wq, &br->gc_work, work_delay);
+	mod_delayed_work(system_dfl_long_wq, &br->gc_work, work_delay);
 }
 
 static void br_fdb_delete_locals_per_vlan_port(struct net_bridge *br,
diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
index 024210f95468..426e1c76ef6e 100644
--- a/net/bridge/br_stp.c
+++ b/net/bridge/br_stp.c
@@ -640,7 +640,7 @@ int br_set_ageing_time(struct net_bridge *br, clock_t ageing_time)
 	br->ageing_time = t;
 	spin_unlock_bh(&br->lock);
 
-	mod_delayed_work(system_long_wq, &br->gc_work, 0);
+	mod_delayed_work(system_dfl_long_wq, &br->gc_work, 0);
 
 	return 0;
 }
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index 28c1d3f7e22f..7a5f4747e1a1 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -53,7 +53,7 @@ void br_stp_enable_bridge(struct net_bridge *br)
 	spin_lock_bh(&br->lock);
 	if (br->stp_enabled == BR_KERNEL_STP)
 		mod_timer(&br->hello_timer, jiffies + br->hello_time);
-	mod_delayed_work(system_long_wq, &br->gc_work, HZ / 10);
+	mod_delayed_work(system_dfl_long_wq, &br->gc_work, HZ / 10);
 
 	br_config_bpdu_generation(br);
 
-- 
2.53.0

