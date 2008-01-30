Date: Wed, 30 Jan 2008 14:22:22 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] Bridge not functional after disconnect / connect
Message-ID: <20080130142222.1ce7f72f@deepthought>
In-Reply-To: <994021.28860.qm@web60421.mail.yahoo.com>
References: <994021.28860.qm@web60421.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Alex Shnitman <alexta69@yahoo.com>
Cc: bridge@lists.linux-foundation.org

On Wed, 30 Jan 2008 14:15:11 -0800 (PST)
Alex Shnitman <alexta69@yahoo.com> wrote:

> Hi,
> 
> I have two NICs on my machine, one connected to a router and is always up, and the other connected back-to-back to a laptop, and this one I disconnect and connect all the time. I created a bridge on top of these two interfaces, and it functions fine, except when I disconnect and connect the laptop, I have to remove it from the bridge and add it back before it starts bridging! In other words, I need to do "brctl delif br0 eth0; brctl addif br0 eth0".
> 
> The output of "brctl showmacs br0" and "brctl showstp br0" looks the same and perfectly correct before the removal/adding and after it. From playing around with Wireshark it seems to me that before delif/addif only broadcasts are received from the laptop; unicast packets do not appear there. I got all zeros in /proc/sys/net/bridge/*. It looks like everything is configured correctly.
> 
> Any idea at all why I see this behavior? Any tips as to how I might debug it?
> 
> The kernel I'm running is 2.6.18 from Debian Etch.

What hardware? There were many fixes since that old kernel.

-- 
Stephen Hemminger <stephen.hemminger@vyatta.com>
