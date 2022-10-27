Return-Path: <SRS0=KBNb=24=goodmis.org=rostedt@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6856F6076C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0318A605A1
Date: Thu, 27 Oct 2022 16:34:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Message-ID: <20221027163453.383bbf8e@gandalf.local.home>
In-Reply-To: <CAHk-=wjAjW2P5To82+CAM0Rx8RexQBHPTVZBWBPHyEPGm37oFA@mail.gmail.com>
References: <20221027150525.753064657@goodmis.org>
 <20221027150928.780676863@goodmis.org>
 <20221027155513.60b211e2@gandalf.local.home>
 <CAHk-=wjAjW2P5To82+CAM0Rx8RexQBHPTVZBWBPHyEPGm37oFA@mail.gmail.com>
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

On Thu, 27 Oct 2022 13:15:23 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Oct 27, 2022 at 12:55 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > I think we need to update this code to squeeze in a del_timer_shutdown() to
> > make sure that the timers are never restarted.  
> 
> So the reason the networking code does this is that it can't just do
> the old 'sync()' thing, the timers are deleted in contexts where that
> isn't valid.
> 
> Which is also afaik why the networking code does that whole "timer
> implies a refcount to the socket" and then does the
> 
>     if (del_timer(timer))
>            sock_put()
> 
> thing (ie if the del_timer failed - possibly because it was already
> running - you leave the refcount alone).

OK, so the above is assuming that the timer is always active, and
del_timer() returns if it successfully removed it (where it can call
sock_put()), but if del_timer() returns 0, that means the timer is
currently running (or about to be), so it doesn't call sock_put().

> 
> So the networking code cannot do the del_timer_shutdown() for the same
> reason it cannot do the del_timer_sync(): it can't afford to wait for
> the timer to stop running.
> 
> I suspect it needs something like a new "del_timer_shutdown_async()"
> that isn't synchronous, but does that
> 
>  - acts as del_timer in that it doesn't wait, and returns a success if
> it could just remove the pending case
> 
>  - does that "mark timer for shutdown" in that success case
> 
> or something similar.
>

What about del_timer_try_shutdown(), that if it removes the timer, it sets
the function to NULL (making it equivalent to a successful shutdown),
otherwise it does nothing. Allowing the the timer to be rearmed.

I think this would work in this case.

-- Steve

