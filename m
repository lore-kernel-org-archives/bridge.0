Return-Path: <ore@pengutronix.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5AD6D409A9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 920F4409A7
Date: Sun, 23 Jul 2023 17:41:05 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <20230723154105.GB17320@pengutronix.de>
References: <20230704064710.3189-1-astrajoan@yahoo.com>
 <20230721162226.8639-1-astrajoan@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230721162226.8639-1-astrajoan@yahoo.com>
Subject: Re: [Bridge] [PATCH] can: j1939: prevent deadlock by changing
 j1939_socks_lock to rwlock
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ziqi Zhao <astrajoan@yahoo.com>
Cc: ivan.orlov0322@gmail.com, edumazet@google.com, syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com, socketcan@hartkopp.net, bridge@lists.linux-foundation.org, nikolay@nvidia.com, syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, arnd@arndb.de, syzkaller-bugs@googlegroups.com, mudongliangabcd@gmail.com, linux-can@vger.kernel.org, mkl@pengutronix.de, skhan@linuxfoundation.org, robin@protonic.nl, linux-kernel@vger.kernel.org, linux@rempel-privat.de, kernel@pengutronix.de, netdev@vger.kernel.org, davem@davemloft.net

Hi,

Thank you for you patch. Right now I'm on vacation, I'll to take a look
on it as soon as possible. If i do not response for more then 3 weeks,
please ping me.

