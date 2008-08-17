Message-ID: <82b0add70808162033x67c43630wd6a1a656fb57f2cb@mail.gmail.com>
Date: Sat, 16 Aug 2008 23:33:58 -0400
From: "Joubert Berger" <joubert@berger-family.org>
In-Reply-To: <30CDFF93154A1B47814BD152CC5F9201089E4C73@YTMAIL.youtravel.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <30CDFF93154A1B47814BD152CC5F9201089E4C73@YTMAIL.youtravel.local>
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
Cc: bridge@osdl.org

Remember that you need to put the ports on the vmware switch into
promiscuous mode.

--joubert

On Thu, Aug 14, 2008 at 5:50 PM, Elias Chatzigeorgiou
<echatzigeorgiou@youtravel.com> wrote:
> Hello,
>     I tried to setup a bridge in a (debian-based) virtual machine using esx
> server. I added two nics on my vm connected then in two different networks
> and used the bridge utility (brctl) to bridge them. I gave the bridge an ip
> address so that it would be visible from the network.
>
> I can access both networks from that vm, and machines on both networks can
> access the vm.
>
> BUT PACKETS from net1 do not reach net2 and vise-versa.
>
> I have no ip/ebtable rules and /proc/sys/net/bridge/* files are set to zero.
>
> As a last check, I used tcpdump to dump packets comming from e.g. the net1
> to the attached nic (eth0) and they seem to reach only if eth0 is not part
> of the bridge.
>
> PLEASE ADVISE.
>
> Thanks
> Elias Chatzigeorgiou
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
