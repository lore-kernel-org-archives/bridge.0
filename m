Date: Mon, 21 Jun 2004 12:59:01 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] control packet flow
Message-Id: <20040621125901.02a35463@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040621170632.13186.qmail@web53301.mail.yahoo.com>
References: <20040621170632.13186.qmail@web53301.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: hell know <sp0ck1701@yahoo.com>
Cc: bridge@lists.osdl.org

On Mon, 21 Jun 2004 10:06:32 -0700 (PDT)
hell know <sp0ck1701@yahoo.com> wrote:

> Greetings all.
>  
> I need a transparent way of selectively controlling packet flow between two network devices such that for example I can "see" [e.g. tcpdump] a packet coming into eth0, queue it, and then manually release it out eth1, one packet at a time.  See diagram below.  (Reason for doing this is to watch the behavior of the device under test to certain packets but I cannot control the speed of the packets from the traffic source so I need an intermediary to do that).
>  
> [PC/traffic initiator] -- [bridge] -- [device under test]
>  
> I've looked at nistnet, but that would only work for IP packets, and requires you to use it as a router as I understand it, which wouldn't work here.  I've also looked at IET which seemed to be what I need, but unless I'm doing something wrong it crashes very badly under RHAT 9.0 and SuSE 9.0.
>  
> Is there any simple way to write a 'hook' into bridge-utils or the kernel to do this?  Are there any other utilities anyone can point me to?
>  
> Any help would be greatly appreciated!  Thanks in advance!!!

Two ways I have used are using netfilter bridge tables (ebtables) to label
or control what goes through.  You could route it out to your application then
re-inject it.  Of course if your doing only that you probably want to use something
like tun or tap .

If you want to do things that change packet speed,
you need to look at the QoS scheduling methods for devices.
