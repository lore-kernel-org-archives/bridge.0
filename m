Return-Path: <SRS0=6An1=25=goodmis.org=rostedt@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 46A9081775
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D74881753
Date: Fri, 28 Oct 2022 18:31:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Message-ID: <20221028183149.2882a29b@gandalf.local.home>
In-Reply-To: <20221027183511.66b058c4@gandalf.local.home>
References: <20221027150525.753064657@goodmis.org>
 <20221027150928.780676863@goodmis.org>
 <20221027155513.60b211e2@gandalf.local.home>
 <CAHk-=wjAjW2P5To82+CAM0Rx8RexQBHPTVZBWBPHyEPGm37oFA@mail.gmail.com>
 <20221027163453.383bbf8e@gandalf.local.home>
 <CAHk-=whoS+krLU7JNe=hMp2VOcwdcCdTXhdV8qqKoViwzzJWfA@mail.gmail.com>
 <20221027170720.31497319@gandalf.local.home>
 <20221027183511.66b058c4@gandalf.local.home>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, linux-afs@lists.infradead.org, Menglong Dong <imagedong@tencent.com>, bridge@lists.linux-foundation.org, Jesse Brandeburg <jesse.brandeburg@intel.com>, lvs-devel@vger.kernel.org, coreteam@netfilter.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Guenter Roeck <linux@roeck-us.net>, Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Thomas Gleixner <tglx@linutronix.de>, Mirko Lindner <mlindner@marvell.com>, linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net, Stephen Boyd <sboyd@kernel.org>, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, netfilter-devel@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>


Could someone from networking confirm (or deny) that the timer being
removed in sk_stop_timer() will no longer be used even if del_timer()
returns false?

net/core/sock.c:

void sk_stop_timer(struct sock *sk, struct timer_list* timer)
{
	if (del_timer(timer))
		__sock_put(sk);
}

If this is the case, then I'll add the following interface:

   del_timer_sync_shutdown() // the common case which syncs

   del_timer_shutdown() // the uncommon case, that returns immediately
                        // used for those cases that add extra code to
                        // handle it, like sk_stop_timer()


Which has the same semantics as del_timer_sync() and del_timer()
respectively, but will prevent the timer from being rearmed again.

This way we can convert the sk_stop_timer() to:

void sk_stop_timer(struct sock *sk, struct timer_list* timer)
{
	if (del_timer_shutdown(timer))
		__sock_put(sk);
}


We can also add the del_timer_shutdown() to other locations that need to
put a timer into a shutdown state before freeing, and where it's in a
context that can not call del_timer_sync_shutdown().

-- Steve
