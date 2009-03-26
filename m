Date: Wed, 25 Mar 2009 17:24:27 -0700 (PDT)
Message-Id: <20090325.172427.98374994.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090325174405.GM3437@psychotron.englab.brq.redhat.com>
References: <20090325151937.GI3437@psychotron.englab.brq.redhat.com>
	<28445.1237998713@death.nxdomain.ibm.com>
	<20090325174405.GM3437@psychotron.englab.brq.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bonding: allow bond in mode balance-alb to
 work properly in bridge -try3
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jpirko@redhat.com
Cc: bridge@lists.linux-foundation.org, netdev@vger.kernel.org, fubar@us.ibm.com, linux-kernel@vger.kernel.org, mschmidt@redhat.com, jgarzik@pobox.com, dada1@cosmosbay.com, bonding-devel@lists.sourceforge.net

From: Jiri Pirko <jpirko@redhat.com>
Date: Wed, 25 Mar 2009 18:44:05 +0100

> Wed, Mar 25, 2009 at 05:31:53PM CET, fubar@us.ibm.com wrote:
> >Jiri Pirko <jpirko@redhat.com> wrote:
> >
> >>Basically here's what's going on. In every mode, bonding interface uses the same
> >>mac address for all enslaved devices. Except for mode balance-alb. 
> >
> >	I think you mean "only balance-alb will simultaneously use
> >multiple MAC addresses across different slaves."  Yes?
> Yes I do. I will refolmulate the phrase and repost the patch if you want...

I'll let you guys discuss this some more.

It looks like we could have some more tweaks before this patch is
finalized.
