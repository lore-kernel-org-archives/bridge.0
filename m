Return-Path: <SRS0=KBNb=24=goodmis.org=rostedt@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5FE486068F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 24BE8605A1
Date: Thu, 27 Oct 2022 17:07:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Message-ID: <20221027170720.31497319@gandalf.local.home>
In-Reply-To: <CAHk-=whoS+krLU7JNe=hMp2VOcwdcCdTXhdV8qqKoViwzzJWfA@mail.gmail.com>
References: <20221027150525.753064657@goodmis.org>
 <20221027150928.780676863@goodmis.org>
 <20221027155513.60b211e2@gandalf.local.home>
 <CAHk-=wjAjW2P5To82+CAM0Rx8RexQBHPTVZBWBPHyEPGm37oFA@mail.gmail.com>
 <20221027163453.383bbf8e@gandalf.local.home>
 <CAHk-=whoS+krLU7JNe=hMp2VOcwdcCdTXhdV8qqKoViwzzJWfA@mail.gmail.com>
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

On Thu, 27 Oct 2022 13:48:54 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Oct 27, 2022 at 1:34 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > What about del_timer_try_shutdown(), that if it removes the timer, it sets
> > the function to NULL (making it equivalent to a successful shutdown),
> > otherwise it does nothing. Allowing the the timer to be rearmed.  
> 
> Sounds sane to me and should work, but as mentioned, I think the
> networking people need to say "yeah" too.
> 
> And maybe that function can also disallow any future re-arming even
> for the case where the timer couldn't be actively removed.

Well, I think this current use case will break if we prevent the timer from
being rearmed or run again if it's not found. But as you said, the
networking folks need to confirm or deny it.

The fact that it does the sock_put() when it removes the timer makes me
think that it can be called again, and we shouldn't prevent that from
happening.

The debug code will let us know too, as it only "frees" it for freeing if
it deactivated the timer and shut it down.

> 
> So any *currently* active timer wouldn't be waited for (either because
> locking may make that a deadlock situation, or simply due to
> performance issues), but at least it would guarantee that no new timer
> activations can happen.
> 
> Because I do like the whole notion of "timer has been shutdown and
> cannot be used as a timer any more without re-initializing it" being a
> real state - even for a timer that may be "currently in flight".
> 
> So this all sounds very worthwhile to me, but I'm not surprised that
> we have code that then knows about all the subtleties of "del_timer()
> might still have a running timer" and actually take advantage of it
> (where "advantage" is likely more of a "deal with the complexities"
> rather than anything really positive ;)

Good to hear. This has been a thorn in our side as we keep hitting these
crashes in the timer code that look like a timer was freed before it
triggered.

> 
> And those existing subtle users might want particular semantics to at
> least make said complexities easier.
> 

Yeah, as someone told me recently, "If you let them play long enough without
setting out the rules, they will take advantage of everything and it will be
extremely hard to get them back in order".

-- Steve

