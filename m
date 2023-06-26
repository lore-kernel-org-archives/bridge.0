Return-Path: <astrajoan@yahoo.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D372160B99
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 77A6160B21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1687758624; bh=YSPfpiwOkBQ46XmUoyeSet/T0M+S11yQNJsZwzaMjfg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=iSwh70zPOJBOQnKaziyB5LolyzqpikN5M1m9tMyTLVltyv3Cxt+lo3W2+wWpqzbj2bamHgx9gIjE1TLjQSeZpvPy9hbRVofxO0DRBTABPMfcCrwYHBz8QxvmHRPf49VRSAlm3ilnd/ESSvBg7Bsyj8ESKhpgk7nwvTG/12S0g2f7+lOy7+L8mip/vpi7myVihS/Wjp155/ClXDePzmLv+m80J/ikiOWI0RyGODnWx656kC6cbhp49js3Y/Ye4FV/7/TgcellX++wQlbeukXzAOjlhOancO5U2BM1ueOT6P1ZPybm2lNpXGFrx18vsL2pUPnzIZRtd9Y4dYabwoTAGg==
From: Ziqi Zhao <astrajoan@yahoo.com>
Date: Sun, 25 Jun 2023 22:50:04 -0700
Message-Id: <20230626055004.29303-1-astrajoan@yahoo.com>
In-Reply-To: <CAD-N9QXZFMFGp3Vw4449Bx1-ttDVSF3hiwSw=e6+D096UDNfvw@mail.gmail.com>
References: <CAD-N9QXZFMFGp3Vw4449Bx1-ttDVSF3hiwSw=e6+D096UDNfvw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH] can: j1939: prevent deadlock by changing
	j1939_socks_lock to rwlock
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: mudongliangabcd@gmail.com
Cc: ivan.orlov0322@gmail.com, arnd@arndb.de, roopa@nvidia.com, astrajoan@yahoo.com, bridge@lists.linux-foundation.org, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, edumazet@google.com, nikolay@nvidia.com, netdev@vger.kernel.org, syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com, kuba@kernel.org, skhan@linuxfoundation.org, pabeni@redhat.com, davem@davemloft.net

The following 3 locks would race against each other, causing the
deadlock situation in the Syzbot bug report:

- j1939_socks_lock
- active_session_list_lock
- sk_session_queue_lock

A reasonable fix is to change j1939_socks_lock to an rwlock, since in
the rare situations where a write lock is required for the linked list
that j1939_socks_lock is protecting, the code does not attempt to
acquire any more locks. This would break the circular lock dependency,
where, for example, the current thread already locks j1939_socks_lock
and attempts to acquire sk_session_queue_lock, and at the same time,
another thread attempts to acquire j1939_socks_lock while holding
sk_session_queue_lock.

NOTE: This patch along does not fix the unregister_netdevice bug
reported by Syzbot; instead, it solves a deadlock situation to prepare
for one or more further patches to actually fix the Syzbot bug, which
appears to be a reference counting problem within the j1939 codebase.

