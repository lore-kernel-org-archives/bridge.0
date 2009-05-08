MIME-Version: 1.0
In-Reply-To: <33821241768475@webmail63.yandex.ru>
References: <33821241768475@webmail63.yandex.ru>
Date: Fri, 8 May 2009 08:33:01 +0000
Message-ID: <fed120860905080133x21797f08ue93639859afa7360@mail.gmail.com>
From: "Srinivas M.A." <srinivas.aji@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] sigsegv from rstpd on ppc
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Butorina Lilya <lilybox@yandex.ru>
Cc: bridge@lists.linux-foundation.org

What code are you using? And from where? All the code I can find in
epoll_loop.c has things like:

for (i = 0; i < r; i++) {
    struct epoll_event_handler *p = ev[i].data.ptr;
    if (p != NULL)
      p->ref_ev = &ev[i];
}

Maybe ev[i].data.ptr is NULL and causing the crash. This can happen
when we have indicated that we don't want epoll to tell us events for
this fd anymore but an earlier event is still returned by epoll.

Another thing is that all the bridge changes needed for userspace STP
are there only in Linux 2.6.22. So you will not be able to use rstpd
on 2.6.19.

On Fri, May 8, 2009 at 7:41 AM, Butorina Lilya <lilybox@yandex.ru> wrote:
>
> Hi,
>
> I want to run RSTP on ppc_8xx target, kernel 2.6.19.
> Is there some recommendation or restriction from RSTP implementation for this condition?
>
> I have a problem:
> I ran rstpd-daemon on ppc and it dies in one minute after start with SIGSEGV exception. Debuging shows that the reason in
> epoll_list.c file , epoll_main_loop() function, one of element(ev) of epoll_event[] array:
>
> ev[i].data.ptr->ref_ev = &ev[i];
>
> This code kills rstpd.
>
> Is this known problem? Where should I find solution?
>
> Thanks.
> Liliya.
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
