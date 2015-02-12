Return-Path: <vvs@parallels.com>
Message-ID: <54DC9614.9060502@parallels.com>
Date: Thu, 12 Feb 2015 15:01:24 +0300
From: Vasily Averin <vvs@parallels.com>
MIME-Version: 1.0
References: <1378253619-23918-1-git-send-email-linus.luessing@web.de>
	<54D9C4ED.6040601@parallels.com> <20150210114428.GK2489@odroid>
	<54DA0EAD.60002@parallels.com> <20150212114117.GC3665@odroid>
In-Reply-To: <20150212114117.GC3665@odroid>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] bride: IPv6 multicast snooping enhancements
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?B?TGludXMgTMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Cong Wang <amwang@redhat.com>

On 12.02.2015 14:41, Linus Lüssing wrote:
> On Tue, Feb 10, 2015 at 04:59:09PM +0300, Vasily Averin wrote:
>> I'm trying to fix ICMPv6 processing broken in OpenVZ after rebase to last RHEL6u6 kernel.
>> After some unclear manipulation bridge begins to forward icmp6 NS (fe02::1) into wrong port,
>> and at present I do not found the reason of this failure.
> 
> fe02::1 seems uncommon for ICMPv6 NS messages. Would you mind
> making some dumps for ~10 minutes with tcpdump on all bridge ports
> and the bridge interface itself with a filter "icmp6" and uploading the
> result somewhere?
> 
> Also provide a dump from "bridge mdb show dev $bridge" please (if
> possible - not sure whether that's available on the ancient 2.6.32
> kernel as used on RHEL6u6).

Thank you, "bridge mdb show" helps me to find an external router.

Therefore bridge forwarded all locally generated multicasts to external port.
Then forwarded messages was lost or was filtered or 
just incorrectly processed, but in any case they never returned back.

So as far as I understand bridge itself works correctly, 
it isn't responsible for external troubles.

Thank you,
	Vasily Averin
