Date: Wed, 11 Jun 2008 08:58:59 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20080611085859.721e3917@extreme>
In-Reply-To: <E88155B5BD67CE4D87A3F1F70950B96A2FF8A8@berta.maurer-it.com>
References: <E88155B5BD67CE4D87A3F1F70950B96A2FF8A8@berta.maurer-it.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge MAC selection
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: bridge@lists.linux-foundation.org

On Wed, 11 Jun 2008 10:27:54 +0200
"Dietmar Maurer" <dietmar@proxmox.com> wrote:

> Hi all,
> 
> We provid a management plattform for virtual machines (pve.proxmox.com),
> and 
> use a bridge access the network.
> 
> Currently the system choose the lowest MAC for the purposes of STP 
> and also assigns this MAC to the bridge. This is a problem because the 
> Bridge MAC changes when we start/stop virtual machines - leading to 
> Network outage for several seconds.
> 
> Using the first (insteasd of lowest) MAC would avoid the problem. So are
> 
> There any side effects with the following patch?

Not for you. But if it got changed now, it would surprise the existing
users (change in ABI behaviour).  

So if you need a particular mac address, you can set it with other tools
(ip or ifconfig).
