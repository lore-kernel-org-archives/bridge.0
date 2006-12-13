Date: Wed, 13 Dec 2006 10:07:53 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20061213100753.4fc7ed59@dxpl.pdx.osdl.net>
In-Reply-To: <bae22be11b2e93ffe2c4c4cc5e25d9a3@shee.org>
References: <bae22be11b2e93ffe2c4c4cc5e25d9a3@shee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Dead loop: "bridge ended up including itself"
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Moire <sec@shee.org>
Cc: bridge@osdl.org

On Tue, 12 Dec 2006 16:17:46 +0100
Moire <sec@shee.org> wrote:

> Hello List,
> 
> some time ago i already asked this, in the meanwhile i did
> not found a solution nor i have any idea why this happens.
> 
> Scenario:
> 
> Every now and then i get this urgent warning:
> 
> 1 Time(s): Dead loop on virtual device br0, fix it urgently!
> 
> Stephen Hemminger wrote (16.08.2006 20:09) this:
> > It looks like a bridge ended up including itself some how.
> 
> Its for me unclear when this happens and what trigger this.
>

Could it be the fact that sk98lin driver has some code in it that
sends spanning tree packets itself!  This crap is because the driver
has some vendor specific code to do failover on the dual port versions
of the driver.  Since SysKonnect was big in the FDDI world, I suspect
they wanted the same management features in their gigabit cards.

You have some choices:
1) use a different card
2) comment out the code in the sk98lin driver that generates and receives
   the management frames
3) use 2.6 and the skge driver that works on the same hardware.
4) backport the skge driver to 2.4.

> I would appreciate any info to some resources. For example
> a technical document covering this issue or similar.
> 
> My setup is a kernel 2.4.31 with bridge-utils 1.0.4. The box
> have three network interfaces eth[0-2]. Bridged interfaces
> are eth[1-2] (router,dmz), eth0 is my intranet.
> I use DLINK network cards with sk98lin driver.
> 
> 
> Many thanks in advance.
> 
> Best regards
> 
> C. Moire
> 
> 
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge
> 
