Date: Fri, 16 Jan 2004 11:07:52 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Freezing bridges
Message-Id: <20040116110752.1c70ff18.shemminger@osdl.org>
In-Reply-To: <1074155350.3994.16.camel@haruka>
References: <1074096593.12422.1.camel@haruka>
	<20040114124305.5a68c7c2.shemminger@osdl.org>
	<1074155350.3994.16.camel@haruka>
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
To: Jeroen Hoek <jeroen.hoek@dcf.nl>
Cc: bridge@osdl.org

On Thu, 15 Jan 2004 09:29:11 +0100
Jeroen Hoek <jeroen.hoek@dcf.nl> wrote:

> On Wed, 2004-01-14 at 21:43, Stephen Hemminger wrote:
> > Sounds like the bridge freezes, but the server doesn't really crash.
> > Is there any console output or message log when this occurs?
> > 
> > Are you running spanning tree protocol?
> > Are the machines SMP or UP?
> > What is the output of brctl show and ifconfig when the network freezes?
> 
> Well, the servers become unapproachable. Ssh fails (although ping and
> daytime/xinetd work) and attaching a monitor and keyboard to the
> physical machine shows only a blank screen instead of a loginprompt. The
> logs show nothing at all afterwards. There seems to be some life left in
> the server during these freezes, but no ssh or tunnels.
> 
> I have STP turned on on the bridges, although there is no chance of a
> networkloop. Should this be turned off?

Unless, you need to discover other bridges turn it off.
Just looking for what could disturb your system after it is running.
In 2.6 (and later 2.4) kernels STP defaults to off, to avoid potential
problems with those that don't need it.

You could try 2.6 (2.6.1) on one machine, it would at least provide information
about whether this problem has already been fixed.
