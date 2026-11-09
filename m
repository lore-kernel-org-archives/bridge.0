Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193125;
	b=cwnYcupBkTZmFmhaNGynRHOdPWxJBjNEQHBbV+1Hjs6BtHkkutoEcJRI8NbEZFBl/HyB
	 +fLLsJbwNrMpQnsG1GKP82kmP/A02Ckb13OKcjssdQa9rI0psAvLgvSu9ls8DYAhq1jaM
	 S3/2tCuwOELJBjc0AI1rgH0DaNaOYhhvv/Gqg0vkSXALnHX44ItP2N1bqVah60P3DBT/2
	 vJLXS6BzrP+sz6Qz+z28wjJrOWke5n/MiKrEg+aE6Z4BSeHR7pd4PeITfICf3rUuyXui0
	 9KxJBOW3SqXxiAcdui1XBheoU1XxviZhli7v60wNBRs5uBg5G+qaLsOB6kQD2ZCLXUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193125;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yphr/xiIDRgmCIjQY3JvfmHV8o2HtJ/A7EORNX9HaRg=;
	b=UgAb0tmc5JsGNK7tSfleUD051nm17rqVWkYuVpb9Klq4nJanih2nIDq8z9MHHeGjSjaN
	 3k5O/JDFDrrFlf/ZMPYMLLDIr9yQajrDDWcmy++q+4j30F3h2wO/FBADJGovVPZCLLC1v
	 IjShqT6mjJQX6HkzHY57KzOlu7zingF3H/z4pQ8j6ZybbFdET8GEKZCJl4LM7s5uZaJ+6
	 6ZNr3Z0VPmYfymIR14icTLNVaLz50AfO81+4+WKo8VBYRe8bxuEXGllDDXLdSPkHwgFTp
	 dBWuAAcybo/xy2isxhxbvwTfQyfjCqbG+HaurP1gL+iDncQapdAxIAXWVp4ZsbeqVfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FSPwdPT5;
	arc=none smtp.remote-ip=91.218.175.181
Received: from mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FE2606A32A
	for <bridge@lists.linux.dev>; Mon,  9 Nov 2026 02:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48FE2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FSPwdPT5
X-Envelope-To: bridge@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=96rAeUWmnzHN6yth5vv/wCTrXAV8exvh1VkI3YdM/T0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794193122; v=1; x=1794797922;
 b=FSPwdPT5dTGic4pY9LBjBaB5dut9cna9HmtiO4CIZPwehWLvelm8KsWiqfsq46ib8/amyH3N
 S5K02wwnFyCe9vXoO6pP4N5M8gOSfmuS/Top0M1Ygjap+sLL6gVo5nVxLr4c6cS6Wd6jzr68HJy
 AajJzFBXp/hmjxu2X2Ykgi+I=
X-Envelope-To: bridge@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 95288f8eb6e1ae45;
	Mon, 09 Nov 2026 02:58:42 +0000
X-Mizu-Trace-ID: 95288f8eb6e1ae45
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Paul Moore <paul@paul-moore.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Julian Anastasov <ja@ssi.bg>,
	Allison Henderson <achender@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-security-module@vger.kernel.org,
	mptcp@lists.linux.dev,
	lvs-devel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-sctp@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH net-next 08/14] rds: annotate data-races around core rds sysctls
Date: Mon,  9 Nov 2026 10:52:07 +0800
Message-ID: <20261109025425.328445-9-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109025425.328445-1-jiayuan.chen@linux.dev>
References: <20261109025425.328445-1-jiayuan.chen@linux.dev>
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

reconnect_min_delay_ms, reconnect_max_delay_ms, max_unacked_packets,
max_unacked_bytes and ping_enable are read without any lock while their
sysctl handlers update them with WRITE_ONCE(). Add READ_ONCE() to the
readers.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/rds/recv.c    | 2 +-
 net/rds/send.c    | 8 ++++----
 net/rds/threads.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/rds/recv.c b/net/rds/recv.c
index 00ab60f2d9969..daccbfc8cb8a2 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -370,7 +370,7 @@ void rds_recv_incoming(struct rds_connection *conn, struct in6_addr *saddr,
 	}
 	cp->cp_next_rx_seq = be64_to_cpu(inc->i_hdr.h_sequence) + 1;
 
-	if (rds_sysctl_ping_enable && inc->i_hdr.h_dport == 0) {
+	if (READ_ONCE(rds_sysctl_ping_enable) && inc->i_hdr.h_dport == 0) {
 		if (inc->i_hdr.h_sport == 0) {
 			rdsdebug("ignore ping with 0 sport from %pI6c\n",
 				 saddr);
diff --git a/net/rds/send.c b/net/rds/send.c
index f38967f65af18..66e75a382bcc7 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -87,8 +87,8 @@ void rds_send_path_reset(struct rds_conn_path *cp)
 
 	cp->cp_conn->c_map_queued = 0;
 
-	cp->cp_unacked_packets = rds_sysctl_max_unacked_packets;
-	cp->cp_unacked_bytes = rds_sysctl_max_unacked_bytes;
+	cp->cp_unacked_packets = READ_ONCE(rds_sysctl_max_unacked_packets);
+	cp->cp_unacked_bytes = READ_ONCE(rds_sysctl_max_unacked_bytes);
 
 	/* Mark messages as retransmissions, and move them to the send q */
 	spin_lock_irqsave(&cp->cp_lock, flags);
@@ -380,9 +380,9 @@ int rds_send_xmit(struct rds_conn_path *cp)
 				set_bit(RDS_MSG_ACK_REQUIRED, &rm->m_flags);
 
 				cp->cp_unacked_packets =
-					rds_sysctl_max_unacked_packets;
+					READ_ONCE(rds_sysctl_max_unacked_packets);
 				cp->cp_unacked_bytes =
-					rds_sysctl_max_unacked_bytes;
+					READ_ONCE(rds_sysctl_max_unacked_bytes);
 				rds_stats_inc(s_send_ack_required);
 			} else {
 				cp->cp_unacked_bytes -= len;
diff --git a/net/rds/threads.c b/net/rds/threads.c
index 639302bab51ef..115fcff0a5b13 100644
--- a/net/rds/threads.c
+++ b/net/rds/threads.c
@@ -137,7 +137,7 @@ void rds_queue_reconnect(struct rds_conn_path *cp)
 
 	set_bit(RDS_RECONNECT_PENDING, &cp->cp_flags);
 	if (cp->cp_reconnect_jiffies == 0) {
-		cp->cp_reconnect_jiffies = rds_sysctl_reconnect_min_jiffies;
+		cp->cp_reconnect_jiffies = READ_ONCE(rds_sysctl_reconnect_min_jiffies);
 		rcu_read_lock();
 		if (!rds_destroy_pending(cp->cp_conn))
 			queue_delayed_work(cp->cp_wq, &cp->cp_conn_w, 0);
@@ -156,7 +156,7 @@ void rds_queue_reconnect(struct rds_conn_path *cp)
 	rcu_read_unlock();
 
 	cp->cp_reconnect_jiffies = min(cp->cp_reconnect_jiffies * 2,
-					rds_sysctl_reconnect_max_jiffies);
+					READ_ONCE(rds_sysctl_reconnect_max_jiffies));
 }
 
 void rds_connect_worker(struct work_struct *work)
-- 
2.43.0

