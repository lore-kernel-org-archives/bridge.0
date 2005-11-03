Date: Thu, 3 Nov 2005 15:33:17 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Bridge question
Message-ID: <20051103153317.06e1efad@dxpl.pdx.osdl.net>
In-Reply-To: <30be90270511031517v3bbbafcfr2a46adaa18cb90d9@mail.gmail.com>
References: <DE026503646E7F40AF97BAB98334333BF0C972@uss-republic.finepoint.com>
	<30be90270511031517v3bbbafcfr2a46adaa18cb90d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Hai Wang <u2.ireland@gmail.com>
Cc: bridge@lists.osdl.org

On Thu, 3 Nov 2005 18:17:37 -0500
Hai Wang <u2.ireland@gmail.com> wrote:

>  Stephen,
> 
> Did you mean that the #255 limit is set in 2.4 Kernel, not
> > bridge-utility? I am wondering why there is such limit,
> > performance-related, or...? If I have to modify kernel 2.4 to exceed the
> > limit, can you tell me where I should look at? Any drawback if I increase
> > the limit up to 6000?
> >

Spanning tree protocol has limit on the protocol of 16 bits for port_id.
originally 8 bits were for priority and 8 bits were for port number,
but I added the cheat that vendors were using of using 2 bits of priority
for port number.

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
