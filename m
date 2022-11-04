Return-Path: <groeck7@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E691E60AE8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30BA5608D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=vkBGgKFgg4QPXCpHtMi6j0J3ZcIgUdwyTJWClmiO8n8=;
 b=ZXT4b7xGHkwhtyRx7V1geQfUresoJ3Ad36AKxZcA+hYEkLlZTMmJdsg3FLF6RZb4Bm
 /Th2KOsiFM+wv4AFPnrljoJs2GpR7KNawydYt2C5cew9YFo+qW0UidzKrk4BDuG1u7w+
 m3w563eSaiPwL3l4sGKZaD+ak6hpgQhlR7eGCpJqdUtIM7CX7IVrS9HVCezWAA8wIfI4
 tbWxHgw8jm41jK3k3dRhGJKkPfEdX95COskXHfzG/e/VIoBDLovAFvOX7zEd4Utr1gQo
 7jv8BY+ymXeC+5KaWJgeXULPlc8QwCY2a+1Wc4m/cSjP0OKV+9XQ8V5888RvdMmc7n4q
 obpw==
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 4 Nov 2022 09:14:45 -0700
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20221104161445.GA1866159@roeck-us.net>
References: <20221027163453.383bbf8e@gandalf.local.home>
 <CAHk-=whoS+krLU7JNe=hMp2VOcwdcCdTXhdV8qqKoViwzzJWfA@mail.gmail.com>
 <20221027170720.31497319@gandalf.local.home>
 <20221027183511.66b058c4@gandalf.local.home>
 <20221028183149.2882a29b@gandalf.local.home>
 <20221028154617.3c63ba68@kernel.org>
 <27a6a587fee5e9172e41acd16ae1bc1f556fdbd7.camel@redhat.com>
 <20221103175123.744d0f37@rorschach.local.home>
 <CANn89iLv9cak6_vXJG5t=Kq+eiMPdMxF8w4AAuAuFB5sOsy2zg@mail.gmail.com>
 <20221104015139.58f17730@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104015139.58f17730@rorschach.local.home>
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
Cc: Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, linux-afs@lists.infradead.org, Menglong Dong <imagedong@tencent.com>, bridge@lists.linux-foundation.org, Jesse Brandeburg <jesse.brandeburg@intel.com>, lvs-devel@vger.kernel.org, coreteam@netfilter.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Thomas Gleixner <tglx@linutronix.de>, Mirko Lindner <mlindner@marvell.com>, linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net, Stephen Boyd <sboyd@kernel.org>, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, netfilter-devel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Pavel Begunkov <asml.silence@gmail.com>

On Fri, Nov 04, 2022 at 01:51:39AM -0400, Steven Rostedt wrote:
> On Thu, 3 Nov 2022 17:00:20 -0700
> Eric Dumazet <edumazet@google.com> wrote:
> 
> >  inet_csk_clear_xmit_timers() can be called multiple times during TCP
> > socket lifetime.
> > 
> > (See tcp_disconnect(), which can be followed by another connect() ... and loop)
> > 
> > Maybe add a second parameter, or add a new
> > inet_csk_shutdown_xmit_timers() only called from tcp_v4_destroy_sock() ?
> > 
> 
> I guess.
> 
> > >
> > >  void inet_csk_delete_keepalive_timer(struct sock *sk)
> > >  {
> > > -       sk_stop_timer(sk, &sk->sk_timer);
> > > +       sk_shutdown_timer(sk, &sk->sk_timer);  
> > 
> > SO_KEEPALIVE can be called multiple times in a TCP socket lifetime,
> > on/off/on/off/...
> > 
> > I suggest leaving sk_stop_timer() here.
> > 
> > Eventually  inet_csk_clear_xmit_timers( sk, destroy=true) (or
> > inet_csk_shutdown_xmit_timers(())
> >    will  be called before the socket is destroyed.
> 
> OK. 
> 
> Guenter,
> 
> I posted a new series, but did not include this change. If you want to
> test that other series, I would suggest to at least add the first part
> of this patch, otherwise it will trigger. But we want to see if there's
> other locations of issue that we should care about.
> 

I'll run a test on the other series without change first. We'll see what
happens. If necessary I'll add [parts of] this patch and re-test, but
before doing that I would like to get a sense for the status of your
series as-is.

Thanks,
Guenter
