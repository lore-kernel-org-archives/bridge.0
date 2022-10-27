Return-Path: <torvalds@linuxfoundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12DBE410C1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14D48410B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PkxtUHaGFDycP6D2luIHLSXJkXOzlvpiMUNbGq0VIDw=;
 b=AiYRsbNPUrZt3HPq+xtJfDrvafoV3sgbBvDsYvDt8alNybjtz3OkR1xymRkE3QILqj
 mmJ4n9e+K/PVts3cQ2eJ5htk2mJ+mPxzhWMdsaeW6GINZP2CIccvVT49FekPjg7PRFXI
 92WGHwoPAVqBkaMzcdjnmCw5MEE1uFvTm34eA=
MIME-Version: 1.0
References: <20221027150525.753064657@goodmis.org>
 <20221027150928.780676863@goodmis.org>
 <20221027155513.60b211e2@gandalf.local.home>
In-Reply-To: <20221027155513.60b211e2@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 27 Oct 2022 13:15:23 -0700
Message-ID: <CAHk-=wjAjW2P5To82+CAM0Rx8RexQBHPTVZBWBPHyEPGm37oFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, linux-afs@lists.infradead.org, Menglong Dong <imagedong@tencent.com>, bridge@lists.linux-foundation.org, Jesse Brandeburg <jesse.brandeburg@intel.com>, lvs-devel@vger.kernel.org, coreteam@netfilter.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Guenter Roeck <linux@roeck-us.net>, Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Thomas Gleixner <tglx@linutronix.de>, Mirko Lindner <mlindner@marvell.com>, linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net, Stephen Boyd <sboyd@kernel.org>, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, netfilter-devel@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>

On Thu, Oct 27, 2022 at 12:55 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I think we need to update this code to squeeze in a del_timer_shutdown() to
> make sure that the timers are never restarted.

So the reason the networking code does this is that it can't just do
the old 'sync()' thing, the timers are deleted in contexts where that
isn't valid.

Which is also afaik why the networking code does that whole "timer
implies a refcount to the socket" and then does the

    if (del_timer(timer))
           sock_put()

thing (ie if the del_timer failed - possibly because it was already
running - you leave the refcount alone).

So the networking code cannot do the del_timer_shutdown() for the same
reason it cannot do the del_timer_sync(): it can't afford to wait for
the timer to stop running.

I suspect it needs something like a new "del_timer_shutdown_async()"
that isn't synchronous, but does that

 - acts as del_timer in that it doesn't wait, and returns a success if
it could just remove the pending case

 - does that "mark timer for shutdown" in that success case

or something similar.

But the networking people will know better.

               Linus
