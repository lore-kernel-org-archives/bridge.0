Return-Path: <SRS0=7oGp=3D=goodmis.org=rostedt@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 162BD81E68
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EA6BE81E63
Date: Thu, 3 Nov 2022 17:51:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Message-ID: <20221103175123.744d0f37@rorschach.local.home>
In-Reply-To: <27a6a587fee5e9172e41acd16ae1bc1f556fdbd7.camel@redhat.com>
References: <20221027150525.753064657@goodmis.org>
 <20221027150928.780676863@goodmis.org>
 <20221027155513.60b211e2@gandalf.local.home>
 <CAHk-=wjAjW2P5To82+CAM0Rx8RexQBHPTVZBWBPHyEPGm37oFA@mail.gmail.com>
 <20221027163453.383bbf8e@gandalf.local.home>
 <CAHk-=whoS+krLU7JNe=hMp2VOcwdcCdTXhdV8qqKoViwzzJWfA@mail.gmail.com>
 <20221027170720.31497319@gandalf.local.home>
 <20221027183511.66b058c4@gandalf.local.home>
 <20221028183149.2882a29b@gandalf.local.home>
 <20221028154617.3c63ba68@kernel.org>
 <27a6a587fee5e9172e41acd16ae1bc1f556fdbd7.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC][PATCH v2 19/31] timers: net: Use
 del_timer_shutdown() before freeing timer
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, linux-afs@lists.infradead.org, Menglong Dong <imagedong@tencent.com>, bridge@lists.linux-foundation.org, Jesse Brandeburg <jesse.brandeburg@intel.com>, lvs-devel@vger.kernel.org, coreteam@netfilter.org, Jakub Kicinski <kuba@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Thomas Gleixner <tglx@linutronix.de>, Mirko Lindner <mlindner@marvell.com>, linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net, Stephen Boyd <sboyd@kernel.org>, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, netfilter-devel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Pavel Begunkov <asml.silence@gmail.com>

On Sun, 30 Oct 2022 18:22:03 +0100
Paolo Abeni <pabeni@redhat.com> wrote:

> On the positive side, I think converting the sk_stop_timer in 
> inet_csk_clear_xmit_timers() should be safe and should cover the issue
> reported by Guenter

Would something like this be OK? 

[ Note, talking with Thomas Gleixner, we agreed that we are changing the
  name to: time_shutdown_sync() and timer_shutdown() (no wait version).
  I'll be posting new patches soon. ]

-- Steve

diff --git a/include/net/sock.h b/include/net/sock.h
index 22f8bab583dd..0ef58697d4e5 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2439,6 +2439,8 @@ void sk_stop_timer(struct sock *sk, struct timer_list *timer);
 
 void sk_stop_timer_sync(struct sock *sk, struct timer_list *timer);
 
+void sk_shutdown_timer(struct sock *sk, struct timer_list *timer);
+
 int __sk_queue_drop_skb(struct sock *sk, struct sk_buff_head *sk_queue,
 			struct sk_buff *skb, unsigned int flags,
 			void (*destructor)(struct sock *sk,
diff --git a/net/core/sock.c b/net/core/sock.c
index a3ba0358c77c..82124862b594 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3357,6 +3357,13 @@ void sk_stop_timer_sync(struct sock *sk, struct timer_list *timer)
 }
 EXPORT_SYMBOL(sk_stop_timer_sync);
 
+void sk_shutdown_timer(struct sock *sk, struct timer_list* timer)
+{
+	if (timer_shutdown(timer))
+		__sock_put(sk);
+}
+EXPORT_SYMBOL(sk_shutdown_timer);
+
 void sock_init_data(struct socket *sock, struct sock *sk)
 {
 	sk_init_common(sk);
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 5e70228c5ae9..71f398f51958 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -722,15 +722,15 @@ void inet_csk_clear_xmit_timers(struct sock *sk)
 
 	icsk->icsk_pending = icsk->icsk_ack.pending = 0;
 
-	sk_stop_timer(sk, &icsk->icsk_retransmit_timer);
-	sk_stop_timer(sk, &icsk->icsk_delack_timer);
-	sk_stop_timer(sk, &sk->sk_timer);
+	sk_shutdown_timer(sk, &icsk->icsk_retransmit_timer);
+	sk_shutdown_timer(sk, &icsk->icsk_delack_timer);
+	sk_shutdown_timer(sk, &sk->sk_timer);
 }
 EXPORT_SYMBOL(inet_csk_clear_xmit_timers);
 
 void inet_csk_delete_keepalive_timer(struct sock *sk)
 {
-	sk_stop_timer(sk, &sk->sk_timer);
+	sk_shutdown_timer(sk, &sk->sk_timer);
 }
 EXPORT_SYMBOL(inet_csk_delete_keepalive_timer);
 


