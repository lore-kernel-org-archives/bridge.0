Date: Wed, 13 Jan 2010 08:49:08 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20100113084908.334beff1@nehalam>
In-Reply-To: <001636c5b1ffc54228047d0e8583@google.com>
References: <20100113083058.79d521c6@nehalam>
	<001636c5b1ffc54228047d0e8583@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge]
 =?utf-8?b?UmXCoDpSZTogIFJlIDpSZTogUmUgOlJlOiBCcmlkZ2lu?=
 =?utf-8?q?g_LACP_=28802=2E3ad=29_frames_not_working?=
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jhautbois@gmail.com
Cc: bridge@lists.linux-foundation.org

On Wed, 13 Jan 2010 16:47:14 +0000
jhautbois@gmail.com wrote:

> (snip)
> > I meant they get processed locally, before that they were dropped.
> 
> > The best solution is to write an ebtables rule to forward them.
> 
> Mmh, I can understand that, but I can't see which kind of rule would do  
> that.
> Something like :
> ebtables -A FORWARDING -p 0x8809 -j ACCEPT ??
> 
> But I think this will not do anything, because it is forwarding by default.
> Or there is something I can't see :-).
> 

You need to put the rule on the local input not forwarding chain.