Signed-off-by: Ziqi Zhao <astrajoan@yahoo.com>
---
 net/can/j1939/j1939-priv.h |  2 +-
 net/can/j1939/main.c       |  2 +-
 net/can/j1939/socket.c     | 25 +++++++++++++------------
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 16af1a7f80f6..74f15592d170 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -86,7 +86,7 @@ struct j1939_priv {
 	unsigned int tp_max_packet_size;
 
 	/* lock for j1939_socks list */
-	spinlock_t j1939_socks_lock;
+	rwlock_t j1939_socks_lock;
 	struct list_head j1939_socks;
 
 	struct kref rx_kref;
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index ecff1c947d68..a6fb89fa6278 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -274,7 +274,7 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
 		return ERR_PTR(-ENOMEM);
 
 	j1939_tp_init(priv);
-	spin_lock_init(&priv->j1939_socks_lock);
+	rwlock_init(&priv->j1939_socks_lock);
 	INIT_LIST_HEAD(&priv->j1939_socks);
 
 	mutex_lock(&j1939_netdev_lock);
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 35970c25496a..6dce9d645116 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -80,16 +80,16 @@ static void j1939_jsk_add(struct j1939_priv *priv, struct j1939_sock *jsk)
 	jsk->state |= J1939_SOCK_BOUND;
 	j1939_priv_get(priv);
 
-	spin_lock_bh(&priv->j1939_socks_lock);
+	write_lock_bh(&priv->j1939_socks_lock);
 	list_add_tail(&jsk->list, &priv->j1939_socks);
-	spin_unlock_bh(&priv->j1939_socks_lock);
+	write_unlock_bh(&priv->j1939_socks_lock);
 }
 
 static void j1939_jsk_del(struct j1939_priv *priv, struct j1939_sock *jsk)
 {
-	spin_lock_bh(&priv->j1939_socks_lock);
+	write_lock_bh(&priv->j1939_socks_lock);
 	list_del_init(&jsk->list);
-	spin_unlock_bh(&priv->j1939_socks_lock);
+	write_unlock_bh(&priv->j1939_socks_lock);
 
 	j1939_priv_put(priv);
 	jsk->state &= ~J1939_SOCK_BOUND;
@@ -329,13 +329,13 @@ bool j1939_sk_recv_match(struct j1939_priv *priv, struct j1939_sk_buff_cb *skcb)
 	struct j1939_sock *jsk;
 	bool match = false;
 
-	spin_lock_bh(&priv->j1939_socks_lock);
+	read_lock_bh(&priv->j1939_socks_lock);
 	list_for_each_entry(jsk, &priv->j1939_socks, list) {
 		match = j1939_sk_recv_match_one(jsk, skcb);
 		if (match)
 			break;
 	}
-	spin_unlock_bh(&priv->j1939_socks_lock);
+	read_unlock_bh(&priv->j1939_socks_lock);
 
 	return match;
 }
@@ -344,11 +344,11 @@ void j1939_sk_recv(struct j1939_priv *priv, struct sk_buff *skb)
 {
 	struct j1939_sock *jsk;
 
-	spin_lock_bh(&priv->j1939_socks_lock);
+	read_lock_bh(&priv->j1939_socks_lock);
 	list_for_each_entry(jsk, &priv->j1939_socks, list) {
 		j1939_sk_recv_one(jsk, skb);
 	}
-	spin_unlock_bh(&priv->j1939_socks_lock);
+	read_unlock_bh(&priv->j1939_socks_lock);
 }
 
 static void j1939_sk_sock_destruct(struct sock *sk)
@@ -484,6 +484,7 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 
 		priv = j1939_netdev_start(ndev);
 		dev_put(ndev);
+
 		if (IS_ERR(priv)) {
 			ret = PTR_ERR(priv);
 			goto out_release_sock;
@@ -1078,12 +1079,12 @@ void j1939_sk_errqueue(struct j1939_session *session,
 	}
 
 	/* spread RX notifications to all sockets subscribed to this session */
-	spin_lock_bh(&priv->j1939_socks_lock);
+	read_lock_bh(&priv->j1939_socks_lock);
 	list_for_each_entry(jsk, &priv->j1939_socks, list) {
 		if (j1939_sk_recv_match_one(jsk, &session->skcb))
 			__j1939_sk_errqueue(session, &jsk->sk, type);
 	}
-	spin_unlock_bh(&priv->j1939_socks_lock);
+	read_unlock_bh(&priv->j1939_socks_lock);
 };
 
 void j1939_sk_send_loop_abort(struct sock *sk, int err)
@@ -1271,7 +1272,7 @@ void j1939_sk_netdev_event_netdown(struct j1939_priv *priv)
 	struct j1939_sock *jsk;
 	int error_code = ENETDOWN;
 
-	spin_lock_bh(&priv->j1939_socks_lock);
+	read_lock_bh(&priv->j1939_socks_lock);
 	list_for_each_entry(jsk, &priv->j1939_socks, list) {
 		jsk->sk.sk_err = error_code;
 		if (!sock_flag(&jsk->sk, SOCK_DEAD))
@@ -1279,7 +1280,7 @@ void j1939_sk_netdev_event_netdown(struct j1939_priv *priv)
 
 		j1939_sk_queue_drop_all(priv, jsk, error_code);
 	}
-	spin_unlock_bh(&priv->j1939_socks_lock);
+	read_unlock_bh(&priv->j1939_socks_lock);
 }
 
 static int j1939_sk_no_ioctlcmd(struct socket *sock, unsigned int cmd,
-- 
2.34.1

