Date: Thu, 17 Nov 2005 09:10:10 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20051117091010.186d0420@dxpl.pdx.osdl.net>
In-Reply-To: <47ef310511170301sc3dac74x1a14bd75f8c8bdb6@mail.gmail.com>
References: <47ef310511170301sc3dac74x1a14bd75f8c8bdb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: Linux bridge on linksys WRT54GS running OpenWRT
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Sebastien Chaumontet <sebastien@chaumontet.net>
Cc: =?UTF-8?B?TWlja2HDq2w=?= Hoerdt <hoerdt@clarinet.u-strasbg.fr>, bridge@lists.osdl.org, Olaf Menzel <olaf.menzel@fokus.fraunhofer.de>

On Thu, 17 Nov 2005 12:01:47 +0100
Sebastien Chaumontet <sebastien@chaumontet.net> wrote:

> Hi all,
> 
> Following the this thread opened by Olaf
> (http://lists.osdl.org/mailman/htdig/bridge/2005-July/001026.html)
> 
> We performed some more tests with and without wireless. Latest one was
> to remove CONFIG_BRIDGE_NETFILTER from kernel option at compilation
> time on a 2.6.14-rc4. This change solved the problem and the bridge
> was able to forward correctly MLD packets (IPv6 multicast subscription
> message).
> 
> So the problem seems to be related to etables. Something related to
> IP/SABOTAGE in br_netfilter.c?

The netfilter interface is really the responsibility of the ebtables
project. I maintain the hooks for them, but what happens in the filters
is their doing.

> As specified on the bridge FAQ "The bridge knows nothing about
> protocols, it only sees Ethernet frames." it should not look at the
> content of the packet.
> 
> Most of performed tests are described on
> http://dbeacon.innerghost.net/LinuxBridgingMulticast
> 

If you want put a link on http://linux-net.osdl.org on the bridge page.



-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
