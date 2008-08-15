Date: Fri, 15 Aug 2008 15:03:54 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20080815150354.6fcf7510@extreme>
In-Reply-To: <30CDFF93154A1B47814BD152CC5F9201089E4C73@YTMAIL.youtravel.local>
References: <30CDFF93154A1B47814BD152CC5F9201089E4C73@YTMAIL.youtravel.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridging under vmware esx 3.0
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Elias Chatzigeorgiou <echatzigeorgiou@youtravel.com>
Cc: bridge@linuxfoundation.org

On Fri, 15 Aug 2008 00:50:05 +0300
"Elias Chatzigeorgiou" <echatzigeorgiou@youtravel.com> wrote:

> Hello,
>     I tried to setup a bridge in a (debian-based) virtual machine using esx server. I added two nics on my vm connected then in two different networks and used the bridge utility (brctl) to bridge them. I gave the bridge an ip address so that it would be visible from the network.
> 
> I can access both networks from that vm, and machines on both networks can access the vm.
> 
> BUT PACKETS from net1 do not reach net2 and vise-versa.
> 
> I have no ip/ebtable rules and /proc/sys/net/bridge/* files are set to zero.
> 
> As a last check, I used tcpdump to dump packets comming from e.g. the net1 to the attached nic (eth0) and they seem to reach only if eth0 is not part of the bridge. 
> 
> PLEASE ADVISE.
> 
> Thanks
> Elias Chatzigeorgiou

Vmware has their own bridge stuff, and is proprietary, ask them.
