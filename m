Return-Path: <cwang@twopensource.com>
MIME-Version: 1.0
In-Reply-To: <1432307939-19640-1-git-send-email-cascardo@redhat.com>
References: <1432307939-19640-1-git-send-email-cascardo@redhat.com>
Date: Fri, 22 May 2015 09:37:17 -0700
Message-ID: <CAHA+R7OzznLYc-5dsTgZ02H8Q2jG9pc4e3_Ko2F_wyfjrRJ+cA@mail.gmail.com>
From: Cong Wang <cwang@twopensource.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] [PATCH] bridge: fix parsing of MLDv2 reports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Thadeu Lima de Souza Cascardo <cascardo@redhat.com>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rik.Theys@esat.kuleuven.be, David Miller <davem@davemloft.net>

On Fri, May 22, 2015 at 8:18 AM, Thadeu Lima de Souza Cascardo
<cascardo@redhat.com> wrote:
> When more than a multicast address is present in a MLDv2 report, all but
> the first address is ignored, because the code breaks out of the loop if
> there has not been an error adding that address.
>
> This has caused failures when two guests connected through the bridge
> tried to communicate using IPv6. Neighbor discoveries would not be
> transmitted to the other guest when both used a link-local address and a
> static address.
>
> This only happens when there is a MLDv2 querier in the network.
>
> The fix will only break out of the loop when there is a failure adding a
> multicast address.
>
> The mdb before the patch:
>
> dev ovirtmgmt port vnet0 grp ff02::1:ff7d:6603 temp
> dev ovirtmgmt port vnet1 grp ff02::1:ff7d:6604 temp
> dev ovirtmgmt port bond0.86 grp ff02::2 temp
>
> After the patch:
>
> dev ovirtmgmt port vnet0 grp ff02::1:ff7d:6603 temp
> dev ovirtmgmt port vnet1 grp ff02::1:ff7d:6604 temp
> dev ovirtmgmt port bond0.86 grp ff02::fb temp
> dev ovirtmgmt port bond0.86 grp ff02::2 temp
> dev ovirtmgmt port bond0.86 grp ff02::d temp
> dev ovirtmgmt port vnet0 grp ff02::1:ff00:76 temp
> dev ovirtmgmt port bond0.86 grp ff02::16 temp
> dev ovirtmgmt port vnet1 grp ff02::1:ff00:77 temp
> dev ovirtmgmt port bond0.86 grp ff02::1:ff00:def temp
> dev ovirtmgmt port bond0.86 grp ff02::1:ffa1:40bf temp
>
> Reported-by: Rik Theys <Rik.Theys@esat.kuleuven.be>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@redhat.com>
> Tested-by: Rik Theys <Rik.Theys@esat.kuleuven.be>


Fixes:  08b202b67264 ("bridge br_multicast: IPv6 MLD support.")

Good catch!
