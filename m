Subject: Re: [Bridge] Freezing bridges
From: Jeroen Hoek <jeroen.hoek@dcf.nl>
In-Reply-To: <20040114124305.5a68c7c2.shemminger@osdl.org>
References: <1074096593.12422.1.camel@haruka>
	<20040114124305.5a68c7c2.shemminger@osdl.org>
Content-Type: text/plain
Message-Id: <1074155350.3994.16.camel@haruka>
Mime-Version: 1.0
Date: Thu, 15 Jan 2004 09:29:11 +0100
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
Cc: bridge@osdl.org

On Wed, 2004-01-14 at 21:43, Stephen Hemminger wrote:
> Sounds like the bridge freezes, but the server doesn't really crash.
> Is there any console output or message log when this occurs?
> 
> Are you running spanning tree protocol?
> Are the machines SMP or UP?
> What is the output of brctl show and ifconfig when the network freezes?

Well, the servers become unapproachable. Ssh fails (although ping and
daytime/xinetd work) and attaching a monitor and keyboard to the
physical machine shows only a blank screen instead of a loginprompt. The
logs show nothing at all afterwards. There seems to be some life left in
the server during these freezes, but no ssh or tunnels.

I have STP turned on on the bridges, although there is no chance of a
networkloop. Should this be turned off?

All machines have a single Pentium III 1GHz CPU and 256mb of SDRAM. Each
has four Intel NICs, using the e100 driver. The eepro driver has
significant MTU issues so it is not an option in this case.

Kind regards,

ing. Jeroen Hoek

