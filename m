Subject: Re: [Bridge] 2.4.28 oops
From: Bart De Schuymer <bdschuym@pandora.be>
In-Reply-To: <20041216111912.442cd50a@dxpl.pdx.osdl.net>
References: <41C15C9D.50102@belkam.com>
	<20041216111912.442cd50a@dxpl.pdx.osdl.net>
Content-Type: text/plain
Date: Thu, 16 Dec 2004 21:43:09 +0100
Message-Id: <1103229790.4177.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Dmitry Melekhov <dm@belkam.com>, bridge@lists.osdl.org

Op do, 16-12-2004 te 11:19 -0800, schreef Stephen Hemminger:
> On Thu, 16 Dec 2004 13:59:57 +0400
> Dmitry Melekhov <dm@belkam.com> wrote:
> 
> > Hello!
> > 
> > I don't shure I'm writing to right list, please point me to right list, 
> > if this is wrong place.
> > And I posted this message to linux-net... Sorry!
> > 
> > I run Linux as bridge (with ebtables), router and ipsec using 
> > super-freeswan/openswan.
> > 
> > ipsec interface is over br interface, there are also vlan interfaces on 
> > the same eth interfaces wich are in bridge.
> > 
> > Kernel 2.4.20 works OK, but I have kernel crash when I try to use htb 
> > qos over ipsec interfaces.
> > 
> > So I decided to move to newer kernel.
> > 
> > This is 2.4.28 from kernel org with openswan 1.0.8 and 
> > ebtables-brnf-8_vs_2.4.28. 
> > <http://prdownloads.sourceforge.net/ebtables/ebtables-brnf-8_vs_2.4.28.diff.gz?download> 
> > Could you look to this and give me an idea where is problem? I.e. this 
> > is bridge or ipsec problem or something else?
> > 
> > Thank you!
> 
> Looks like a problem in the ebtables rules, try ebtables-devel@sourceforge.net

There is an incompatibility between the ipsec and the bridge-nf patch.
Problems have been reported before. AFAIK the standard 2.4 kernel series
do not support ipsec, so I don't feel inclined to fix that issue.
Dmitry, please use the 2.6 kernel, if you can, which has native ipsec
support. If an incompatibility between ipsec and bridge-nf is present in
the 2.6 kernel, that will of course be fixed. No such problems have been
reported.