On Fri, Jul 21, 2023 at 09:22:26AM -0700, Ziqi Zhao wrote:
> The following 3 locks would race against each other, causing the
> deadlock situation in the Syzbot bug report:
> 
> - j1939_socks_lock
> - active_session_list_lock
> - sk_session_queue_lock
> 
> A reasonable fix is to change j1939_socks_lock to an rwlock, since in
> the rare situations where a write lock is required for the linked list
> that j1939_socks_lock is protecting, the code does not attempt to
> acquire any more locks. This would break the circular lock dependency,
> where, for example, the current thread already locks j1939_socks_lock
> and attempts to acquire sk_session_queue_lock, and at the same time,
> another thread attempts to acquire j1939_socks_lock while holding
> sk_session_queue_lock.
> 
> NOTE: This patch along does not fix the unregister_netdevice bug
> reported by Syzbot; instead, it solves a deadlock situation to prepare
> for one or more further patches to actually fix the Syzbot bug, which
> appears to be a reference counting problem within the j1939 codebase.
> 
> Reported-by: syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com
> Signed-off-by: Ziqi Zhao <astrajoan@yahoo.com>
> ---
>  net/can/j1939/j1939-priv.h |  2 +-
>  net/can/j1939/main.c       |  2 +-
>  net/can/j1939/socket.c     | 25 +++++++++++++------------
>  3 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
> index 16af1a7f80f6..74f15592d170 100644
> --- a/net/can/j1939/j1939-priv.h
> +++ b/net/can/j1939/j1939-priv.h
> @@ -86,7 +86,7 @@ struct j1939_priv {
>  	unsigned int tp_max_packet_size;
>  
>  	/* lock for j1939_socks list */
> -	spinlock_t j1939_socks_lock;
> +	rwlock_t j1939_socks_lock;
>  	struct list_head j1939_socks;
>  
>  	struct kref rx_kref;
> diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
> index ecff1c947d68..a6fb89fa6278 100644
> --- a/net/can/j1939/main.c
> +++ b/net/can/j1939/main.c
> @@ -274,7 +274,7 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
>  		return ERR_PTR(-ENOMEM);
>  
>  	j1939_tp_init(priv);
> -	spin_lock_init(&priv->j1939_socks_lock);
> +	rwlock_init(&priv->j1939_socks_lock);
>  	INIT_LIST_HEAD(&priv->j1939_socks);
>  
>  	mutex_lock(&j1939_netdev_lock);
> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
> index feaec4ad6d16..a8b981dc2065 100644
> --- a/net/can/j1939/socket.c
> +++ b/net/can/j1939/socket.c
> @@ -80,16 +80,16 @@ static void j1939_jsk_add(struct j1939_priv *priv, struct j1939_sock *jsk)
>  	jsk->state |= J1939_SOCK_BOUND;
>  	j1939_priv_get(priv);
>  
> -	spin_lock_bh(&priv->j1939_socks_lock);
> +	write_lock_bh(&priv->j1939_socks_lock);
>  	list_add_tail(&jsk->list, &priv->j1939_socks);
> -	spin_unlock_bh(&priv->j1939_socks_lock);
> +	write_unlock_bh(&priv->j1939_socks_lock);
>  }
>  
>  static void j1939_jsk_del(struct j1939_priv *priv, struct j1939_sock *jsk)
>  {
> -	spin_lock_bh(&priv->j1939_socks_lock);
> +	write_lock_bh(&priv->j1939_socks_lock);
>  	list_del_init(&jsk->list);
> -	spin_unlock_bh(&priv->j1939_socks_lock);
> +	write_unlock_bh(&priv->j1939_socks_lock);
>  
>  	j1939_priv_put(priv);
>  	jsk->state &= ~J1939_SOCK_BOUND;
> @@ -329,13 +329,13 @@ bool j1939_sk_recv_match(struct j1939_priv *priv, struct j1939_sk_buff_cb *skcb)
>  	struct j1939_sock *jsk;
>  	bool match = false;
>  
> -	spin_lock_bh(&priv->j1939_socks_lock);
> +	read_lock_bh(&priv->j1939_socks_lock);
>  	list_for_each_entry(jsk, &priv->j1939_socks, list) {
>  		match = j1939_sk_recv_match_one(jsk, skcb);
>  		if (match)
>  			break;
>  	}
> -	spin_unlock_bh(&priv->j1939_socks_lock);
> +	read_unlock_bh(&priv->j1939_socks_lock);
>  
>  	return match;
>  }
> @@ -344,11 +344,11 @@ void j1939_sk_recv(struct j1939_priv *priv, struct sk_buff *skb)
>  {
>  	struct j1939_sock *jsk;
>  
> -	spin_lock_bh(&priv->j1939_socks_lock);
> +	read_lock_bh(&priv->j1939_socks_lock);
>  	list_for_each_entry(jsk, &priv->j1939_socks, list) {
>  		j1939_sk_recv_one(jsk, skb);
>  	}
> -	spin_unlock_bh(&priv->j1939_socks_lock);
> +	read_unlock_bh(&priv->j1939_socks_lock);
>  }
>  
>  static void j1939_sk_sock_destruct(struct sock *sk)
> @@ -484,6 +484,7 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>  
>  		priv = j1939_netdev_start(ndev);
>  		dev_put(ndev);
> +
>  		if (IS_ERR(priv)) {
>  			ret = PTR_ERR(priv);
>  			goto out_release_sock;
> @@ -1078,12 +1079,12 @@ void j1939_sk_errqueue(struct j1939_session *session,
>  	}
>  
>  	/* spread RX notifications to all sockets subscribed to this session */
> -	spin_lock_bh(&priv->j1939_socks_lock);
> +	read_lock_bh(&priv->j1939_socks_lock);
>  	list_for_each_entry(jsk, &priv->j1939_socks, list) {
>  		if (j1939_sk_recv_match_one(jsk, &session->skcb))
>  			__j1939_sk_errqueue(session, &jsk->sk, type);
>  	}
> -	spin_unlock_bh(&priv->j1939_socks_lock);
> +	read_unlock_bh(&priv->j1939_socks_lock);
>  };
>  
>  void j1939_sk_send_loop_abort(struct sock *sk, int err)
> @@ -1271,7 +1272,7 @@ void j1939_sk_netdev_event_netdown(struct j1939_priv *priv)
>  	struct j1939_sock *jsk;
>  	int error_code = ENETDOWN;
>  
> -	spin_lock_bh(&priv->j1939_socks_lock);
> +	read_lock_bh(&priv->j1939_socks_lock);
>  	list_for_each_entry(jsk, &priv->j1939_socks, list) {
>  		jsk->sk.sk_err = error_code;
>  		if (!sock_flag(&jsk->sk, SOCK_DEAD))
> @@ -1279,7 +1280,7 @@ void j1939_sk_netdev_event_netdown(struct j1939_priv *priv)
>  
>  		j1939_sk_queue_drop_all(priv, jsk, error_code);
>  	}
> -	spin_unlock_bh(&priv->j1939_socks_lock);
> +	read_unlock_bh(&priv->j1939_socks_lock);
>  }
>  
>  static int j1939_sk_no_ioctlcmd(struct socket *sock, unsigned int cmd,
> -- 
> 2.34.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
